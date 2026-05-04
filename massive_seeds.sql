-- Massive 120 Item Seeding Script with Perfect AI Generated Product Images


-- 1. DELETE existing products and variants to prevent duplication
DELETE FROM public.product_variants;
DELETE FROM public.products;
DELETE FROM public.categories;

-- 2. Insert Categories
INSERT INTO public.categories (name) VALUES ('Fruits') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Vegetables') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Dairy') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Grains & Rice') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Pulses') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Oils & Spices') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Snacks') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Beverages') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Daily Essentials') ON CONFLICT (name) DO NOTHING;

-- 3. Insert Products

DO $$
DECLARE
    cat_id UUID;
    prod_id UUID;
BEGIN

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Fresh Apples', 
        'FRU-1799-0', 
        cat_id, 
        120, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Fresh%20Apples%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=861'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-1799-0-V1', '500g', 120, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-1799-0-V2', '1kg', 240, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Ripe Bananas', 
        'FRU-8992-1', 
        cat_id, 
        60, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Ripe%20Bananas%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=399'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-8992-1-V1', '500g', 60, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-8992-1-V2', '1kg', 120, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Oranges', 
        'FRU-1284-2', 
        cat_id, 
        80, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Oranges%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=448'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-1284-2-V1', '500g', 80, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-1284-2-V2', '1kg', 160, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Green Grapes', 
        'FRU-6118-3', 
        cat_id, 
        90, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Green%20Grapes%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=283'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-6118-3-V1', '500g', 90, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Black Grapes', 
        'FRU-6394-4', 
        cat_id, 
        100, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Black%20Grapes%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=340'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-6394-4-V1', '500g', 100, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Alphonso Mango', 
        'FRU-3248-5', 
        cat_id, 
        400, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Alphonso%20Mango%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=609'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-3248-5-V1', '1kg', 400, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Papaya', 
        'FRU-3780-6', 
        cat_id, 
        50, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Papaya%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=978'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-3780-6-V1', '1pc', 50, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Watermelon', 
        'FRU-45-7', 
        cat_id, 
        80, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Watermelon%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=708'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-45-7-V1', '1pc', 80, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Pomegranate', 
        'FRU-5352-8', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Pomegranate%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=939'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-5352-8-V1', '500g', 150, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-5352-8-V2', '1kg', 300, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fruits';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Pineapple', 
        'FRU-4145-9', 
        cat_id, 
        70, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Pineapple%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=712'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'FRU-4145-9-V1', '1pc', 70, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Red Onions', 
        'VEG-6029-0', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Red%20Onions%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=14'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-6029-0-V1', '1kg', 40, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-6029-0-V2', '5kg', 80, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Red Tomatoes', 
        'VEG-2590-1', 
        cat_id, 
        30, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Red%20Tomatoes%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=188'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-2590-1-V1', '500g', 30, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-2590-1-V2', '1kg', 60, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Potatoes', 
        'VEG-3129-2', 
        cat_id, 
        35, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Potatoes%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=418'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-3129-2-V1', '1kg', 35, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-3129-2-V2', '5kg', 70, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Fresh Carrots', 
        'VEG-472-3', 
        cat_id, 
        50, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Fresh%20Carrots%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=73'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-472-3-V1', '500g', 50, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-472-3-V2', '1kg', 100, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Broccoli', 
        'VEG-4876-4', 
        cat_id, 
        80, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Broccoli%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=8'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-4876-4-V1', '1pc', 80, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Cauliflower', 
        'VEG-1996-5', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Cauliflower%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=832'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-1996-5-V1', '1pc', 40, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Fresh Spinach', 
        'VEG-4280-6', 
        cat_id, 
        20, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Fresh%20Spinach%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=120'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-4280-6-V1', '1bunch', 20, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Cabbage', 
        'VEG-1850-7', 
        cat_id, 
        30, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Cabbage%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=487'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-1850-7-V1', '1pc', 30, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Green Capsicum', 
        'VEG-524-8', 
        cat_id, 
        60, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Green%20Capsicum%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=527'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-524-8-V1', '500g', 60, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Vegetables';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Okra Lady Finger', 
        'VEG-7708-9', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Okra%20Lady%20Finger%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=194'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'VEG-7708-9-V1', '500g', 40, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Glass of Cow Milk', 
        'DAI-1398-0', 
        cat_id, 
        50, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Glass%20of%20Cow%20Milk%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=464'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-1398-0-V1', '500ml', 50, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-1398-0-V2', '1L', 100, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Buffalo Milk', 
        'DAI-2038-1', 
        cat_id, 
        60, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Buffalo%20Milk%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=541'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-2038-1-V1', '500ml', 60, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-2038-1-V2', '1L', 120, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bowl of Fresh Yogurt', 
        'DAI-7085-2', 
        cat_id, 
        30, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bowl%20of%20Fresh%20Yogurt%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=332'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-7085-2-V1', '200g', 30, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-7085-2-V2', '400g', 60, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Cubes of Paneer', 
        'DAI-3139-3', 
        cat_id, 
        80, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Cubes%20of%20Paneer%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=709'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-3139-3-V1', '200g', 80, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-3139-3-V2', '500g', 160, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Cheese Slices', 
        'DAI-6365-4', 
        cat_id, 
        120, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Cheese%20Slices%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=931'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-6365-4-V1', '200g', 120, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Block of Butter', 
        'DAI-5192-5', 
        cat_id, 
        55, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Block%20of%20Butter%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=79'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-5192-5-V1', '100g', 55, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-5192-5-V2', '500g', 110, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Jar of Clarified Butter Ghee', 
        'DAI-5591-6', 
        cat_id, 
        500, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Jar%20of%20Clarified%20Butter%20Ghee%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=703'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-5591-6-V1', '500ml', 500, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-5591-6-V2', '1L', 1000, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bowl of Fresh Cream', 
        'DAI-8868-7', 
        cat_id, 
        60, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bowl%20of%20Fresh%20Cream%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=26'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-8868-7-V1', '200ml', 60, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Basmati Rice', 
        'GRA-3797-0', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Basmati%20Rice%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=506'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-3797-0-V1', '1kg', 150, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-3797-0-V2', '5kg', 300, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Sona Masoori Rice', 
        'GRA-4956-1', 
        cat_id, 
        60, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Sona%20Masoori%20Rice%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=722'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-4956-1-V1', '5kg', 60, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-4956-1-V2', '10kg', 120, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Brown Rice', 
        'GRA-8533-2', 
        cat_id, 
        90, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Brown%20Rice%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=571'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-8533-2-V1', '1kg', 90, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Whole Wheat Flour', 
        'GRA-5373-3', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Whole%20Wheat%20Flour%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=391'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-5373-3-V1', '5kg', 40, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-5373-3-V2', '10kg', 80, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Multigrain Flour', 
        'GRA-7760-4', 
        cat_id, 
        55, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Multigrain%20Flour%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=284'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-7760-4-V1', '5kg', 55, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Refined Wheat Flour Maida', 
        'GRA-9234-5', 
        cat_id, 
        35, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Refined%20Wheat%20Flour%20Maida%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=109'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-9234-5-V1', '1kg', 35, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Semolina Suji', 
        'GRA-2363-6', 
        cat_id, 
        45, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Semolina%20Suji%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=807'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-2363-6-V1', '1kg', 45, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Gram Flour Besan', 
        'GRA-9258-7', 
        cat_id, 
        70, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Gram%20Flour%20Besan%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=81'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-9258-7-V1', '1kg', 70, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Flattened Rice Poha', 
        'GRA-8336-8', 
        cat_id, 
        50, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Flattened%20Rice%20Poha%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=219'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-8336-8-V1', '500g', 50, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-8336-8-V2', '1kg', 100, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Grains & Rice';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Rolled Oats', 
        'GRA-6882-9', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Rolled%20Oats%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=560'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'GRA-6882-9-V1', '1kg', 150, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Yellow Pigeon Peas Toor Dal', 
        'PUL-64-0', 
        cat_id, 
        160, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Yellow%20Pigeon%20Peas%20Toor%20Dal%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=540'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-64-0-V1', '500g', 160, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-64-0-V2', '1kg', 320, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Yellow Lentils Moong Dal', 
        'PUL-4131-1', 
        cat_id, 
        110, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Yellow%20Lentils%20Moong%20Dal%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=194'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-4131-1-V1', '500g', 110, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-4131-1-V2', '1kg', 220, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Split Chickpeas Chana Dal', 
        'PUL-1199-2', 
        cat_id, 
        90, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Split%20Chickpeas%20Chana%20Dal%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=72'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-1199-2-V1', '500g', 90, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-1199-2-V2', '1kg', 180, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Black Gram Urad Dal', 
        'PUL-8871-3', 
        cat_id, 
        140, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Black%20Gram%20Urad%20Dal%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=926'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-8871-3-V1', '500g', 140, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-8871-3-V2', '1kg', 280, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Red Lentils Masoor Dal', 
        'PUL-326-4', 
        cat_id, 
        100, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Red%20Lentils%20Masoor%20Dal%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=541'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-326-4-V1', '500g', 100, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-326-4-V2', '1kg', 200, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'White Chickpeas', 
        'PUL-9057-5', 
        cat_id, 
        130, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20White%20Chickpeas%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=738'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-9057-5-V1', '500g', 130, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-9057-5-V2', '1kg', 260, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Red Kidney Beans Rajma', 
        'PUL-2668-6', 
        cat_id, 
        140, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Red%20Kidney%20Beans%20Rajma%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=657'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-2668-6-V1', '500g', 140, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-2668-6-V2', '1kg', 280, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Black Chickpeas', 
        'PUL-3699-7', 
        cat_id, 
        90, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Black%20Chickpeas%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=673'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-3699-7-V1', '500g', 90, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'PUL-3699-7-V2', '1kg', 180, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Sunflower Oil', 
        'OIL-4505-0', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Sunflower%20Oil%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=199'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-4505-0-V1', '1L', 150, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-4505-0-V2', '5L', 300, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Mustard Oil', 
        'OIL-8370-1', 
        cat_id, 
        180, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Mustard%20Oil%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=548'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-8370-1-V1', '1L', 180, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-8370-1-V2', '5L', 360, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Peanut Oil', 
        'OIL-1246-2', 
        cat_id, 
        200, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Peanut%20Oil%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=113'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-1246-2-V1', '1L', 200, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-1246-2-V2', '5L', 400, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Olive Oil', 
        'OIL-5497-3', 
        cat_id, 
        800, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Olive%20Oil%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=917'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-5497-3-V1', '500ml', 800, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-5497-3-V2', '1L', 1600, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Turmeric Powder in a bowl', 
        'OIL-9865-4', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Turmeric%20Powder%20in%20a%20bowl%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=111'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-9865-4-V1', '200g', 40, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-9865-4-V2', '500g', 80, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Red Chilli Powder in a bowl', 
        'OIL-5691-5', 
        cat_id, 
        50, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Red%20Chilli%20Powder%20in%20a%20bowl%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=211'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-5691-5-V1', '200g', 50, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-5691-5-V2', '500g', 100, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Coriander Powder in a bowl', 
        'OIL-3213-6', 
        cat_id, 
        45, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Coriander%20Powder%20in%20a%20bowl%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=677'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-3213-6-V1', '200g', 45, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-3213-6-V2', '500g', 90, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Cumin Seeds', 
        'OIL-6308-7', 
        cat_id, 
        70, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Cumin%20Seeds%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=996'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-6308-7-V1', '100g', 70, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-6308-7-V2', '200g', 140, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Black Mustard Seeds', 
        'OIL-6272-8', 
        cat_id, 
        30, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Black%20Mustard%20Seeds%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=400'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-6272-8-V1', '100g', 30, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Oils & Spices';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Garam Masala Spice Mix', 
        'OIL-111-9', 
        cat_id, 
        80, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Garam%20Masala%20Spice%20Mix%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=106'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'OIL-111-9-V1', '100g', 80, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bag of Potato Chips', 
        'SNA-7628-0', 
        cat_id, 
        20, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bag%20of%20Potato%20Chips%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=439'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-7628-0-V1', '50g', 20, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-7628-0-V2', '100g', 40, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Nachos with cheese', 
        'SNA-8120-1', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Nachos%20with%20cheese%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=28'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-8120-1-V1', '100g', 40, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Roasted Salted Peanuts', 
        'SNA-1121-2', 
        cat_id, 
        50, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Roasted%20Salted%20Peanuts%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=54'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-1121-2-V1', '200g', 50, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Raw Almonds', 
        'SNA-9434-3', 
        cat_id, 
        250, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Raw%20Almonds%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=639'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-9434-3-V1', '250g', 250, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-9434-3-V2', '500g', 500, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Raw Cashew Nuts', 
        'SNA-7394-4', 
        cat_id, 
        300, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Raw%20Cashew%20Nuts%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=877'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-7394-4-V1', '250g', 300, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-7394-4-V2', '500g', 600, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Shelled Walnuts', 
        'SNA-6778-5', 
        cat_id, 
        350, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Shelled%20Walnuts%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=523'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-6778-5-V1', '250g', 350, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Sweet Raisins', 
        'SNA-2524-6', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Sweet%20Raisins%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=457'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-2524-6-V1', '250g', 150, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Sweet Dates', 
        'SNA-2658-7', 
        cat_id, 
        200, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Sweet%20Dates%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=982'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'SNA-2658-7-V1', '500g', 200, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Loose Black Tea Leaves', 
        'BEV-2752-0', 
        cat_id, 
        120, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Loose%20Black%20Tea%20Leaves%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=620'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-2752-0-V1', '250g', 120, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-2752-0-V2', '500g', 240, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Green Tea Bags', 
        'BEV-5301-1', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Green%20Tea%20Bags%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=138'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-5301-1-V1', '25pcs', 150, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Instant Coffee Powder', 
        'BEV-5104-2', 
        cat_id, 
        180, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Instant%20Coffee%20Powder%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=624'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-5104-2-V1', '50g', 180, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-5104-2-V2', '100g', 360, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Filter Coffee Powder', 
        'BEV-9696-3', 
        cat_id, 
        140, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Filter%20Coffee%20Powder%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=759'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-9696-3-V1', '250g', 140, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Glass of Apple Juice', 
        'BEV-297-4', 
        cat_id, 
        110, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Glass%20of%20Apple%20Juice%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=412'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-297-4-V1', '1L', 110, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Glass of Orange Juice', 
        'BEV-1124-5', 
        cat_id, 
        110, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Glass%20of%20Orange%20Juice%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=407'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-1124-5-V1', '1L', 110, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Cola Soft Drink', 
        'BEV-2580-6', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Cola%20Soft%20Drink%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=183'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-2580-6-V1', '500ml', 40, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-2580-6-V2', '2L', 80, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Mineral Water', 
        'BEV-9509-7', 
        cat_id, 
        20, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Mineral%20Water%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=722'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-9509-7-V1', '1L', 20, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'BEV-9509-7-V2', '5L', 40, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Tube of Toothpaste', 
        'DAI-6431-0', 
        cat_id, 
        80, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Tube%20of%20Toothpaste%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=668'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-6431-0-V1', '100g', 80, 50);
        
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-6431-0-V2', '200g', 160, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bar of Bath Soap', 
        'DAI-6946-1', 
        cat_id, 
        40, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bar%20of%20Bath%20Soap%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=314'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-6946-1-V1', '100g', 40, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Hair Shampoo', 
        'DAI-417-2', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Hair%20Shampoo%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=748'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-417-2-V1', '200ml', 150, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Dishwash Liquid', 
        'DAI-4920-3', 
        cat_id, 
        60, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Dishwash%20Liquid%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=359'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-4920-3-V1', '250ml', 60, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Laundry Detergent Powder', 
        'DAI-3206-4', 
        cat_id, 
        120, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Laundry%20Detergent%20Powder%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=170'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-3206-4-V1', '1kg', 120, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Bottle of Floor Cleaner', 
        'DAI-9972-5', 
        cat_id, 
        90, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Bottle%20of%20Floor%20Cleaner%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=794'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-9972-5-V1', '500ml', 90, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Roll of Toilet Paper', 
        'DAI-8317-6', 
        cat_id, 
        150, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Roll%20of%20Toilet%20Paper%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=146'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-8317-6-V1', '4rolls', 150, 50);
        
    SELECT id INTO cat_id FROM public.categories WHERE name = 'Daily Essentials';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        'Roll of Garbage Bags', 
        'DAI-7103-7', 
        cat_id, 
        60, 
        100, 
        'https://image.pollinations.ai/prompt/A%20highly%20detailed%20professional%20grocery%20photography%20of%20Roll%20of%20Garbage%20Bags%2C%20clean%20studio%20lighting%2C%20realistic%2C%204k?width=500&height=500&nologo=true&seed=43'
    ) RETURNING id INTO prod_id;
    
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, 'DAI-7103-7-V1', '30pcs', 60, 50);
        
END $$;
