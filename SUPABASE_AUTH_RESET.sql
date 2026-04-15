---------------------------------------------------------------------
-- 🛡️ GROZOSPHERE SUPER-MASTER AUTH RESET
-- Bypasses API Rate Limits & Force-Resets Credentials
---------------------------------------------------------------------

-- Enable the pgcrypto extension if not already enabled
CREATE EXTENSION IF NOT EXISTS pgcrypto;

DO $$
DECLARE
    admin_id uuid;
    staff_id uuid;
    customer_id uuid;
BEGIN
    -- 1. CLEANUP EXISTING IDENTITIES TO PREVENT DEADLOCKS
    DELETE FROM auth.users WHERE email IN ('admin@grozosphere.com', 'staff@grozosphere.com', 'customer@grozosphere.com');
    DELETE FROM public.profiles WHERE email IN ('admin@grozosphere.com', 'staff@grozosphere.com', 'customer@grozosphere.com');

    -- 2. GENERATE NEW UUIDs
    admin_id := gen_random_uuid();
    staff_id := gen_random_uuid();
    customer_id := gen_random_uuid();

    -- 3. INSERT USERS INTO AUTH.USERS (Bypasses API limits)
    INSERT INTO auth.users (
        id, instance_id, aud, role, email, encrypted_password, 
        email_confirmed_at, recovery_sent_at, last_sign_in_at, 
        raw_app_meta_data, raw_user_meta_data, created_at, updated_at, 
        confirmation_token, email_change, email_change_token_new, recovery_token
    ) VALUES
    (admin_id, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'admin@grozosphere.com', crypt('admin@123', gen_salt('bf')), now(), NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"name": "Admin User", "role": "admin"}', now(), now(), '', '', '', ''),
    (staff_id, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'staff@grozosphere.com', crypt('staff@123', gen_salt('bf')), now(), NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"name": "Staff User", "role": "staff"}', now(), now(), '', '', '', ''),
    (customer_id, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'customer@grozosphere.com', crypt('customer@123', gen_salt('bf')), now(), NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"name": "Demo Customer", "role": "customer"}', now(), now(), '', '', '', '');

    -- 4. INSERT IDENTITIES (Required for login)
    INSERT INTO auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at) VALUES
    (admin_id, admin_id, admin_id::text, jsonb_build_object('sub', admin_id::text, 'email', 'admin@grozosphere.com'), 'email', NULL, now(), now()),
    (staff_id, staff_id, staff_id::text, jsonb_build_object('sub', staff_id::text, 'email', 'staff@grozosphere.com'), 'email', NULL, now(), now()),
    (customer_id, customer_id, customer_id::text, jsonb_build_object('sub', customer_id::text, 'email', 'customer@grozosphere.com'), 'email', NULL, now(), now());

    -- NOTE: Profile creation will be handled by the existing DB trigger on auth.users!
END $$;
