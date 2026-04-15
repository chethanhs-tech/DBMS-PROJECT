-- ================================================================
-- GROZOSPHERE SUPABASE FINAL STABILIZATION SCRIPT
-- ================================================================

-- 1. FIX ORDERS TABLE (Ensure all fields exist)
ALTER TABLE public.orders 
ADD COLUMN IF NOT EXISTS product_name TEXT,
ADD COLUMN IF NOT EXISTS unit_price NUMERIC(10, 2),
ADD COLUMN IF NOT EXISTS gst_amount NUMERIC(10, 2),
ADD COLUMN IF NOT EXISTS upi_id TEXT,
ADD COLUMN IF NOT EXISTS address_id UUID,
ADD COLUMN IF NOT EXISTS estimated_delivery_time TEXT;

-- Remove constraint on payment method if it fails on new values, just in case
ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_payment_method_check;

-- 2. CREATE ADDRESSES TABLE
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

ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can manage their own addresses" ON addresses;
CREATE POLICY "Users can manage their own addresses" ON addresses 
  FOR ALL USING (auth.uid() = user_id);


-- 3. ENSURE RLS POLICIES FOR SECURE CHECKOUT (Orders and Transactions)
-- Orders: Insert securely, Read securely
DROP POLICY IF EXISTS "Users can read own orders" ON orders;
CREATE POLICY "Users can read own orders" ON orders 
  FOR SELECT USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'staff')));

DROP POLICY IF EXISTS "Users can insert own orders" ON orders;
CREATE POLICY "Users can insert own orders" ON orders 
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Transactions: Read securely, Insert securely
DROP POLICY IF EXISTS "Users can read own transactions" ON transactions;
CREATE POLICY "Users can read own transactions" ON transactions 
  FOR SELECT USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'staff')));

DROP POLICY IF EXISTS "Users can insert own transactions" ON transactions;
CREATE POLICY "Users can insert own transactions" ON transactions 
  FOR INSERT WITH CHECK (auth.uid() = user_id);


-- 4. FIX PRODUCT IMAGES STORAGE BUCKET
INSERT INTO storage.buckets (id, name, public) 
VALUES ('product-images', 'product-images', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Public read for product images
DROP POLICY IF EXISTS "Product images are public" ON storage.objects;
CREATE POLICY "Product images are public" ON storage.objects 
  FOR SELECT USING (bucket_id = 'product-images');

-- Admin/Staff can upload product images
DROP POLICY IF EXISTS "Staff can upload images" ON storage.objects;
CREATE POLICY "Staff can upload images" ON storage.objects 
  FOR INSERT WITH CHECK (
    bucket_id = 'product-images' 
    AND EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
  );

-- Admin/Staff can update product images
DROP POLICY IF EXISTS "Staff can update images" ON storage.objects;
CREATE POLICY "Staff can update images" ON storage.objects 
  FOR UPDATE USING (
    bucket_id = 'product-images' 
    AND EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
  );

-- Reload schema caches
NOTIFY pgrst, 'reload schema';
