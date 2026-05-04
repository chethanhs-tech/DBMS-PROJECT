---------------------------------------------------------------------
-- GROZOSPHERE: CONSOLIDATED SYSTEM REBUILD & INITIALIZATION SCRIPT
-- Warning: This forcibly drops existing user tables and recreates the entire schema cleanly!
---------------------------------------------------------------------

-- 1. CLEAN SLATE: WIPE EXISTING TABLES, FUNCTIONS & TRIGGERS
DROP TABLE IF EXISTS public.transactions CASCADE;
DROP TABLE IF EXISTS public.alerts CASCADE;
DROP TABLE IF EXISTS public.orders CASCADE;
DROP TABLE IF EXISTS public.addresses CASCADE;
DROP TABLE IF EXISTS public.product_variants CASCADE;
DROP TABLE IF EXISTS public.products CASCADE;
DROP TABLE IF EXISTS public.categories CASCADE;
DROP TABLE IF EXISTS public.suppliers CASCADE;
DROP TABLE IF EXISTS public.user_roles CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;

DROP FUNCTION IF EXISTS public.handle_new_user CASCADE;
DROP FUNCTION IF EXISTS public.update_stock_on_transaction CASCADE;
DROP FUNCTION IF EXISTS public.sync_order_to_transaction CASCADE;
DROP FUNCTION IF EXISTS public.check_low_stock CASCADE;
DROP FUNCTION IF EXISTS public.delete_own_user CASCADE;
DROP FUNCTION IF EXISTS public.has_role CASCADE;

DROP TYPE IF EXISTS public.app_role CASCADE;

---------------------------------------------------------------------
-- 2. CORE TYPES & TABLES
---------------------------------------------------------------------

-- Role Enum
CREATE TYPE public.app_role AS ENUM ('admin', 'staff', 'customer');

CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    role public.app_role DEFAULT 'customer'::public.app_role,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    role public.app_role NOT NULL,
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

CREATE TABLE public.categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_name TEXT NOT NULL,
    sku TEXT UNIQUE NOT NULL,
    category_id UUID REFERENCES public.categories(id) ON DELETE RESTRICT,
    unit TEXT DEFAULT 'unit',
    quantity INTEGER DEFAULT 0 CHECK (quantity >= 0),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    reorder_level INTEGER DEFAULT 10,
    supplier_id UUID REFERENCES public.suppliers(id) ON DELETE SET NULL,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Multi-Variant Table
CREATE TABLE public.product_variants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    sku TEXT UNIQUE NOT NULL,
    label TEXT NOT NULL, -- e.g. '500g', '1kg', '1L'
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    quantity INTEGER DEFAULT 0 CHECK (quantity >= 0),
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
    variant_id UUID REFERENCES public.product_variants(id) ON DELETE SET NULL,
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    product_name TEXT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12, 2),
    gst_amount NUMERIC(12, 2),
    total_amount NUMERIC(12, 2) NOT NULL,
    payment_method TEXT NOT NULL,
    upi_id TEXT,
    address_id UUID REFERENCES public.addresses(id) ON DELETE SET NULL,
    estimated_delivery_time TEXT,
    status TEXT DEFAULT 'completed' CHECK (status IN ('pending', 'completed', 'failed')),
    invoice_number TEXT UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES public.product_variants(id) ON DELETE SET NULL,
    type TEXT NOT NULL CHECK (type IN ('purchase', 'sale', 'adjustment')),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE public.alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES public.product_variants(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'resolved')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

---------------------------------------------------------------------
-- 3. BACKGROUND TRIGGERS & FUNCTIONS
---------------------------------------------------------------------

-- Helper: has_role
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

-- New User Trigger
CREATE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
DECLARE
  user_role public.app_role;
BEGIN
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
  
  INSERT INTO public.user_roles (user_id, role)
  VALUES (new.id, user_role);
  
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
        INSERT INTO public.transactions (product_id, variant_id, type, quantity, user_id)
        VALUES (NEW.product_id, NEW.variant_id, 'sale', NEW.quantity, NEW.user_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER order_to_transaction_trigger
  AFTER INSERT ON public.orders
  FOR EACH ROW EXECUTE PROCEDURE public.sync_order_to_transaction();


-- Stock Reduction on Transaction Trigger (Hybrid Variant/Master)
CREATE FUNCTION public.update_stock_on_transaction()
RETURNS trigger AS $$
BEGIN
    IF NEW.variant_id IS NOT NULL THEN
        IF NEW.type = 'purchase' THEN
            UPDATE public.product_variants SET quantity = quantity + NEW.quantity WHERE id = NEW.variant_id;
        ELSIF NEW.type = 'sale' THEN
            UPDATE public.product_variants SET quantity = quantity - NEW.quantity WHERE id = NEW.variant_id;
        END IF;
    ELSE
        IF NEW.type = 'purchase' THEN
            UPDATE public.products SET quantity = quantity + NEW.quantity WHERE id = NEW.product_id;
        ELSIF NEW.type = 'sale' THEN
            UPDATE public.products SET quantity = quantity - NEW.quantity WHERE id = NEW.product_id;
        END IF;
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
        INSERT INTO public.alerts (product_id, message, status)
        VALUES (NEW.id, 'Low stock alert: ' || NEW.product_name || ' is running out', 'active');
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

-- Secure Default Account Seeding RPC
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE OR REPLACE FUNCTION public.seed_default_users() RETURNS void
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  admin_uid UUID;
  staff_uid UUID;
BEGIN
  -- Check Admin User
  SELECT id INTO admin_uid FROM auth.users WHERE email = 'admin@grozosphere.com';
  
  IF admin_uid IS NULL THEN
    admin_uid := gen_random_uuid();
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, 
      raw_app_meta_data, raw_user_meta_data, created_at, updated_at, 
      confirmation_token, email_change, email_change_token_new, recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000', admin_uid, 'authenticated', 'authenticated', 
      'admin@grozosphere.com', crypt('Admin@123', gen_salt('bf')), now(), 
      '{"provider":"email","providers":["email"]}', '{"name":"System Admin","role":"admin","needs_password_change":true}', 
      now(), now(), '', '', '', ''
    );
    INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
    VALUES (gen_random_uuid(), admin_uid, format('{"sub":"%s","email":"%s"}', admin_uid::text, 'admin@grozosphere.com')::jsonb, 'email', admin_uid::text, now(), now(), now());
  END IF;

  -- Ensure Admin Profile and Role exist (in case tables were dropped)
  INSERT INTO public.profiles (id, email, name, role) 
  VALUES (admin_uid, 'admin@grozosphere.com', 'System Admin', 'admin')
  ON CONFLICT (id) DO NOTHING;
  
  INSERT INTO public.user_roles (user_id, role) 
  VALUES (admin_uid, 'admin')
  ON CONFLICT (user_id, role) DO NOTHING;


  -- Check Staff User
  SELECT id INTO staff_uid FROM auth.users WHERE email = 'staff@grozosphere.com';
  
  IF staff_uid IS NULL THEN
    staff_uid := gen_random_uuid();
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, 
      raw_app_meta_data, raw_user_meta_data, created_at, updated_at, 
      confirmation_token, email_change, email_change_token_new, recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000', staff_uid, 'authenticated', 'authenticated', 
      'staff@grozosphere.com', crypt('Staff@123', gen_salt('bf')), now(), 
      '{"provider":"email","providers":["email"]}', '{"name":"Store Manager","role":"staff","needs_password_change":true}', 
      now(), now(), '', '', '', ''
    );
    INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
    VALUES (gen_random_uuid(), staff_uid, format('{"sub":"%s","email":"%s"}', staff_uid::text, 'staff@grozosphere.com')::jsonb, 'email', staff_uid::text, now(), now(), now());
  END IF;

  -- Ensure Staff Profile and Role exist (in case tables were dropped)
  INSERT INTO public.profiles (id, email, name, role) 
  VALUES (staff_uid, 'staff@grozosphere.com', 'Store Manager', 'staff')
  ON CONFLICT (id) DO NOTHING;
  
  INSERT INTO public.user_roles (user_id, role) 
  VALUES (staff_uid, 'staff')
  ON CONFLICT (user_id, role) DO NOTHING;

END;
$$;

---------------------------------------------------------------------
-- 4. ROW LEVEL SECURITY (RLS) POLICIES
---------------------------------------------------------------------

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_variants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;

-- Read rules universally
CREATE POLICY "Categories are viewable by everyone" ON public.categories FOR SELECT USING (true);
CREATE POLICY "Public Profiles are viewable by everyone" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Products are viewable by everyone" ON public.products FOR SELECT USING (true);
CREATE POLICY "Variants are viewable by everyone" ON public.product_variants FOR SELECT USING (true);
CREATE POLICY "Suppliers are viewable by everyone" ON public.suppliers FOR SELECT USING (true);

-- Admin Management
CREATE POLICY "Admins full management categories" ON public.categories FOR ALL USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins full management products" ON public.products FOR ALL USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins full management variants" ON public.product_variants FOR ALL USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins full management suppliers" ON public.suppliers FOR ALL USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins full management roles" ON public.user_roles FOR ALL USING (public.has_role(auth.uid(), 'admin'));

-- Staff Read Access
CREATE POLICY "Staff read products" ON public.products FOR SELECT USING (public.has_role(auth.uid(), 'staff'));
CREATE POLICY "Staff read transactions" ON public.transactions FOR SELECT USING (public.has_role(auth.uid(), 'staff'));

-- Profiles (Self manage)
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Addresses (Self manage entirely)
CREATE POLICY "Users can manage their own addresses" ON public.addresses FOR ALL USING (auth.uid() = user_id);

-- Orders (Read / Insert strictly scoped to Self)
CREATE POLICY "Users can insert own orders" ON public.orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view own orders" ON public.orders FOR SELECT USING (
    auth.uid() = user_id OR public.has_role(auth.uid(), 'admin') OR public.has_role(auth.uid(), 'staff')
);

-- Transactions (Read scoped to Self)
CREATE POLICY "Users can view own transactions" ON public.transactions FOR SELECT USING (
    auth.uid() = user_id OR public.has_role(auth.uid(), 'admin') OR public.has_role(auth.uid(), 'staff')
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
      public.has_role(auth.uid(), 'admin') OR public.has_role(auth.uid(), 'staff')
      OR auth.jwt() ->> 'email' IN ('admin@grozosphere.com', 'staff@grozosphere.com')
    )
);

---------------------------------------------------------------------
-- 6. FINALIZING LIVE REAL-TIME SYNC ALGORITHMS
---------------------------------------------------------------------
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'products') THEN ALTER PUBLICATION supabase_realtime ADD TABLE products; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'product_variants') THEN ALTER PUBLICATION supabase_realtime ADD TABLE product_variants; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'orders') THEN ALTER PUBLICATION supabase_realtime ADD TABLE orders; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'alerts') THEN ALTER PUBLICATION supabase_realtime ADD TABLE alerts; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'addresses') THEN ALTER PUBLICATION supabase_realtime ADD TABLE addresses; END IF;
END $$;

NOTIFY pgrst, 'reload schema';
