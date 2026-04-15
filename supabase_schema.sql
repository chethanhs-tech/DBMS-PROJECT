-- 1. CLEANUP (Optional)
-- Drop tables if you are refreshing the schema.
-- drop table if exists orders;
-- drop table if exists alerts;
-- drop table if exists transactions;
-- drop table if exists products;
-- drop table if exists suppliers;
-- drop table if exists profiles;

-- 2. CREATE TABLES
CREATE TABLE IF NOT EXISTS profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    name TEXT,
    email TEXT,
    role TEXT DEFAULT 'staff' CHECK (role IN ('admin', 'staff')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE IF NOT EXISTS suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    supplier_name TEXT NOT NULL,
    contact TEXT,
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_name TEXT NOT NULL,
    sku TEXT UNIQUE NOT NULL,
    category TEXT,
    quantity INTEGER DEFAULT 0 CHECK (quantity >= 0),
    price NUMERIC(10, 2) NOT NULL,
    reorder_level INTEGER DEFAULT 10,
    supplier_id UUID REFERENCES suppliers(id) ON DELETE SET NULL,
    image_url TEXT,
    unit TEXT DEFAULT 'unit',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE IF NOT EXISTS transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    transaction_type TEXT NOT NULL CHECK (transaction_type IN ('purchase', 'sale')),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- SaaS UPGRADE: Orders Table for Payment Simulation Output
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    total_amount NUMERIC(12, 2) NOT NULL,
    payment_method TEXT NOT NULL CHECK (payment_method IN ('upi', 'card', 'netbanking')),
    status TEXT DEFAULT 'completed' CHECK (status IN ('pending', 'completed', 'failed')),
    invoice_number TEXT UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE IF NOT EXISTS alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    alert_type TEXT NOT NULL,
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'resolved')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

---------------------------------------------------------------------
-- 3. AUTOMATIC PROFILE CREATION ON SIGNUP
---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, email, name, role)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'full_name', 'Unknown User'),
    'staff' -- Default role explicitly set to staff
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists to prevent duplication
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

---------------------------------------------------------------------
-- 4. SMART INVENTORY TRANSACTIONS TRIGGER 
---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_stock_on_transaction()
RETURNS trigger AS $$
DECLARE
    current_qty INTEGER;
BEGIN
    SELECT quantity INTO current_qty FROM products WHERE id = NEW.product_id;

    IF NEW.transaction_type = 'sale' THEN
        IF current_qty - NEW.quantity < 0 THEN
            RAISE EXCEPTION 'Insufficient stock. Cannot complete sale. Current stock: %', current_qty;
        END IF;
        UPDATE products SET quantity = quantity - NEW.quantity WHERE id = NEW.product_id;
    ELSIF NEW.transaction_type = 'purchase' THEN
        UPDATE products SET quantity = quantity + NEW.quantity WHERE id = NEW.product_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS transaction_stock_update_trigger ON transactions;

CREATE TRIGGER transaction_stock_update_trigger
  BEFORE INSERT ON transactions
  FOR EACH ROW EXECUTE PROCEDURE update_stock_on_transaction();

---------------------------------------------------------------------
-- SaaS Order Trigger (When Order is placed, trigger a sale transaction automagically)
---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION sync_order_to_transaction()
RETURNS trigger AS $$
BEGIN
    IF NEW.status = 'completed' THEN
        -- Safely record a mirrored transaction mapping stock logic backwards
        INSERT INTO transactions (product_id, transaction_type, quantity, user_id)
        VALUES (NEW.product_id, 'sale', NEW.quantity, NEW.user_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS order_to_transaction_trigger ON orders;

CREATE TRIGGER order_to_transaction_trigger
  AFTER INSERT ON orders
  FOR EACH ROW EXECUTE PROCEDURE sync_order_to_transaction();


---------------------------------------------------------------------
-- 5. SMART ALERTS TRIGGER
---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_low_stock() 
RETURNS trigger AS $$
DECLARE
    active_alert_count INT;
BEGIN
    IF NEW.quantity <= NEW.reorder_level THEN
        SELECT count(*) INTO active_alert_count 
        FROM alerts 
        WHERE product_id = NEW.id AND status = 'active' AND alert_type = 'low_stock';
        
        IF active_alert_count = 0 THEN
            INSERT INTO alerts (product_id, alert_type, status)
            VALUES (NEW.id, 'low_stock', 'active');
        END IF;
    ELSE
        UPDATE alerts SET status = 'resolved' WHERE product_id = NEW.id AND alert_type = 'low_stock' AND status = 'active';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS products_check_low_stock_trigger ON products;

CREATE TRIGGER products_check_low_stock_trigger
  AFTER UPDATE OF quantity ON products
  FOR EACH ROW EXECUTE PROCEDURE check_low_stock();

---------------------------------------------------------------------
-- 6. ENABLE ROW LEVEL SECURITY (RLS)
---------------------------------------------------------------------

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

---------------------------------------------------------------------
-- 7. RLS POLICIES
---------------------------------------------------------------------
-- Profiles
CREATE POLICY "Users can read their own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Admins can read all profiles" ON profiles FOR SELECT USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "Admins can update profiles" ON profiles FOR UPDATE USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- Suppliers
CREATE POLICY "Staff can read suppliers" ON suppliers FOR SELECT USING (true);
CREATE POLICY "Admins have full access to suppliers" ON suppliers FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- Products
CREATE POLICY "Staff can read products" ON products FOR SELECT USING (true);
CREATE POLICY "Admins have full access to products" ON products FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- Transactions
CREATE POLICY "Staff can read transactions" ON transactions FOR SELECT USING (true);
CREATE POLICY "Staff can create transactions" ON transactions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Admins have full access to transactions" ON transactions FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- Alerts
CREATE POLICY "Staff can read alerts" ON alerts FOR SELECT USING (true);
CREATE POLICY "Admins have full access to alerts" ON alerts FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- Orders
CREATE POLICY "Staff can read orders" ON orders FOR SELECT USING (true);
CREATE POLICY "Staff can insert orders" ON orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Admins have full access to orders" ON orders FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));


---------------------------------------------------------------------
-- 8. DASHBOARD VIEWS
---------------------------------------------------------------------
CREATE OR REPLACE VIEW dashboard_stats AS
SELECT
  (SELECT COUNT(*) FROM products) as total_products,
  (SELECT COUNT(*) FROM products WHERE quantity <= reorder_level) as low_stock_items,
  (SELECT COALESCE(SUM(quantity), 0) FROM transactions WHERE transaction_type = 'sale') as total_sales,
  (SELECT COALESCE(SUM(total_amount), 0) FROM orders) as gross_revenue;


---------------------------------------------------------------------
-- 9. POPULATION DATA (Grocery Items Seed)
---------------------------------------------------------------------

-- Insert base suppliers
INSERT INTO suppliers (supplier_name, contact, address) VALUES
('Fresh Farms Co.', 'supply@freshfarms.in', 'Farmville, India'),
('Dairy & Pantry Ltd', 'contact@dvpantry.in', 'City Center, India')
ON CONFLICT DO NOTHING;

-- Insert Grocery Products
DO $$
DECLARE
    farm_id UUID;
    pantry_id UUID;
BEGIN
    SELECT id INTO farm_id FROM suppliers WHERE supplier_name = 'Fresh Farms Co.' LIMIT 1;
    SELECT id INTO pantry_id FROM suppliers WHERE supplier_name = 'Dairy & Pantry Ltd' LIMIT 1;

    IF (SELECT count(*) FROM products) < 5 THEN
        INSERT INTO products (product_name, sku, category, quantity, price, reorder_level, unit, supplier_id, image_url)
        VALUES 
        -- Fresh Fruits & Vegetables
        ('Fresh Apples (Fuji)', 'FRU-APP-01', 'Fresh Produce', 100, 150.00, 20, '1kg', farm_id, 'https://ui-avatars.com/api/?name=Apples&background=E53935&color=fff'),
        ('Bananas (Robusta)', 'FRU-BAN-01', 'Fresh Produce', 150, 60.00, 30, '1kg', farm_id, 'https://ui-avatars.com/api/?name=Bananas&background=FDD835&color=fff'),
        ('Tomatoes (Local)', 'VEG-TOM-01', 'Fresh Produce', 200, 40.00, 50, '1kg', farm_id, 'https://ui-avatars.com/api/?name=Tomatoes&background=D32F2F&color=fff'),
        ('Potatoes (Agra)', 'VEG-POT-01', 'Fresh Produce', 300, 30.00, 50, '1kg', farm_id, 'https://ui-avatars.com/api/?name=Potatoes&background=FBC02D&color=fff'),
        ('Organic Spinach', 'VEG-SPI-01', 'Fresh Produce', 50, 45.00, 10, '250g', farm_id, 'https://ui-avatars.com/api/?name=Spinach&background=388E3C&color=fff'),
        
        -- Dairy & Alternatives
        ('Whole Milk (Amul)', 'DAI-MIL-01', 'Dairy & Alternatives', 120, 66.00, 20, '1L', pantry_id, 'https://ui-avatars.com/api/?name=Milk&background=1976D2&color=fff'),
        ('Almond Milk (Unsweetened)', 'DAI-ALM-01', 'Dairy & Alternatives', 40, 300.00, 10, '1L', pantry_id, 'https://ui-avatars.com/api/?name=Almond-Milk&background=8D6E63&color=fff'),
        ('Farm Fresh Butter', 'DAI-BUT-01', 'Dairy & Alternatives', 80, 250.00, 15, '500g', pantry_id, 'https://ui-avatars.com/api/?name=Butter&background=FFF176&color=333'),

        -- Pantry Staples
        ('Basmati Rice (Premium)', 'PAN-RIC-01', 'Pantry Staples', 200, 180.00, 50, '1kg', pantry_id, 'https://ui-avatars.com/api/?name=Rice&background=E0E0E0&color=333'),
        ('Whole Wheat Flour (Aashirvaad)', 'PAN-WHE-01', 'Pantry Staples', 150, 220.00, 40, '5kg', pantry_id, 'https://ui-avatars.com/api/?name=Wheat&background=795548&color=fff'),
        ('Cold Pressed Olive Oil', 'PAN-OLI-01', 'Pantry Staples', 60, 850.00, 15, '1L', pantry_id, 'https://ui-avatars.com/api/?name=Olive&background=CDDC39&color=333'),
        
        -- Snacks & Beverages
        ('Potato Chips (Salted)', 'SNA-CHI-01', 'Snacks & Beverages', 100, 50.00, 20, '150g', pantry_id, 'https://ui-avatars.com/api/?name=Chips&background=FF9800&color=fff'),
        ('Green Tea (Organic)', 'SNA-TEA-01', 'Snacks & Beverages', 90, 240.00, 15, '100g', pantry_id, 'https://ui-avatars.com/api/?name=Green-Tea&background=4CAF50&color=fff'),
        ('Dark Chocolate (70% Cocoa)', 'SNA-CHO-01', 'Snacks & Beverages', 120, 150.00, 20, '100g', pantry_id, 'https://ui-avatars.com/api/?name=Chocolate&background=3E2723&color=fff')
        ON CONFLICT DO NOTHING;
    END IF;
END $$;

---------------------------------------------------------------------
-- 10. CLOUD STORAGE BUCKETS
---------------------------------------------------------------------

-- Create standard buckets for the architecture
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types) 
VALUES 
  ('prod-grocery-public', 'prod-grocery-public', true, 5242880, '{"image/jpeg","image/png","image/webp","image/svg+xml"}'),
  ('prod-receipts-private', 'prod-receipts-private', false, 10485760, '{"application/pdf","image/jpeg","image/png"}')
ON CONFLICT (id) DO NOTHING;

-- Enable RLS on storage objects
-- NOTE: In Supabase, storage.objects inherently has RLS enabled, we just need to add policies.

-- Public Bucket Policies
CREATE POLICY "Public items are viewable by everyone" ON storage.objects 
  FOR SELECT USING (bucket_id = 'prod-grocery-public');

CREATE POLICY "Admins can manage public items" ON storage.objects 
  FOR ALL USING (
    bucket_id = 'prod-grocery-public' 
    AND (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'))
  );

-- Private Receipts Bucket Policies
CREATE POLICY "Users can download their own receipts" ON storage.objects 
  FOR SELECT USING (
    bucket_id = 'prod-receipts-private' 
    AND (storage.foldername(name))[1] = auth.uid()::text -- Enforces /user_id/filename.pdf isolation
  );

CREATE POLICY "Authenticated users can upload receipts" ON storage.objects 
  FOR INSERT WITH CHECK (
    bucket_id = 'prod-receipts-private' 
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

