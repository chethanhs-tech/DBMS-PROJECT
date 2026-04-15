---------------------------------------------------------------------
-- GROZOSPHERE: COMPLETE SYSTEM REBUILD & INITIALIZATION SCRIPT
-- Warning: This forcibly drops existing user tables and recreates the entire schema cleanly!
---------------------------------------------------------------------

-- 1. CLEAN SLATE: WIPE EXISTING TABLES & TRIGGERS
DROP TABLE IF EXISTS public.transactions CASCADE;
DROP TABLE IF EXISTS public.alerts CASCADE;
DROP TABLE IF EXISTS public.orders CASCADE;
DROP TABLE IF EXISTS public.addresses CASCADE;
DROP TABLE IF EXISTS public.products CASCADE;
DROP TABLE IF EXISTS public.suppliers CASCADE;
DROP TABLE IF EXISTS public.user_roles CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;

DROP FUNCTION IF EXISTS public.handle_new_user CASCADE;
DROP FUNCTION IF EXISTS public.update_stock_on_transaction CASCADE;
DROP FUNCTION IF EXISTS public.sync_order_to_transaction CASCADE;
DROP FUNCTION IF EXISTS public.check_low_stock CASCADE;
DROP FUNCTION IF EXISTS public.delete_own_user CASCADE;

---------------------------------------------------------------------
-- 2. CREATE CORE TABLES
---------------------------------------------------------------------

CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    role TEXT DEFAULT 'customer' CHECK (role IN ('admin', 'staff', 'customer')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    role TEXT NOT NULL CHECK (role IN ('admin', 'staff', 'customer')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    UNIQUE(user_id, role)
);

CREATE TABLE public.suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    supplier_name TEXT NOT NULL,
    contact_name TEXT,
    phone TEXT,
    email TEXT,
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_name TEXT NOT NULL,
    sku TEXT UNIQUE NOT NULL,
    category TEXT,
    quantity INTEGER DEFAULT 0 CHECK (quantity >= 0),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    reorder_level INTEGER DEFAULT 10,
    supplier_id UUID REFERENCES public.suppliers(id) ON DELETE SET NULL,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.addresses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    house_no TEXT NOT NULL,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    pincode TEXT NOT NULL,
    landmark TEXT,
    is_default BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    product_name TEXT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2),
    gst_amount NUMERIC(10, 2),
    total_amount NUMERIC(12, 2) NOT NULL,
    payment_method TEXT NOT NULL,
    upi_id TEXT,
    address_id UUID,
    estimated_delivery_time TEXT,
    status TEXT DEFAULT 'completed' CHECK (status IN ('pending', 'completed', 'failed')),
    invoice_number TEXT UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    transaction_type TEXT NOT NULL CHECK (transaction_type IN ('purchase', 'sale', 'adjustment')),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    status TEXT DEFAULT 'unread' CHECK (status IN ('unread', 'read', 'resolved')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

---------------------------------------------------------------------
-- 3. BACKGROUND TRIGGERS (Automations & Webhooks)
---------------------------------------------------------------------

-- New User Trigger (Ensures standard "customer" assignment)
CREATE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, email, name, role)
  VALUES (new.id, new.email, COALESCE(new.raw_user_meta_data->>'full_name', 'Unknown User'), 'customer');
  
  INSERT INTO public.user_roles (user_id, role)
  VALUES (new.id, 'customer');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();


-- Sync Order Into Transactions Trigger
CREATE FUNCTION public.sync_order_to_transaction()
RETURNS trigger AS $$
BEGIN
    IF NEW.status = 'completed' THEN
        INSERT INTO public.transactions (product_id, transaction_type, quantity, user_id)
        VALUES (NEW.product_id, 'sale', NEW.quantity, NEW.user_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER order_to_transaction_trigger
  AFTER INSERT ON public.orders
  FOR EACH ROW EXECUTE PROCEDURE public.sync_order_to_transaction();


-- Stock Reduction on Transaction Trigger
CREATE FUNCTION public.update_stock_on_transaction()
RETURNS trigger AS $$
BEGIN
    IF NEW.transaction_type = 'purchase' THEN
        UPDATE public.products SET quantity = quantity + NEW.quantity WHERE id = NEW.product_id;
    ELSIF NEW.transaction_type = 'sale' THEN
        UPDATE public.products SET quantity = quantity - NEW.quantity WHERE id = NEW.product_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER transaction_stock_update_trigger
  BEFORE INSERT ON public.transactions
  FOR EACH ROW EXECUTE PROCEDURE public.update_stock_on_transaction();


-- Low Stock Alerts Trigger
CREATE FUNCTION public.check_low_stock()
RETURNS trigger AS $$
BEGIN
    IF NEW.quantity <= NEW.reorder_level AND OLD.quantity > NEW.reorder_level THEN
        INSERT INTO public.alerts (product_id, message)
        VALUES (NEW.id, 'Low stock alert: ' || NEW.product_name || ' is running out');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER products_check_low_stock_trigger
  AFTER UPDATE OF quantity ON public.products
  FOR EACH ROW EXECUTE PROCEDURE public.check_low_stock();


-- Self Account Deletion Utility
CREATE OR REPLACE FUNCTION delete_own_user() RETURNS void
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF auth.uid() IS NULL THEN RAISE EXCEPTION 'Not authenticated'; END IF;
  DELETE FROM auth.users WHERE id = auth.uid();
END;
$$;

---------------------------------------------------------------------
-- 4. ROW LEVEL SECURITY (RLS) POLICIES
---------------------------------------------------------------------

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;

-- Read rules universally
CREATE POLICY "Public Profiles are viewable by everyone" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Products are viewable by everyone" ON public.products FOR SELECT USING (true);
CREATE POLICY "Suppliers are viewable by everyone" ON public.suppliers FOR SELECT USING (true);

-- Product Management (Admins)
CREATE POLICY "Admins full management products" ON public.products FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
);

-- Profiles (Self manage)
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Addresses (Self manage entirely)
CREATE POLICY "Users can manage their own addresses" ON public.addresses FOR ALL USING (auth.uid() = user_id);

-- Orders (Read / Insert strictly scoped to Self)
CREATE POLICY "Users can insert own orders" ON public.orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view own orders" ON public.orders FOR SELECT USING (
    auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
);

-- Transactions (Read scoped to Self)
CREATE POLICY "Users can view own transactions" ON public.transactions FOR SELECT USING (
    auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
);

---------------------------------------------------------------------
-- 5. STORAGE BUCKET MAPPING
---------------------------------------------------------------------

INSERT INTO storage.buckets (id, name, public) VALUES ('product-images', 'product-images', true) ON CONFLICT (id) DO UPDATE SET public = true;

DROP POLICY IF EXISTS "Product images are public" ON storage.objects;
CREATE POLICY "Product images are public" ON storage.objects FOR SELECT USING (bucket_id = 'product-images');

DROP POLICY IF EXISTS "Elevated staff can insert/update images" ON storage.objects;
CREATE POLICY "Elevated staff can insert/update images" ON storage.objects FOR ALL USING (
    bucket_id = 'product-images' 
    AND (
      EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
      OR auth.jwt() ->> 'email' IN ('admin@grozosphere.com', 'staff@grozosphere.com')
    )
);

---------------------------------------------------------------------
-- 6. FINALIZING LIVE REAL-TIME SYNC ALGORITHMS
---------------------------------------------------------------------
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'products') THEN ALTER PUBLICATION supabase_realtime ADD TABLE products; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'orders') THEN ALTER PUBLICATION supabase_realtime ADD TABLE orders; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'alerts') THEN ALTER PUBLICATION supabase_realtime ADD TABLE alerts; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'addresses') THEN ALTER PUBLICATION supabase_realtime ADD TABLE addresses; END IF;
END $$;

NOTIFY pgrst, 'reload schema';
