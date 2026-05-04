UPDATE auth.users 
SET encrypted_password = crypt('Admin@123', gen_salt('bf')) 
WHERE email = 'admin@grozosphere.com';

UPDATE auth.users 
SET encrypted_password = crypt('Staff@123', gen_salt('bf')) 
WHERE email = 'staff@grozosphere.com';

UPDATE auth.users 
SET encrypted_password = crypt('Customer@123', gen_salt('bf')) 
WHERE email = 'customer@grozosphere.com';
