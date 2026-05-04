-- ==============================================================================
-- GROZOSPHERE: DEFAULT ADMIN & STAFF SEEDING SCRIPT
-- Execute this in the Supabase SQL Editor to generate the default accounts.
-- ==============================================================================

-- Enable pgcrypto for secure password hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

DO $$
DECLARE
  admin_uid UUID := gen_random_uuid();
  staff_uid UUID := gen_random_uuid();
BEGIN
  -------------------------------------------------------------------------------
  -- 1. Create Default Admin User
  -- Credentials: admin@grozosphere.com / Admin@123
  -------------------------------------------------------------------------------
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'admin@grozosphere.com') THEN
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, 
      raw_app_meta_data, raw_user_meta_data, created_at, updated_at, 
      confirmation_token, email_change, email_change_token_new, recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000', admin_uid, 'authenticated', 'authenticated', 
      'admin@grozosphere.com', crypt('Admin@123', gen_salt('bf')), now(), 
      '{"provider":"email","providers":["email"]}', '{"name":"System Admin","role":"admin"}', 
      now(), now(), '', '', '', ''
    );
    
    INSERT INTO auth.identities (id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
    VALUES (
      gen_random_uuid(), admin_uid, format('{"sub":"%s","email":"%s"}', admin_uid::text, 'admin@grozosphere.com')::jsonb, 
      'email', now(), now(), now()
    );
    
    RAISE NOTICE 'Admin user created successfully.';
  ELSE
    RAISE NOTICE 'Admin user already exists.';
  END IF;

  -------------------------------------------------------------------------------
  -- 2. Create Default Staff User
  -- Credentials: staff@grozosphere.com / Staff@123
  -------------------------------------------------------------------------------
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'staff@grozosphere.com') THEN
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, 
      raw_app_meta_data, raw_user_meta_data, created_at, updated_at, 
      confirmation_token, email_change, email_change_token_new, recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000', staff_uid, 'authenticated', 'authenticated', 
      'staff@grozosphere.com', crypt('Staff@123', gen_salt('bf')), now(), 
      '{"provider":"email","providers":["email"]}', '{"name":"Store Manager","role":"staff"}', 
      now(), now(), '', '', '', ''
    );

    INSERT INTO auth.identities (id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
    VALUES (
      gen_random_uuid(), staff_uid, format('{"sub":"%s","email":"%s"}', staff_uid::text, 'staff@grozosphere.com')::jsonb, 
      'email', now(), now(), now()
    );
    
    RAISE NOTICE 'Staff user created successfully.';
  ELSE
    RAISE NOTICE 'Staff user already exists.';
  END IF;

  -- Note: The `public.profiles` and `public.user_roles` entries will automatically 
  -- be created by the `handle_new_user` trigger defined in your schema.
END $$;
