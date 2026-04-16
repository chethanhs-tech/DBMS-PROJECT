-- ==========================================
-- GROZOSPHERE DATABASE STABILIZATION SCRIPT
-- ==========================================

-- 1. ENSURE USER_ROLES TABLE EXISTS
CREATE TABLE IF NOT EXISTS public.user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    role TEXT NOT NULL CHECK (role IN ('admin', 'staff', 'customer')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    UNIQUE(user_id, role)
);

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can read own roles" ON user_roles;
CREATE POLICY "Users can read own roles" ON user_roles 
    FOR SELECT USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- 2. UPDATE PROFILE TRIGGER (STRICT CUSTOMER DEFAULT)
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  -- Insert into profiles
  INSERT INTO public.profiles (id, email, name, role)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'full_name', 'Unknown User'),
    'customer' 
  );
  
  -- Insert into user_roles
  INSERT INTO public.user_roles (user_id, role)
  VALUES (new.id, 'customer');
  
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. ENSURE STOCK DEDUCTION TRIGGERS ARE ROBUST
-- Trigger to deduct stock from products when a 'sale' transaction is recorded
CREATE OR REPLACE FUNCTION update_stock_on_transaction()
RETURNS trigger AS $$
DECLARE
    current_qty INTEGER;
BEGIN
    SELECT quantity INTO current_qty FROM products WHERE id = NEW.product_id;

    IF NEW.transaction_type = 'sale' THEN
        IF current_qty - NEW.quantity < 0 THEN
            RAISE EXCEPTION 'Insufficient stock. Current stock: %', current_qty;
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

-- Trigger to create a transaction when an order is completed
CREATE OR REPLACE FUNCTION sync_order_to_transaction()
RETURNS trigger AS $$
BEGIN
    IF NEW.status = 'completed' THEN
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

-- 4. FIX COLUMN INCONSISTENCIES
ALTER TABLE public.suppliers ADD COLUMN IF NOT EXISTS contact TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS unit TEXT DEFAULT 'unit';
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS variations JSONB DEFAULT '[]';
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS total_amount NUMERIC(12, 2);
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS address_id UUID;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS upi_id TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS estimated_delivery_time TEXT;

-- 5. RELOAD POSTGREST
NOTIFY pgrst, 'reload schema';
