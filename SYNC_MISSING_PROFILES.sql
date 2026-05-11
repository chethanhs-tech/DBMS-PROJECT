-- Run this in your Supabase SQL Editor to restore missing profiles

-- 1. Sync all users from auth.users to public.profiles
INSERT INTO public.profiles (id, email, name, role)
SELECT 
    id, 
    email, 
    COALESCE(raw_user_meta_data->>'full_name', raw_user_meta_data->>'name', 'Unknown User'),
    COALESCE(NULLIF(raw_user_meta_data->>'role', ''), 'customer')::public.app_role
FROM auth.users
ON CONFLICT (id) DO NOTHING;

-- 2. Sync all roles to user_roles
INSERT INTO public.user_roles (user_id, role)
SELECT 
    id, 
    COALESCE(NULLIF(raw_user_meta_data->>'role', ''), 'customer')::public.app_role
FROM auth.users
ON CONFLICT (user_id, role) DO NOTHING;

-- 3. Notify PostgREST to reload schema cache
NOTIFY pgrst, 'reload schema';
