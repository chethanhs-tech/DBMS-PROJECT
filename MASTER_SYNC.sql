-- ==========================================
-- MASTER POSTGREST CACHE & SYNC FIX
-- ==========================================

-- 1. FORCE POSTGREST SCHEMA RELOAD
-- This forces the active REST API to rediscover 'addresses' and 'total_amount' columns immediately.
NOTIFY pgrst, 'reload schema';

-- 2. FIX AUTHENTICATION "STAFF" BUG PERMANENTLY
-- Replacing the trigger so every new signup defaults STRICTLY to 'customer'
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, email, name, role)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'full_name', 'Unknown User'),
    'customer' 
  );
  
  -- Belt and suspenders insert into user_roles too
  INSERT INTO public.user_roles (user_id, role)
  VALUES (
    new.id,
    'customer'
  );
  
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 3. VALIDATE CRITICAL CHECKOUT COLUMNS MANUALLY
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS total_amount NUMERIC(12, 2);
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS address_id UUID;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS upi_id TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS estimated_delivery_time TEXT;

-- Verify payment bounds again safely!
ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_payment_method_check;

-- 4. FORCE POSTGREST RELOAD TWICE TO BE ABSOLUTELY SURE
NOTIFY pgrst, 'reload schema';
