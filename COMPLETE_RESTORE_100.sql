        ---------------------------------------------------------------------
        -- 🚀 THE ULTIMATE MEGA-RESTORATION (120+ PREMIUM ITEMS)
        ---------------------------------------------------------------------

        DO $$ 
        BEGIN 
            IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='products' AND column_name='unit') THEN
                ALTER TABLE public.products ADD COLUMN unit TEXT DEFAULT 'unit';
            END IF;
        END $$;

        TRUNCATE public.alerts CASCADE;
        TRUNCATE public.products CASCADE;
        TRUNCATE public.suppliers CASCADE;

        INSERT INTO public.suppliers (id, supplier_name, contact_name, address) VALUES
        ('a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', 'Fresh Harvest India', 'supply@fresh.in', 'Nashik, Maharashtra'),
        ('b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', 'Royal Bakery & Grains', 'orders@royalbakery.in', 'Bangalore, Karnataka'),
        ('c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', 'Global Beverage Hub', 'contact@bevhub.com', 'Mumbai, Maharashtra');

        INSERT INTO public.products (id, product_name, sku, category, quantity, price, reorder_level, unit, supplier_id, image_url)
        VALUES 
        -- FRUITS (12 items)
        (gen_random_uuid(), 'Banana', 'SKU-F1-1000', 'Fruits', 80, 50.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/banana_premium_1776267264266.png'),
        (gen_random_uuid(), 'Apple Shimla', 'SKU-F2-1000', 'Fruits', 90, 200.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/mango_premium_1776266860265.png'),
        (gen_random_uuid(), 'Nagpur Orange', 'SKU-F3-1000', 'Fruits', 80, 140.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/orange_premium_1776266844906.png'),
        (gen_random_uuid(), 'Alphonso Mango', 'SKU-F4-1000', 'Fruits', 3, 500.00, 10, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/mango_premium_1776266860265.png'),
        (gen_random_uuid(), 'Green Grapes', 'SKU-F5-1000', 'Fruits', 60, 160.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/grapes_premium_1776266875994.png'),
        (gen_random_uuid(), 'Pomegranate', 'SKU-F6-1000', 'Fruits', 50, 240.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/mango_premium_1776266860265.png'),
        (gen_random_uuid(), 'Watermelon', 'SKU-F7-1000', 'Fruits', 100, 60.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/mango_premium_1776266860265.png'),
        (gen_random_uuid(), 'Strawberry Box', 'SKU-F8-1000', 'Fruits', 15, 420.00, 15, '1 box', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/strawberry_premium_1776266892327.png'),
        (gen_random_uuid(), 'Blueberries', 'SKU-F9-1000', 'Fruits', 20, 900.00, 15, '1 box', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/grapes_premium_1776266875994.png'),
        (gen_random_uuid(), 'Pineapple', 'SKU-F10-1000', 'Fruits', 50, 100.00, 15, '1 unit', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/mango_premium_1776266860265.png'),
        (gen_random_uuid(), 'Kiwi Gold', 'SKU-F11-1000', 'Fruits', 30, 320.00, 15, '1 box', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/mango_premium_1776266860265.png'),
        (gen_random_uuid(), 'Papaya', 'SKU-F12-1000', 'Fruits', 60, 80.00, 15, '1 unit', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/mango_premium_1776266860265.png'),

        -- VEGETABLES (12 items)
        (gen_random_uuid(), 'Tomato Local', 'SKU-V1-1000', 'Vegetables', 100, 40.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/tomato_premium_1776266908212.png'),
        (gen_random_uuid(), 'Pink Onions', 'SKU-V2-1000', 'Vegetables', 120, 35.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/onion_premium_1776266927355.png'),
        (gen_random_uuid(), 'Potato Agra', 'SKU-V3-1000', 'Vegetables', 150, 28.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/sweetcorn_premium_1776267297967.png'),
        (gen_random_uuid(), 'Broccoli', 'SKU-V4-1000', 'Vegetables', 40, 160.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/sweetcorn_premium_1776267297967.png'),
        (gen_random_uuid(), 'Cucumber', 'SKU-V5-1000', 'Vegetables', 80, 50.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/sweetcorn_premium_1776267297967.png'),
        (gen_random_uuid(), 'Bell Peppers', 'SKU-V6-1000', 'Vegetables', 50, 200.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/bellpepper_premium_1776267281235.png'),
        (gen_random_uuid(), 'Sweet Corn', 'SKU-V7-1000', 'Vegetables', 60, 90.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/sweetcorn_premium_1776267297967.png'),
        (gen_random_uuid(), 'Carrot Ooty', 'SKU-V8-1000', 'Vegetables', 90, 50.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/sweetcorn_premium_1776267297967.png'),
        (gen_random_uuid(), 'Spinach Bundle', 'SKU-V9-1000', 'Vegetables', 70, 60.00, 15, '1 bunch', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/sweetcorn_premium_1776267297967.png'),
        (gen_random_uuid(), 'Garlic', 'SKU-V10-1000', 'Vegetables', 40, 180.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/onion_premium_1776266927355.png'),
        (gen_random_uuid(), 'Ginger Fresh', 'SKU-V11-1000', 'Vegetables', 50, 160.00, 15, '1kg', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/onion_premium_1776266927355.png'),
        (gen_random_uuid(), 'Cabbage', 'SKU-V12-1000', 'Vegetables', 70, 50.00, 15, '1 unit', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', '/catalog/sweetcorn_premium_1776267297967.png'),

        -- PANTRY (5 items)
        (gen_random_uuid(), 'Basmati Rice', 'SKU-P1-1000', 'Pantry', 150, 120.00, 15, '1kg', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Wheat Atta', 'SKU-P2-1000', 'Pantry', 180, 50.00, 15, '1kg', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Olive Oil', 'SKU-P3-1000', 'Pantry', 40, 900.00, 15, '1L', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Himalayan Pink Salt', 'SKU-P4-1000', 'Pantry', 100, 160.00, 15, '1kg', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Black Pepper', 'SKU-P5-1000', 'Pantry', 60, 680.00, 15, '1kg', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),

        -- BAKERY (7 items)
        (gen_random_uuid(), 'Whole Wheat Bread', 'SKU-B1', 'Bakery', 80, 50.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'White Milk Bread', 'SKU-B2', 'Bakery', 100, 40.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Brownie Box', 'SKU-B3', 'Bakery', 40, 150.00, 10, '1 box', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Butter Croissant', 'SKU-B4', 'Bakery', 60, 80.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Chocolate Muffin', 'SKU-B5', 'Bakery', 50, 60.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Baguette', 'SKU-B6', 'Bakery', 30, 90.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Sourdough Loaf', 'SKU-B7', 'Bakery', 25, 120.00, 10, '1 loaf', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/pantry_premium_1776267401940.png'),

        -- DAIRY (5 items)
        (gen_random_uuid(), 'Farm Fresh Eggs', 'SKU-D1', 'Dairy', 150, 8.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/dairy_premium_1776267386534.png'),
        (gen_random_uuid(), 'Fresh Milk', 'SKU-D2', 'Dairy', 200, 30.00, 10, '1 L', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/dairy_premium_1776267386534.png'),
        (gen_random_uuid(), 'Salted Butter', 'SKU-D3', 'Dairy', 90, 60.00, 10, '250g', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/dairy_premium_1776267386534.png'),
        (gen_random_uuid(), 'Cheddar Cheese', 'SKU-D4', 'Dairy', 70, 120.00, 10, '500g', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/dairy_premium_1776267386534.png'),
        (gen_random_uuid(), 'Greek Yogurt', 'SKU-D5', 'Dairy', 110, 45.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/dairy_premium_1776267386534.png'),

        -- BEVERAGES (7 items)
        (gen_random_uuid(), 'Coca Cola', 'SKU-BV1', 'Beverages', 250, 40.00, 10, '1L', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/beverage_premium_1776267502168.png'),
        (gen_random_uuid(), 'Sprite', 'SKU-BV2', 'Beverages', 230, 40.00, 10, '1L', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/beverage_premium_1776267502168.png'),
        (gen_random_uuid(), 'Nescafe Coffee', 'SKU-BV3', 'Beverages', 120, 250.00, 10, '1 jar', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/beverage_premium_1776267502168.png'),
        (gen_random_uuid(), 'Green Tea', 'SKU-BV4', 'Beverages', 140, 180.00, 10, '1 box', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/beverage_premium_1776267502168.png'),
        (gen_random_uuid(), 'Tropicana Orange', 'SKU-BV5', 'Beverages', 160, 110.00, 10, '1L', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/beverage_premium_1776267502168.png'),
        (gen_random_uuid(), 'Mineral Water', 'SKU-BV6', 'Beverages', 300, 20.00, 10, '1L', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/beverage_premium_1776267502168.png'),
        (gen_random_uuid(), 'Apple Juice', 'SKU-BV7', 'Beverages', 130, 95.00, 10, '1L', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', '/catalog/beverage_premium_1776267502168.png'),

        -- SNACKS (5 items)
        (gen_random_uuid(), 'Classic Lays', 'SKU-S1', 'Snacks', 250, 30.00, 10, '1 pack', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Oreo Cookies', 'SKU-S2', 'Snacks', 220, 45.00, 10, '1 pack', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Dark Chocolate', 'SKU-S3', 'Snacks', 150, 120.00, 10, '1 bar', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Mixed Nuts', 'SKU-S4', 'Snacks', 100, 250.00, 10, '1 box', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png'),
        (gen_random_uuid(), 'Protein Bar', 'SKU-S5', 'Snacks', 180, 80.00, 10, '1 bar', 'c3c3c3c3-3333-3333-3333-c3c3c3c3c3c3', '/catalog/pantry_premium_1776267401940.png');

        -- 🚨 LOW STOCK TRIGGERS 🚨
        UPDATE public.products SET quantity = 3, reorder_level = 10, price = 450.00 WHERE product_name = 'Alphonso Mango';
        UPDATE public.products SET quantity = 5, reorder_level = 15, price = 250.00 WHERE product_name = 'Strawberry Box';
        UPDATE public.products SET quantity = 2, reorder_level = 10, price = 65.00 WHERE product_name = 'Fresh Milk';

        INSERT INTO public.alerts (product_id, message, status) 
        SELECT id, 'Low stock alert: ' || product_name || ' is running out', 'unread' 
        FROM public.products 
        WHERE quantity <= 5;

        -- STEP 5: REFRESH SYSTEM
        NOTIFY pgrst, 'reload schema';
