DO $$
DECLARE
  cust_uid UUID;
BEGIN
  -- Check Customer User
  SELECT id INTO cust_uid FROM auth.users WHERE email = 'customer@grozosphere.com';
  
  IF cust_uid IS NULL THEN
    cust_uid := gen_random_uuid();
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, 
      raw_app_meta_data, raw_user_meta_data, created_at, updated_at, 
      confirmation_token, email_change, email_change_token_new, recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000', cust_uid, 'authenticated', 'authenticated', 
      'customer@grozosphere.com', crypt('Customer@123', gen_salt('bf')), now(), 
      '{"provider":"email","providers":["email"]}', '{"name":"Valued Customer","role":"customer","needs_password_change":true}', 
      now(), now(), '', '', '', ''
    );
    INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
    VALUES (gen_random_uuid(), cust_uid, format('{"sub":"%s","email":"%s"}', cust_uid::text, 'customer@grozosphere.com')::jsonb, 'email', cust_uid::text, now(), now(), now());
  ELSE
    UPDATE auth.users SET encrypted_password = crypt('Customer@123', gen_salt('bf')) WHERE id = cust_uid;
  END IF;

  INSERT INTO public.profiles (id, email, name, role) 
  VALUES (cust_uid, 'customer@grozosphere.com', 'Valued Customer', 'customer')
  ON CONFLICT (id) DO NOTHING;
  
  INSERT INTO public.user_roles (user_id, role) 
  VALUES (cust_uid, 'customer')
  ON CONFLICT (user_id, role) DO NOTHING;
  
END $$;
