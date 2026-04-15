-- FIX: STORAGE BUCKET RLS POLICIES FOR ADMINS/STAFF
-- Since Javascript overrides UI visibility based on emails, 
-- Postgres needs to know that the exact admin emails have upload power directly!

DROP POLICY IF EXISTS "Staff can upload images" ON storage.objects;
CREATE POLICY "Staff can upload images" ON storage.objects 
  FOR INSERT WITH CHECK (
    bucket_id = 'product-images' 
    AND (
      EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
      OR 
      auth.jwt() ->> 'email' IN ('admin@grozosphere.com', 'staff@grozosphere.com')
    )
  );

DROP POLICY IF EXISTS "Staff can update images" ON storage.objects;
CREATE POLICY "Staff can update images" ON storage.objects 
  FOR UPDATE USING (
    bucket_id = 'product-images' 
    AND (
      EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
      OR 
      auth.jwt() ->> 'email' IN ('admin@grozosphere.com', 'staff@grozosphere.com')
    )
  );

DROP POLICY IF EXISTS "Staff can delete images" ON storage.objects;
CREATE POLICY "Staff can delete images" ON storage.objects 
  FOR DELETE USING (
    bucket_id = 'product-images' 
    AND (
      EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
      OR 
      auth.jwt() ->> 'email' IN ('admin@grozosphere.com', 'staff@grozosphere.com')
    )
  );
  
-- Make sure the bucket permits are absolutely active
UPDATE storage.buckets SET public = true WHERE id = 'product-images';
