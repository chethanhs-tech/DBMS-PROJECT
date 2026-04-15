---------------------------------------------------------------------
-- STORAGE & AUTH EXPANSION FIX
---------------------------------------------------------------------

-- 1. CREATE MISSING BUCKETS
INSERT INTO storage.buckets (id, name, public) VALUES ('grocery-images', 'grocery-images', true) ON CONFLICT (id) DO UPDATE SET public = true;
INSERT INTO storage.buckets (id, name, public) VALUES ('order-receipts', 'order-receipts', true) ON CONFLICT (id) DO UPDATE SET public = true;

-- 2. UNIVERSAL PUBLIC READ POLICY
-- Enable everyone to see product images, grocery catalog, and their receipts
DROP POLICY IF EXISTS "Storage is public readable" ON storage.objects;
CREATE POLICY "Storage is public readable" ON storage.objects FOR SELECT USING (true);

-- 3. EXPANDED UPLOAD POLICIES
-- Allow Admins and Staff to upload to product-images and grocery-images
DROP POLICY IF EXISTS "Staff can upload products" ON storage.objects;
CREATE POLICY "Staff can upload products" ON storage.objects FOR INSERT WITH CHECK (
    bucket_id IN ('product-images', 'grocery-images') 
    AND (
      EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
      OR auth.jwt() ->> 'email' IN ('admin@grozosphere.com', 'staff@grozosphere.com')
    )
);

-- Allow authenticated users to upload their own receipts (for checkout log)
DROP POLICY IF EXISTS "Users can upload receipts" ON storage.objects;
CREATE POLICY "Users can upload receipts" ON storage.objects FOR INSERT WITH CHECK (
    bucket_id = 'order-receipts' AND auth.uid() IS NOT NULL
);

-- 4. ENSURE DEMO ROLES ARE CORRECT
-- If you created the users manually, this ensures they have the right roles in our profiles table.
UPDATE public.profiles SET role = 'admin' WHERE email = 'admin@grozosphere.com';
UPDATE public.profiles SET role = 'staff' WHERE email = 'staff@grozosphere.com';
UPDATE public.profiles SET role = 'customer' WHERE email = 'customer@grozosphere.com';

-- Force sync user_roles table too
INSERT INTO public.user_roles (user_id, role)
SELECT id, role FROM public.profiles
ON CONFLICT (user_id, role) DO NOTHING;

NOTIFY pgrst, 'reload schema';
