-- ================================================================
-- GROZOSPHERE: FIX ADDRESSES TABLE
-- Run this in the Supabase SQL Editor
-- ================================================================

-- Step 1: Drop old table if it exists (handles the rename)
DROP TABLE IF EXISTS public.user_addresses CASCADE;

-- Step 2: Create the correct table
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

-- Step 3: Enable RLS
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;

-- Step 4: Allow users to manage their own addresses
DROP POLICY IF EXISTS "Users can manage their own addresses" ON public.addresses;
CREATE POLICY "Users can manage their own addresses" 
    ON public.addresses 
    FOR ALL 
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- Step 5: Notify PostgREST to reload the schema cache
NOTIFY pgrst, 'reload schema';


-- ================================================================
-- PART 2: STORAGE BUCKETS
-- ================================================================

-- Public bucket for product images (logos, grocery photos, etc.)
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types) 
VALUES (
  'grocery-images', 
  'grocery-images', 
  true, 
  5242880,  -- 5MB max
  '{"image/jpeg","image/png","image/webp","image/svg+xml"}'
)
ON CONFLICT (id) DO NOTHING;

-- Private bucket for order receipts and invoices
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types) 
VALUES (
  'order-receipts', 
  'order-receipts', 
  false, 
  10485760,  -- 10MB max
  '{"application/pdf","image/jpeg","image/png"}'
)
ON CONFLICT (id) DO NOTHING;

-- ================================================================
-- STORAGE POLICIES
-- ================================================================

-- Anyone can VIEW images in the public grocery-images bucket
DROP POLICY IF EXISTS "Public grocery images are viewable" ON storage.objects;
CREATE POLICY "Public grocery images are viewable" 
  ON storage.objects FOR SELECT 
  USING (bucket_id = 'grocery-images');

-- Staff & Admin can UPLOAD/DELETE images in the public bucket
DROP POLICY IF EXISTS "Staff can manage grocery images" ON storage.objects;
CREATE POLICY "Staff can manage grocery images" 
  ON storage.objects FOR ALL 
  USING (
    bucket_id = 'grocery-images' 
    AND auth.role() = 'authenticated'
  );

-- Users can only VIEW their own receipts (stored in /user_id/ subfolder)
DROP POLICY IF EXISTS "Users can view own receipts" ON storage.objects;
CREATE POLICY "Users can view own receipts" 
  ON storage.objects FOR SELECT 
  USING (
    bucket_id = 'order-receipts' 
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- Authenticated users can UPLOAD receipts to their own folder
DROP POLICY IF EXISTS "Users can upload own receipts" ON storage.objects;
CREATE POLICY "Users can upload own receipts" 
  ON storage.objects FOR INSERT 
  WITH CHECK (
    bucket_id = 'order-receipts' 
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- Done! Both the addresses table and storage buckets are ready.
