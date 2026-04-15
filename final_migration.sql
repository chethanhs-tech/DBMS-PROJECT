-- GROZOSPHERE CONSOLIDATED FINAL MIGRATION
-- Run this in the Supabase SQL Editor

---------------------------------------------------------------------
-- 1. DYNAMIC NUCLEAR CLEANUP (REMOVE ALL POLICIES & CONSTRAINTS)
---------------------------------------------------------------------

DO $$ 
DECLARE
    pol RECORD;
    cons RECORD;
BEGIN
    -- 1. Drop ALL policies in public schema
    FOR pol IN (SELECT policyname, tablename FROM pg_policies WHERE schemaname = 'public') LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', pol.policyname, pol.tablename);
    END LOOP;

    -- 2. Drop ALL check constraints on the 'role' column (the most likely cause of 42883)
    FOR cons IN (
        SELECT conname, relname 
        FROM pg_constraint c 
        JOIN pg_class t ON c.conrelid = t.oid 
        JOIN pg_namespace n ON t.relnamespace = n.oid
        WHERE n.nspname = 'public' AND c.contype = 'c' AND conkey @> (
            SELECT array_agg(attnum) FROM pg_attribute 
            WHERE attrelid = t.oid AND attname = 'role'
        )
    ) LOOP
        EXECUTE format('ALTER TABLE public.%I DROP CONSTRAINT IF EXISTS %I', cons.relname, cons.conname);
    END LOOP;
END $$;

-- 3. Drop dependent functions
DROP FUNCTION IF EXISTS public.has_role CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user CASCADE;


---------------------------------------------------------------------
-- 2. THE ROLE TRANSITION (SAFE ENUM UPGRADE)
---------------------------------------------------------------------

-- a to TEXT first to break any remaining enum ties
ALTER TABLE public.profiles ALTER COLUMN role DROP DEFAULT;
ALTER TABLE public.profiles ALTER COLUMN role TYPE TEXT USING role::text;

-- Recreate the Enum
DROP TYPE IF EXISTS public.app_role CASCADE;
CREATE TYPE public.app_role AS ENUM ('admin', 'staff', 'customer');

-- Convert back to Enum
ALTER TABLE public.profiles ALTER COLUMN role TYPE public.app_role USING role::public.app_role;
ALTER TABLE public.profiles ALTER COLUMN role SET DEFAULT 'customer'::public.app_role;


---------------------------------------------------------------------
-- 3. CORE TABLES & COLUMNS SYNC
---------------------------------------------------------------------

-- Products
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS unit TEXT DEFAULT 'unit';
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS image_url TEXT;

-- Addresses (drop old conflicting table first)
DROP TABLE IF EXISTS public.user_addresses CASCADE;

CREATE TABLE IF NOT EXISTS public.addresses (
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

-- User Roles Table (Ensure role is Enum)
CREATE TABLE IF NOT EXISTS public.user_roles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  role public.app_role NOT NULL,
  UNIQUE (user_id, role)
);
-- If it already existed as TEXT, convert it
DO $$ BEGIN
    ALTER TABLE public.user_roles ALTER COLUMN role TYPE public.app_role USING role::public.app_role;
EXCEPTION WHEN OTHERS THEN END $$;

-- Orders
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS address_id UUID;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS estimated_delivery_time TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS upi_id TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS product_name TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS unit_price NUMERIC(12, 2);
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS gst_amount NUMERIC(12, 2);
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS total_price NUMERIC(12, 2);
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS invoice_number TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS payment_method TEXT;


---------------------------------------------------------------------
-- 4. RECREATE UTILITIES & POLICIES
---------------------------------------------------------------------

-- has_role helper (Accepts TEXT to avoid operator errors)
CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role_text TEXT)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = _user_id AND role::text = _role_text
  ) OR EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = _user_id AND role::text = _role_text
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Auth Signup Trigger (reads role from user metadata)
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
DECLARE
  user_role public.app_role;
BEGIN
  -- Read role from signup metadata, default to 'customer'
  user_role := COALESCE(
    NULLIF(new.raw_user_meta_data->>'role', ''),
    'customer'
  )::public.app_role;

  INSERT INTO public.profiles (id, email, name, role)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name', 'Unknown User'),
    user_role
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Re-attach trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

-- Re-apply all policies
CREATE POLICY "Admins can manage roles" ON public.user_roles FOR ALL USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Users can insert own roles" ON public.user_roles FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view own roles" ON public.user_roles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Profiles are viewable by everyone" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can manage their own addresses" ON public.addresses FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Staff can read suppliers" ON public.suppliers FOR SELECT USING (true);
CREATE POLICY "Admins have full access to suppliers" ON public.suppliers FOR ALL USING (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Staff can read products" ON public.products FOR SELECT USING (true);
CREATE POLICY "Admins have full access to products" ON public.products FOR ALL USING (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Staff can read transactions" ON public.transactions FOR SELECT USING (true);
CREATE POLICY "Staff can create transactions" ON public.transactions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Admins have full access to transactions" ON public.transactions FOR ALL USING (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Staff can read alerts" ON public.alerts FOR SELECT USING (true);
CREATE POLICY "Admins have full access to alerts" ON public.alerts FOR ALL USING (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Staff can read orders" ON public.orders FOR SELECT USING (true);
CREATE POLICY "Staff can insert orders" ON public.orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Admins have full access to orders" ON public.orders FOR ALL USING (public.has_role(auth.uid(), 'admin'));


---------------------------------------------------------------------
-- 5. FRESH GROCERY DATA SEEDING
---------------------------------------------------------------------

TRUNCATE public.products CASCADE;

INSERT INTO public.suppliers (supplier_name, contact, address) VALUES
('Fresh Farms Co.', 'supply@freshfarms.in', 'Farmville, India'),
('Dairy & Pantry Ltd', 'contact@dvpantry.in', 'City Center, India')
ON CONFLICT DO NOTHING;

DO $$
DECLARE
    farm_id UUID;
    pantry_id UUID;
BEGIN
    SELECT id INTO farm_id FROM public.suppliers WHERE supplier_name = 'Fresh Farms Co.' LIMIT 1;
    SELECT id INTO pantry_id FROM public.suppliers WHERE supplier_name = 'Dairy & Pantry Ltd' LIMIT 1;

    INSERT INTO public.products (product_name, sku, category, quantity, price, reorder_level, unit, supplier_id, image_url)
    VALUES 
    ('Fuji Apples', 'FRU-APP-001', 'Fruits', 85, 180.00, 20, '1kg', farm_id, 'https://images.unsplash.com/photo-1560806887-1e436279f0fb?w=800&q=80'),
    ('Robusta Bananas', 'FRU-BAN-001', 'Fruits', 120, 55.00, 30, '1 doz', farm_id, 'https://images.unsplash.com/photo-1603833665858-e81b1c7e4663?w=800&q=80'),
    ('Sweet Pomegranate', 'FRU-POM-001', 'Fruits', 45, 240.00, 15, '1kg', farm_id, 'https://images.unsplash.com/photo-1620127812573-04746f338d8a?w=800&q=80'),
    ('Hybrid Tomatoes', 'VEG-TOM-001', 'Vegetables', 150, 45.00, 40, '1kg', farm_id, 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=800&q=80'),
    ('Baby Spinach', 'VEG-SPI-001', 'Vegetables', 60, 35.00, 15, '250g', farm_id, 'https://images.unsplash.com/photo-1551008475-4533d14444d3?w=800&q=80'),
    ('Organic Brocolli', 'VEG-BRO-001', 'Vegetables', 30, 120.00, 10, '500g', farm_id, 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=800&q=80'),
    ('Amul Whole Milk', 'DAI-MIL-001', 'Dairy', 200, 66.00, 50, '1L', pantry_id, 'https://images.unsplash.com/photo-1550583724-1255818c0533?w=800&q=80'),
    ('Greek Yogurt', 'DAI-YOG-001', 'Dairy', 50, 85.00, 15, '400g', pantry_id, 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800&q=80'),
    ('Fresh Paneer', 'DAI-PAN-001', 'Dairy', 40, 95.00, 15, '200g', pantry_id, 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=800&q=80'),
    ('Baked Potato Chips', 'SNA-CHI-001', 'Snacks', 100, 40.00, 20, '1 Pack', pantry_id, 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=800&q=80'),
    ('Multigrain Biscuits', 'SNA-BIS-001', 'Snacks', 80, 25.00, 20, '1 Pack', pantry_id, 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=800&q=80'),
    ('Aashirvaad Atta', 'PAN-ATT-001', 'Pantry', 150, 210.00, 40, '5kg', pantry_id, 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&q=80'),
    ('Basmati Rice', 'PAN-RIC-001', 'Pantry', 100, 160.00, 30, '1kg', pantry_id, 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=800&q=80');
END $$;


---------------------------------------------------------------------
-- 6. FORCE SCHEMA CACHE REFRESH
---------------------------------------------------------------------
NOTIFY pgrst, 'reload schema';
