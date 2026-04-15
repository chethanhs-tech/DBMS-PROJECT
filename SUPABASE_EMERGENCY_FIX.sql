-- ================================================================
-- 🚨 EMERGENCY SUPABASE STABILIZATION SCRIPT (V4 - TOTAL RESET)
-- ================================================================
-- INSTRUCTIONS: Run this whole block in your Supabase SQL Editor.
-- This will WIPE the demo accounts so they can be recreated properly.
-- ================================================================

---------------------------------------------------------------------
-- 1. TOTAL DEMO RESET (CRITICAL)
---------------------------------------------------------------------
-- This deletes the old accounts so the 1-click button can start fresh
-- Note: This only affects the demo accounts.
DELETE FROM auth.users 
WHERE email IN ('customer@grozosphere.com', 'admin@grozosphere.com', 'staff@grozosphere.com');

---------------------------------------------------------------------
-- 2. REPAIR USER_ROLES TABLE
---------------------------------------------------------------------

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'app_role') THEN
        CREATE TYPE public.app_role AS ENUM ('admin', 'staff', 'customer');
    ELSE
        IF NOT EXISTS (SELECT 1 FROM pg_enum e JOIN pg_type t ON e.enumtypid = t.oid WHERE t.typname = 'app_role' AND e.enumlabel = 'customer') THEN
            ALTER TYPE public.app_role ADD VALUE 'customer';
        END IF;
    END IF;
END $$;

DROP TABLE IF EXISTS public.user_roles;
CREATE TABLE public.user_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role public.app_role NOT NULL,
  UNIQUE(user_id, role)
);

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Users can view own roles" ON public.user_roles;
CREATE POLICY "Users can view own roles" ON public.user_roles FOR SELECT TO authenticated USING (user_id = auth.uid());
DROP POLICY IF EXISTS "Admins can manage roles" ON public.user_roles;
CREATE POLICY "Admins can manage roles" ON public.user_roles FOR ALL TO authenticated USING (auth.uid() IN (SELECT user_id FROM public.user_roles WHERE role = 'admin'));

---------------------------------------------------------------------
-- 3. FIX SIGNUP TRIGGER (PREVENTS FUTURE STAFF BUG)
---------------------------------------------------------------------

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

  -- Create Profile
  INSERT INTO public.profiles (id, email, name, role)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name', 'Unknown User'),
    user_role
  ) ON CONFLICT (id) DO UPDATE SET role = EXCLUDED.role;

  -- Insert into user_roles
  INSERT INTO public.user_roles (user_id, role)
  VALUES (new.id, user_role)
  ON CONFLICT (user_id, role) DO NOTHING;

  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

---------------------------------------------------------------------
-- 4. FORCE REPAIR ALL EXISTING PROFILES (FIXES "CHETHAN" BUG)
---------------------------------------------------------------------

-- Move anyone who isn't explicitly on this list to 'customer'
UPDATE public.profiles 
SET role = 'customer'::public.app_role
WHERE email NOT IN ('admin@grozosphere.com', 'staff@grozosphere.com');

-- Also clean up user_roles table to match
TRUNCATE public.user_roles;
INSERT INTO public.user_roles (user_id, role)
SELECT id, role FROM public.profiles;

---------------------------------------------------------------------
-- 5. STORAGE & REFRESH
---------------------------------------------------------------------

INSERT INTO storage.buckets (id, name, public) 
VALUES ('grocery-images', 'grocery-images', true)
ON CONFLICT (id) DO UPDATE SET public = true;

NOTIFY pgrst, 'reload schema';

-- ✅ TOTAL REPAIR COMPLETE.
