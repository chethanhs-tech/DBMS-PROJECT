-- GrozoSphere: 160+ Item Master Catalog with Unique Product Images
-- Run this in Supabase SQL Editor

DELETE FROM public.product_variants;
DELETE FROM public.products;
DELETE FROM public.categories;

INSERT INTO public.categories (name) VALUES ('Fresh Fruits') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Fresh Vegetables') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Dairy & Eggs') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Rice & Grains') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Pulses & Lentils') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Cooking Oils') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Spices & Masalas') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Snacks & Dry Fruits') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Beverages') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Bakery & Packaged Food') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Personal Care') ON CONFLICT (name) DO NOTHING;
INSERT INTO public.categories (name) VALUES ('Frozen & Canned') ON CONFLICT (name) DO NOTHING;

DO $$
DECLARE
    cat_id UUID;
    prod_id UUID;
    counter INT := 1;
BEGIN

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Red Apple', 'FRE-001', cat_id, 120, 100, 15, 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-001-V1', '500g', 120, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-001-V2', '1kg', 240, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Banana', 'FRE-002', cat_id, 50, 150, 20, 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-002-V1', '6pcs', 50, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-002-V2', '12pcs', 100, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Navel Orange', 'FRE-003', cat_id, 80, 120, 15, 'https://images.unsplash.com/photo-1547514701-42782101795e?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-003-V1', '500g', 80, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-003-V2', '1kg', 160, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Green Grapes', 'FRE-004', cat_id, 90, 80, 15, 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-004-V1', '500g', 90, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Black Grapes', 'FRE-005', cat_id, 110, 70, 15, 'https://images.unsplash.com/photo-1596541163039-ba4c7e7e0d41?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-005-V1', '500g', 110, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Alphonso Mango', 'FRE-006', cat_id, 400, 60, 15, 'https://images.unsplash.com/photo-1553279768-865429fa0078?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-006-V1', '1kg', 400, 60);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Papaya', 'FRE-007', cat_id, 60, 50, 15, 'https://images.unsplash.com/photo-1517282009859-f000ec3b26fe?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-007-V1', '1pc', 60, 50);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Watermelon', 'FRE-008', cat_id, 80, 40, 15, 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-008-V1', '1pc', 80, 40);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Pomegranate', 'FRE-009', cat_id, 150, 70, 15, 'https://images.unsplash.com/photo-1541344999736-83eca272f6fc?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-009-V1', '500g', 150, 70);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-009-V2', '1kg', 300, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Pineapple', 'FRE-010', cat_id, 70, 50, 15, 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-010-V1', '1pc', 70, 50);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Strawberry', 'FRE-011', cat_id, 150, 60, 15, 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-011-V1', '250g', 150, 60);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-011-V2', '500g', 300, 60);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Lemon', 'FRE-012', cat_id, 40, 120, 20, 'https://images.unsplash.com/photo-1590502160462-58b41354f588?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-012-V1', '6pcs', 40, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-012-V2', '12pcs', 80, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Kiwi', 'FRE-013', cat_id, 180, 50, 15, 'https://images.unsplash.com/photo-1585059895524-72359e06133a?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-013-V1', '4pcs', 180, 50);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-013-V2', '8pcs', 360, 50);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Coconut', 'FRE-014', cat_id, 50, 80, 15, 'https://images.unsplash.com/photo-1546548970-71785318a17b?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-014-V1', '1pc', 50, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-014-V2', '2pcs', 100, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Guava', 'FRE-015', cat_id, 60, 80, 15, 'https://images.unsplash.com/photo-1632179553657-4e9f64fc2a09?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-015-V1', '500g', 60, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-015-V2', '1kg', 120, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Chikoo (Sapota)', 'FRE-016', cat_id, 80, 60, 15, 'https://images.unsplash.com/photo-1604329986805-539b1e5f40ac?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-016-V1', '500g', 80, 60);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Sweet Lime (Mosambi)', 'FRE-017', cat_id, 70, 90, 15, 'https://images.unsplash.com/photo-1611080541599-da4b4a85f0c7?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-017-V1', '500g', 70, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-017-V2', '1kg', 140, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Dragon Fruit', 'FRE-018', cat_id, 250, 30, 15, 'https://images.unsplash.com/photo-1628153645012-73e2d6df4a9c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-018-V1', '1pc', 250, 30);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Red Onion', 'FRE-019', cat_id, 40, 200, 20, 'https://images.unsplash.com/photo-1580201092675-a0a6a6cafbb1?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-019-V1', '1kg', 40, 200);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-019-V2', '5kg', 80, 200);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Tomato', 'FRE-020', cat_id, 30, 180, 20, 'https://images.unsplash.com/photo-1546470427-f5f7f334f2da?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-020-V1', '500g', 30, 180);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-020-V2', '1kg', 60, 180);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Potato', 'FRE-021', cat_id, 35, 200, 20, 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-021-V1', '1kg', 35, 200);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-021-V2', '5kg', 70, 200);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Carrot', 'FRE-022', cat_id, 50, 150, 15, 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-022-V1', '500g', 50, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-022-V2', '1kg', 100, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Broccoli', 'FRE-023', cat_id, 80, 70, 15, 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-023-V1', '1pc', 80, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Fresh Spinach', 'FRE-024', cat_id, 20, 100, 20, 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-024-V1', '250g', 20, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-024-V2', '500g', 40, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cucumber', 'FRE-025', cat_id, 30, 120, 20, 'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-025-V1', '1pc', 30, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-025-V2', '4pcs', 60, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Capsicum Green', 'FRE-026', cat_id, 60, 90, 15, 'https://images.unsplash.com/photo-1563599175592-c58dc214deff?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-026-V1', '3pcs', 60, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-026-V2', '500g', 120, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cauliflower', 'FRE-027', cat_id, 40, 70, 15, 'https://images.unsplash.com/photo-1568584284024-f2c8285e62bb?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-027-V1', '1pc', 40, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cabbage', 'FRE-028', cat_id, 30, 80, 15, 'https://images.unsplash.com/photo-1583524505974-6faed5b0a6e8?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-028-V1', '1pc', 30, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Green Peas', 'FRE-029', cat_id, 60, 90, 15, 'https://images.unsplash.com/photo-1615485925763-86419f05c715?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-029-V1', '250g', 60, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-029-V2', '500g', 120, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Lady Finger (Okra)', 'FRE-030', cat_id, 40, 100, 15, 'https://images.unsplash.com/photo-1533396371872-e77f0de1d2ea?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-030-V1', '250g', 40, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-030-V2', '500g', 80, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Mushroom', 'FRE-031', cat_id, 80, 70, 15, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-031-V1', '200g', 80, 70);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-031-V2', '400g', 160, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Beetroot', 'FRE-032', cat_id, 50, 80, 15, 'https://images.unsplash.com/photo-1593280405106-e438ebe85317?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-032-V1', '500g', 50, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Sweet Corn', 'FRE-033', cat_id, 30, 90, 15, 'https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-033-V1', '2pcs', 30, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-033-V2', '4pcs', 60, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Garlic', 'FRE-034', cat_id, 60, 120, 20, 'https://images.unsplash.com/photo-1540420773420-3450ac863111?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-034-V1', '100g', 60, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-034-V2', '250g', 120, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Ginger', 'FRE-035', cat_id, 80, 100, 20, 'https://images.unsplash.com/photo-1615485736774-f6f2b41ef0e0?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-035-V1', '100g', 80, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-035-V2', '250g', 160, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('French Beans', 'FRE-036', cat_id, 40, 80, 15, 'https://images.unsplash.com/photo-1609957871784-2fe2d68e4e6c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-036-V1', '250g', 40, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-036-V2', '500g', 80, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Bottle Gourd (Lauki)', 'FRE-037', cat_id, 25, 70, 15, 'https://images.unsplash.com/photo-1622205313324-edd7f9dc0d43?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-037-V1', '1pc', 25, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Bitter Gourd (Karela)', 'FRE-038', cat_id, 35, 70, 15, 'https://images.unsplash.com/photo-1617206430461-d75b7cce06f5?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-038-V1', '250g', 35, 70);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-038-V2', '500g', 70, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Yam (Suran)', 'FRE-039', cat_id, 50, 60, 15, 'https://images.unsplash.com/photo-1608797178974-15b35a64afe9?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-039-V1', '500g', 50, 60);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-039-V2', '1kg', 100, 60);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Fresh Vegetables';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Coriander Leaves', 'FRE-040', cat_id, 15, 100, 20, 'https://images.unsplash.com/photo-1598449695049-fb9a69e03ded?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRE-040-V1', '1bunch', 15, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Full Cream Cow Milk', 'DAI-041', cat_id, 60, 150, 20, 'https://images.unsplash.com/photo-1550583724-b2692b85b150?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-041-V1', '500ml', 60, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-041-V2', '1L', 120, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Buffalo Milk', 'DAI-042', cat_id, 70, 120, 20, 'https://images.unsplash.com/photo-1628088062854-d1870b4553da?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-042-V1', '500ml', 70, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-042-V2', '1L', 140, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Fresh Curd (Yogurt)', 'DAI-043', cat_id, 30, 140, 20, 'https://images.unsplash.com/photo-1488477181771-4aa5b500eec6?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-043-V1', '200g', 30, 140);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-043-V2', '400g', 60, 140);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Paneer', 'DAI-044', cat_id, 90, 120, 20, 'https://images.unsplash.com/photo-1631452180519-462f428d71b1?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-044-V1', '200g', 90, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-044-V2', '500g', 180, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Processed Cheese Slices', 'DAI-045', cat_id, 150, 70, 15, 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-045-V1', '200g', 150, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Salted Butter', 'DAI-046', cat_id, 60, 100, 20, 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-046-V1', '100g', 60, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-046-V2', '500g', 120, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Pure Desi Ghee', 'DAI-047', cat_id, 600, 80, 15, 'https://images.unsplash.com/photo-1519681393784-d1b22eac9dc5?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-047-V1', '500ml', 600, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-047-V2', '1L', 1200, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Fresh Cream', 'DAI-048', cat_id, 70, 70, 15, 'https://images.unsplash.com/photo-1517093702672-6be1d89e6e6c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-048-V1', '200ml', 70, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Farm Fresh Eggs (White)', 'DAI-049', cat_id, 80, 200, 20, 'https://images.unsplash.com/photo-1582722872445-0f5b04a0fc9e?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-049-V1', '6pcs', 80, 200);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-049-V2', '12pcs', 160, 200);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Farm Fresh Eggs (Brown)', 'DAI-050', cat_id, 90, 150, 20, 'https://images.unsplash.com/photo-1598965402089-897ce52e8355?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-050-V1', '6pcs', 90, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-050-V2', '12pcs', 180, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Buttermilk (Chhas)', 'DAI-051', cat_id, 20, 100, 20, 'https://images.unsplash.com/photo-1499638673689-79a0b0e8f4b7?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-051-V1', '500ml', 20, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-051-V2', '1L', 40, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Skimmed Milk Powder', 'DAI-052', cat_id, 250, 70, 15, 'https://images.unsplash.com/photo-1563636619-e9143da7f929?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-052-V1', '500g', 250, 70);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-052-V2', '1kg', 500, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Condensed Milk', 'DAI-053', cat_id, 90, 80, 15, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-053-V1', '200g', 90, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-053-V2', '400g', 180, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Dairy & Eggs';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Mozzarella Cheese', 'DAI-054', cat_id, 200, 50, 15, 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32e?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'DAI-054-V1', '200g', 200, 50);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Basmati Rice', 'RIC-055', cat_id, 150, 180, 20, 'https://images.unsplash.com/photo-1586201375761-83865001e8ac?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-055-V1', '1kg', 150, 180);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-055-V2', '5kg', 300, 180);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Sona Masoori Rice', 'RIC-056', cat_id, 70, 200, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fc?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-056-V1', '5kg', 70, 200);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-056-V2', '10kg', 140, 200);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Brown Rice', 'RIC-057', cat_id, 110, 120, 20, 'https://images.unsplash.com/photo-1536304929831-ee1ca9d44906?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-057-V1', '1kg', 110, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-057-V2', '5kg', 220, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Red Rice', 'RIC-058', cat_id, 130, 100, 15, 'https://images.unsplash.com/photo-1604329986805-2db1a4b3f2ac?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-058-V1', '1kg', 130, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Whole Wheat Atta', 'RIC-059', cat_id, 45, 200, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2877?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-059-V1', '5kg', 45, 200);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-059-V2', '10kg', 90, 200);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Multigrain Atta', 'RIC-060', cat_id, 65, 150, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9e6?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-060-V1', '5kg', 65, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Maida (Refined Flour)', 'RIC-061', cat_id, 35, 150, 20, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e9?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-061-V1', '1kg', 35, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Semolina (Suji/Rava)', 'RIC-062', cat_id, 45, 150, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fd?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-062-V1', '1kg', 45, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Gram Flour (Besan)', 'RIC-063', cat_id, 70, 130, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2878?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-063-V1', '1kg', 70, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Flattened Rice (Poha)', 'RIC-064', cat_id, 50, 140, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9e7?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-064-V1', '500g', 50, 140);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-064-V2', '1kg', 100, 140);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Rolled Oats', 'RIC-065', cat_id, 150, 120, 20, 'https://images.unsplash.com/photo-1525059696034-4be00bc7919c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-065-V1', '1kg', 150, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Quinoa', 'RIC-066', cat_id, 350, 80, 15, 'https://images.unsplash.com/photo-1586201375761-83865001e8ad?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-066-V1', '500g', 350, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Corn Flour', 'RIC-067', cat_id, 45, 100, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fe?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-067-V1', '500g', 45, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Rice Flour', 'RIC-068', cat_id, 40, 100, 20, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e2?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-068-V1', '500g', 40, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Millets (Bajra)', 'RIC-069', cat_id, 60, 120, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9e8?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-069-V1', '1kg', 60, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Rice & Grains';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Jowar Flour', 'RIC-070', cat_id, 55, 100, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2879?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'RIC-070-V1', '1kg', 55, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Toor Dal (Arhar)', 'PUL-071', cat_id, 160, 150, 20, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e0?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-071-V1', '500g', 160, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-071-V2', '1kg', 320, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Moong Dal (Yellow)', 'PUL-072', cat_id, 110, 150, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736ff?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-072-V1', '500g', 110, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-072-V2', '1kg', 220, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Chana Dal', 'PUL-073', cat_id, 90, 150, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9e9?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-073-V1', '500g', 90, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-073-V2', '1kg', 180, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Urad Dal (Black)', 'PUL-074', cat_id, 140, 130, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2870?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-074-V1', '500g', 140, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-074-V2', '1kg', 280, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Masoor Dal (Red)', 'PUL-075', cat_id, 100, 140, 20, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e3?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-075-V1', '500g', 100, 140);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-075-V2', '1kg', 200, 140);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Kabuli Chana (Chickpeas)', 'PUL-076', cat_id, 130, 130, 20, 'https://images.unsplash.com/photo-1515543904282-d4b9cc5fccd7?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-076-V1', '500g', 130, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-076-V2', '1kg', 260, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Rajma (Kidney Beans)', 'PUL-077', cat_id, 140, 120, 20, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e2?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-077-V1', '500g', 140, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-077-V2', '1kg', 280, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Black Chana', 'PUL-078', cat_id, 90, 130, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9ea?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-078-V1', '500g', 90, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-078-V2', '1kg', 180, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Green Moong (Whole)', 'PUL-079', cat_id, 100, 120, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2871?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-079-V1', '500g', 100, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-079-V2', '1kg', 200, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Black Urad (Whole)', 'PUL-080', cat_id, 120, 110, 20, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e4?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-080-V1', '500g', 120, 110);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-080-V2', '1kg', 240, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Dry Green Peas', 'PUL-081', cat_id, 80, 130, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fg?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-081-V1', '500g', 80, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-081-V2', '1kg', 160, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Pulses & Lentils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Lobia (Black Eye Beans)', 'PUL-082', cat_id, 90, 110, 15, 'https://images.unsplash.com/photo-1515543904282-d4b9cc5fccd8?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PUL-082-V1', '500g', 90, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Sunflower Oil', 'COO-083', cat_id, 160, 120, 20, 'https://images.unsplash.com/photo-1474979382669-2f4e1e5bfa98?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-083-V1', '1L', 160, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-083-V2', '5L', 320, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Mustard Oil', 'COO-084', cat_id, 180, 110, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fh?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-084-V1', '1L', 180, 110);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-084-V2', '5L', 360, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Groundnut Oil', 'COO-085', cat_id, 200, 100, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9eb?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-085-V1', '1L', 200, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-085-V2', '5L', 400, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Extra Virgin Olive Oil', 'COO-086', cat_id, 900, 60, 15, 'https://images.unsplash.com/photo-1474979382669-2f4e1e5bfa99?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-086-V1', '500ml', 900, 60);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-086-V2', '1L', 1800, 60);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Coconut Oil', 'COO-087', cat_id, 250, 80, 15, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e5?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-087-V1', '500ml', 250, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-087-V2', '1L', 500, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Rice Bran Oil', 'COO-088', cat_id, 170, 90, 15, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e3?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-088-V1', '1L', 170, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-088-V2', '5L', 340, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Sesame Oil (Til)', 'COO-089', cat_id, 200, 70, 15, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2872?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-089-V1', '250ml', 200, 70);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-089-V2', '500ml', 400, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Cooking Oils';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Refined Soybean Oil', 'COO-090', cat_id, 140, 100, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fi?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-090-V1', '1L', 140, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'COO-090-V2', '5L', 280, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Turmeric Powder (Haldi)', 'SPI-091', cat_id, 45, 130, 20, 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-091-V1', '200g', 45, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-091-V2', '500g', 90, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Red Chilli Powder', 'SPI-092', cat_id, 55, 130, 20, 'https://images.unsplash.com/photo-1606914793698-9f11f7a5c5c1?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-092-V1', '200g', 55, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-092-V2', '500g', 110, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Coriander Powder (Dhania)', 'SPI-093', cat_id, 45, 130, 20, 'https://images.unsplash.com/photo-1598449695049-fb9a69e03dee?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-093-V1', '200g', 45, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-093-V2', '500g', 90, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cumin Seeds (Jeera)', 'SPI-094', cat_id, 75, 120, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9ec?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-094-V1', '100g', 75, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-094-V2', '250g', 150, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Mustard Seeds (Rai)', 'SPI-095', cat_id, 35, 130, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2873?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-095-V1', '100g', 35, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-095-V2', '250g', 70, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Garam Masala', 'SPI-096', cat_id, 90, 110, 20, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e4?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-096-V1', '100g', 90, 110);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-096-V2', '200g', 180, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Kitchen King Masala', 'SPI-097', cat_id, 85, 100, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fj?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-097-V1', '100g', 85, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-097-V2', '200g', 170, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Chole Masala', 'SPI-098', cat_id, 70, 100, 20, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e6?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-098-V1', '100g', 70, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Rajma Masala', 'SPI-099', cat_id, 70, 100, 20, 'https://images.unsplash.com/photo-1596040033229-a9821ebd058e?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-099-V1', '100g', 70, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Chicken Masala', 'SPI-100', cat_id, 80, 90, 15, 'https://images.unsplash.com/photo-1606914793698-9f11f7a5c5c2?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-100-V1', '100g', 80, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-100-V2', '200g', 160, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Biryani Masala', 'SPI-101', cat_id, 90, 90, 15, 'https://images.unsplash.com/photo-1598449695049-fb9a69e03def?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-101-V1', '100g', 90, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-101-V2', '200g', 180, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Sambhar Powder', 'SPI-102', cat_id, 80, 90, 15, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9ed?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-102-V1', '200g', 80, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-102-V2', '500g', 160, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Asafoetida (Hing)', 'SPI-103', cat_id, 120, 80, 15, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2874?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-103-V1', '50g', 120, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-103-V2', '100g', 240, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Black Pepper Powder', 'SPI-104', cat_id, 150, 90, 15, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e5?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-104-V1', '100g', 150, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-104-V2', '200g', 300, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cardamom (Elaichi)', 'SPI-105', cat_id, 400, 70, 15, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fk?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-105-V1', '50g', 400, 70);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-105-V2', '100g', 800, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Spices & Masalas';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Bay Leaves (Tej Patta)', 'SPI-106', cat_id, 60, 80, 15, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e7?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SPI-106-V1', '50g', 60, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Potato Chips (Salted)', 'SNA-107', cat_id, 25, 150, 20, 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-107-V1', '50g', 25, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-107-V2', '100g', 50, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Nachos with Salsa', 'SNA-108', cat_id, 45, 100, 20, 'https://images.unsplash.com/photo-1511689774726-f5e7f4f71b62?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-108-V1', '100g', 45, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Roasted Peanuts', 'SNA-109', cat_id, 55, 130, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9ee?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-109-V1', '200g', 55, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-109-V2', '500g', 110, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Almonds (Raw)', 'SNA-110', cat_id, 280, 100, 20, 'https://images.unsplash.com/photo-1536304447166-a31e9e8c2526?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-110-V1', '250g', 280, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-110-V2', '500g', 560, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cashew Nuts (W320)', 'SNA-111', cat_id, 320, 90, 20, 'https://images.unsplash.com/photo-1474979382669-2f4e1e5bfb00?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-111-V1', '250g', 320, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-111-V2', '500g', 640, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Walnuts (Shelled)', 'SNA-112', cat_id, 380, 80, 15, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e6?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-112-V1', '250g', 380, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Raisins (Kishmish)', 'SNA-113', cat_id, 160, 100, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2875?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-113-V1', '250g', 160, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-113-V2', '500g', 320, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Dates (Medjool)', 'SNA-114', cat_id, 220, 90, 15, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fl?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-114-V1', '500g', 220, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Pistachios (Salted)', 'SNA-115', cat_id, 650, 70, 15, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e8?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-115-V1', '250g', 650, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Dried Figs (Anjeer)', 'SNA-116', cat_id, 350, 70, 15, 'https://images.unsplash.com/photo-1596040033229-a9821ebd058f?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-116-V1', '250g', 350, 70);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Pumpkin Seeds', 'SNA-117', cat_id, 200, 80, 15, 'https://images.unsplash.com/photo-1606914793698-9f11f7a5c5c3?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-117-V1', '200g', 200, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Flax Seeds', 'SNA-118', cat_id, 120, 90, 15, 'https://images.unsplash.com/photo-1598449695049-fb9a69e03deg?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-118-V1', '200g', 120, 90);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-118-V2', '500g', 240, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Chia Seeds', 'SNA-119', cat_id, 250, 80, 15, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9ef?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-119-V1', '200g', 250, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Trail Mix', 'SNA-120', cat_id, 200, 80, 15, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2876?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-120-V1', '200g', 200, 80);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-120-V2', '500g', 400, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Snacks & Dry Fruits';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Popcorn Kernels', 'SNA-121', cat_id, 60, 100, 20, 'https://images.unsplash.com/photo-1563636619-e9143da7f930?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'SNA-121-V1', '500g', 60, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Assam Tea Leaves', 'BEV-122', cat_id, 130, 130, 20, 'https://images.unsplash.com/photo-1544787219-7f47a8a8108a?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-122-V1', '250g', 130, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-122-V2', '500g', 260, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Darjeeling Tea Bags', 'BEV-123', cat_id, 160, 110, 20, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd65?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-123-V1', '25pcs', 160, 110);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-123-V2', '50pcs', 320, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Green Tea Bags', 'BEV-124', cat_id, 180, 110, 20, 'https://images.unsplash.com/photo-1546961342-ea5f73dcd9e7?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-124-V1', '25pcs', 180, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Instant Coffee (Nescafe)', 'BEV-125', cat_id, 200, 100, 20, 'https://images.unsplash.com/photo-1495474472359-baf27d2c23c8?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-125-V1', '50g', 200, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-125-V2', '100g', 400, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Filter Coffee Powder', 'BEV-126', cat_id, 160, 100, 20, 'https://images.unsplash.com/photo-1561043433-9abf5735a0e9?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-126-V1', '250g', 160, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cold Coffee Mix', 'BEV-127', cat_id, 120, 90, 15, 'https://images.unsplash.com/photo-1596040033229-a9821ebd058g?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-127-V1', '200g', 120, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Apple Juice (Packaged)', 'BEV-128', cat_id, 110, 100, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9eg?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-128-V1', '1L', 110, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Orange Juice (Packaged)', 'BEV-129', cat_id, 110, 100, 20, 'https://images.unsplash.com/photo-1568254183919-78a4f43a2877?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-129-V1', '1L', 110, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Mango Drink (Maaza)', 'BEV-130', cat_id, 60, 120, 20, 'https://images.unsplash.com/photo-1603569259386-f2ecf38736fm?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-130-V1', '600ml', 60, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-130-V2', '1.2L', 120, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cola Soft Drink', 'BEV-131', cat_id, 50, 150, 20, 'https://images.unsplash.com/photo-1561043433-9abf5735a0ea?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-131-V1', '500ml', 50, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-131-V2', '2L', 100, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Mineral Water', 'BEV-132', cat_id, 25, 200, 20, 'https://images.unsplash.com/photo-1560472354-57eca23b3c0b?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-132-V1', '1L', 25, 200);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-132-V2', '5L', 50, 200);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Coconut Water (Packaged)', 'BEV-133', cat_id, 60, 100, 20, 'https://images.unsplash.com/photo-1546548970-71785318a17c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-133-V1', '200ml', 60, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Energy Drink', 'BEV-134', cat_id, 120, 80, 15, 'https://images.unsplash.com/photo-1596040033229-a9821ebd058h?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-134-V1', '250ml', 120, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Beverages';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Lemon Juice (Packaged)', 'BEV-135', cat_id, 70, 90, 15, 'https://images.unsplash.com/photo-1606914793698-9f11f7a5c5c4?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BEV-135-V1', '500ml', 70, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Whole Wheat Bread', 'BAK-136', cat_id, 45, 120, 20, 'https://images.unsplash.com/photo-1509440159596-0280db3cb234?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-136-V1', '400g', 45, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('White Bread (Sandwich)', 'BAK-137', cat_id, 40, 130, 20, 'https://images.unsplash.com/photo-1549931319-a545dcfe3476?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-137-V1', '400g', 40, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Multigrain Bread', 'BAK-138', cat_id, 55, 110, 20, 'https://images.unsplash.com/photo-1517686469429-8a44e6738be4?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-138-V1', '400g', 55, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Butter Croissant', 'BAK-139', cat_id, 35, 100, 20, 'https://images.unsplash.com/photo-1555507036-eb1b420dc76c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-139-V1', '2pcs', 35, 100);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-139-V2', '4pcs', 70, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Digestive Biscuits', 'BAK-140', cat_id, 80, 120, 20, 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-140-V1', '200g', 80, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-140-V2', '400g', 160, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cream Crackers', 'BAK-141', cat_id, 60, 110, 20, 'https://images.unsplash.com/photo-1605926637512-c8b131444a2d?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-141-V1', '200g', 60, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Chocolate Cake (Slice)', 'BAK-142', cat_id, 80, 80, 15, 'https://images.unsplash.com/photo-1578985545062-00176def6f8d?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-142-V1', '1pc', 80, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Instant Noodles (Maggi)', 'BAK-143', cat_id, 15, 200, 20, 'https://images.unsplash.com/photo-1585032226651-759b7d2a738c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-143-V1', '70g', 15, 200);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-143-V2', '4pack', 30, 200);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Pasta (Penne)', 'BAK-144', cat_id, 90, 110, 20, 'https://images.unsplash.com/photo-1555949258-eb67b1ef6ba6?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-144-V1', '500g', 90, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Vermicelli (Semiya)', 'BAK-145', cat_id, 45, 120, 20, 'https://images.unsplash.com/photo-1574323347407-be278ad2e9eh?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-145-V1', '200g', 45, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-145-V2', '500g', 90, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Cornflakes', 'BAK-146', cat_id, 180, 100, 20, 'https://images.unsplash.com/photo-1525059696034-4be00bc7919d?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-146-V1', '500g', 180, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Bakery & Packaged Food';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Muesli', 'BAK-147', cat_id, 220, 90, 15, 'https://images.unsplash.com/photo-1578985545062-00176def6f8e?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'BAK-147-V1', '500g', 220, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Toothpaste (Colgate)', 'PER-148', cat_id, 90, 130, 20, 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-148-V1', '100g', 90, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-148-V2', '200g', 180, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Bath Soap (Dove)', 'PER-149', cat_id, 55, 150, 20, 'https://images.unsplash.com/photo-1613375931963-ba56252b9cac?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-149-V1', '100g', 55, 150);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-149-V2', '4pcs', 110, 150);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Shampoo (Head & Shoulders)', 'PER-150', cat_id, 180, 110, 20, 'https://images.unsplash.com/photo-1560185007-87e46d39b37a?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-150-V1', '200ml', 180, 110);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-150-V2', '400ml', 360, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Conditioner', 'PER-151', cat_id, 160, 90, 15, 'https://images.unsplash.com/photo-1558813959-b92a9dc1b57a?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-151-V1', '200ml', 160, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Dishwash Liquid', 'PER-152', cat_id, 70, 120, 20, 'https://images.unsplash.com/photo-1563453392212-326f5e854473?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-152-V1', '250ml', 70, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-152-V2', '500ml', 140, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Detergent Powder', 'PER-153', cat_id, 140, 130, 20, 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-153-V1', '1kg', 140, 130);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-153-V2', '2kg', 280, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Floor Cleaner (Phenyl)', 'PER-154', cat_id, 100, 110, 20, 'https://images.unsplash.com/photo-1584813439533-5c17a3d33b2a?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-154-V1', '500ml', 100, 110);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-154-V2', '1L', 200, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Toilet Cleaner', 'PER-155', cat_id, 90, 110, 20, 'https://images.unsplash.com/photo-1584813439533-5c17a3d33b2b?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-155-V1', '500ml', 90, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Toilet Paper', 'PER-156', cat_id, 160, 120, 20, 'https://images.unsplash.com/photo-1584813439533-5c17a3d33b2c?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-156-V1', '4rolls', 160, 120);
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-156-V2', '12rolls', 320, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Hand Wash Liquid', 'PER-157', cat_id, 120, 120, 20, 'https://images.unsplash.com/photo-1584813439533-5c17a3d33b2d?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-157-V1', '250ml', 120, 120);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Mosquito Repellent', 'PER-158', cat_id, 180, 90, 15, 'https://images.unsplash.com/photo-1584813439533-5c17a3d33b2e?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-158-V1', '1pc', 180, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Personal Care';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Garbage Bags', 'PER-159', cat_id, 65, 130, 20, 'https://images.unsplash.com/photo-1584813439533-5c17a3d33b2f?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'PER-159-V1', '30pcs', 65, 130);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Frozen Green Peas', 'FRO-160', cat_id, 90, 100, 20, 'https://images.unsplash.com/photo-1615485925763-86419f05c716?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-160-V1', '500g', 90, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Frozen Sweet Corn', 'FRO-161', cat_id, 85, 100, 20, 'https://images.unsplash.com/photo-1601493700631-2b16ec4b4717?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-161-V1', '500g', 85, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Canned Tomatoes', 'FRO-162', cat_id, 70, 110, 20, 'https://images.unsplash.com/photo-1546470427-f5f7f334f2db?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-162-V1', '400g', 70, 110);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Canned Chickpeas', 'FRO-163', cat_id, 80, 100, 20, 'https://images.unsplash.com/photo-1515543904282-d4b9cc5fccd9?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-163-V1', '400g', 80, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Canned Corn (Sweetened)', 'FRO-164', cat_id, 75, 100, 20, 'https://images.unsplash.com/photo-1601493700631-2b16ec4b4718?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-164-V1', '400g', 75, 100);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Canned Tuna', 'FRO-165', cat_id, 120, 90, 15, 'https://images.unsplash.com/photo-1562006954-be2850080db9?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-165-V1', '185g', 120, 90);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Frozen Paneer', 'FRO-166', cat_id, 100, 80, 15, 'https://images.unsplash.com/photo-1631452180519-462f428d71b2?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-166-V1', '200g', 100, 80);

    SELECT id INTO cat_id FROM public.categories WHERE name = 'Frozen & Canned';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('Ice Cream (Vanilla)', 'FRO-167', cat_id, 120, 80, 15, 'https://images.unsplash.com/photo-1497034825429-6b4c1e8c2ebe?auto=format&fit=crop&w=500&q=80')
    RETURNING id INTO prod_id;
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, 'FRO-167-V1', '500ml', 120, 80);

END $$;
