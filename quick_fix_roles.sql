-- ================================================================
-- QUICK FIX: Run this in Supabase SQL Editor RIGHT NOW
-- Adds missing policies so role-based signup works
-- ================================================================

-- 1. Let users update their own profile (needed for role assignment during signup)
DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile" 
  ON public.profiles FOR UPDATE 
  USING (auth.uid() = id);

-- 2. Let users insert their own roles
DROP POLICY IF EXISTS "Users can insert own roles" ON public.user_roles;
CREATE POLICY "Users can insert own roles" 
  ON public.user_roles FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

-- 3. Let users view their own roles
DROP POLICY IF EXISTS "Users can view own roles" ON public.user_roles;
CREATE POLICY "Users can view own roles" 
  ON public.user_roles FOR SELECT 
  USING (auth.uid() = user_id);

-- 4. Update the signup trigger to read role from user metadata
CREATE OR REPLACE FUNCTION public.handle_new_user()
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
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. Refresh schema cache
NOTIFY pgrst, 'reload schema';

-- Done! Now the demo login buttons will auto-create accounts with correct roles.
