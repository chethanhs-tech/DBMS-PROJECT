---------------------------------------------------------------------
-- 🚨 OFFICIAL INVENTORY RESTORATION SCRIPT
---------------------------------------------------------------------

-- This script will instantly restore a comprehensive, high-quality inventory
-- across multiple categories to get your store back to professional status.

-- 1. Ensure Suppliers exist
INSERT INTO public.suppliers (supplier_name, contact, address) VALUES
('Fresh Harvest India', 'orders@freshharvest.in', 'Nashik, Maharashtra'),
('Global Pantry Logistics', 'supply@globalpantry.com', 'Mumbai, Maharashtra'),
('Green Leaf Organic', 'contact@greenleaf.org', 'Ooty, Tamil Nadu')
ON CONFLICT DO NOTHING;

-- 2. Bulk Insert Products (50+ Items)
DO $$
DECLARE
    fresh_id UUID;
    global_id UUID;
    green_id UUID;
BEGIN
    SELECT id INTO fresh_id FROM public.suppliers WHERE supplier_name = 'Fresh Harvest India' LIMIT 1;
    SELECT id INTO global_id FROM public.suppliers WHERE supplier_name = 'Global Pantry Logistics' LIMIT 1;
    SELECT id INTO green_id FROM public.suppliers WHERE supplier_name = 'Green Leaf Organic' LIMIT 1;

    INSERT INTO public.products (product_name, sku, category, quantity, price, reorder_level, unit, supplier_id, image_url)
    VALUES 
    -- Fruits
    ('Alphonso Mangoes', 'FRU-MAN-001', 'Fruits', 50, 450.00, 10, '1 doz', fresh_id, 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=800'),
    ('Washington Apples', 'FRU-APP-002', 'Fruits', 100, 220.00, 20, '1kg', fresh_id, 'https://images.unsplash.com/photo-1560806887-1e436279f0fb?w=800'),
    ('California Grapes', 'FRU-GRA-001', 'Fruits', 75, 180.00, 15, '500g', fresh_id, 'https://images.unsplash.com/photo-1537640538966-79f369b41e8f?w=800'),
    ('Cavendish Bananas', 'FRU-BAN-002', 'Fruits', 200, 60.00, 40, '1 doz', fresh_id, 'https://images.unsplash.com/photo-1603833665858-e81b1c7e4663?w=800'),
    ('Valencia Oranges', 'FRU-ORA-001', 'Fruits', 120, 140.00, 25, '1kg', fresh_id, 'https://images.unsplash.com/photo-1557800636-894a64c1696f?w=800'),
    ('Kiwi (Imported)', 'FRU-KIW-001', 'Fruits', 60, 150.00, 10, '3 units', fresh_id, 'https://images.unsplash.com/photo-1585059895316-298928620301?w=800'),
    
    -- Vegetables
    ('Hybrid Tomatoes', 'VEG-TOM-002', 'Vegetables', 150, 40.00, 50, '1kg', green_id, 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=800'),
    ('Agra Potatoes', 'VEG-POT-002', 'Vegetables', 300, 35.00, 60, '1kg', green_id, 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=800'),
    ('Red Onions', 'VEG-ONI-001', 'Vegetables', 250, 42.00, 50, '1kg', green_id, 'https://images.unsplash.com/photo-1508747703725-719777637510?w=800'),
    ('Baby Spinach', 'VEG-SPI-002', 'Vegetables', 80, 25.00, 20, '1 bundle', green_id, 'https://images.unsplash.com/photo-1551008475-4533d14444d3?w=800'),
    ('Cauliflower', 'VEG-CAU-001', 'Vegetables', 40, 60.00, 10, '1 unit', green_id, 'https://images.unsplash.com/photo-1568584711075-3d021a7c3ca3?w=800'),
    ('English Cucumber', 'VEG-CUC-001', 'Vegetables', 90, 45.00, 20, '500g', green_id, 'https://images.unsplash.com/photo-1449333256619-8b05ff81c814?w=800'),
    
    -- Dairy
    ('Amul Gold Milk', 'DAI-MIL-002', 'Dairy', 500, 66.00, 100, '1L', global_id, 'https://images.unsplash.com/photo-1550583724-1255818c0533?w=800'),
    ('Farm Fresh Eggs', 'DAI-EGG-001', 'Dairy', 300, 90.00, 50, '1 doz', fresh_id, 'https://images.unsplash.com/photo-1516448138547-797d7041c0ca?w=800'),
    ('Greek Yogurt', 'DAI-YOG-002', 'Dairy', 100, 85.00, 20, '400g', global_id, 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
    ('Salted Butter', 'DAI-BUT-002', 'Dairy', 80, 255.00, 15, '500g', global_id, 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=800'),
    ('Cheddar Cheese', 'DAI-CHE-001', 'Dairy', 60, 450.00, 10, '200g', global_id, 'https://images.unsplash.com/photo-1485962391905-dd37bb8c7944?w=800'),
    
    -- Pantry Staples
    ('Extra Long Basmati', 'PAN-RIC-002', 'Pantry', 400, 195.00, 50, '1kg', global_id, 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=800'),
    ('Multigrain Atta', 'PAN-ATT-002', 'Pantry', 300, 240.00, 40, '5kg', global_id, 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800'),
    ('Olive Oil (Extra Virgin)', 'PAN-OIL-001', 'Pantry', 80, 850.00, 15, '1L', global_id, 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=800'),
    ('Red Chilli Powder', 'PAN-SPI-001', 'Pantry', 100, 65.00, 20, '200g', fresh_id, 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=800'),
    ('Turmeric Organic', 'PAN-SPI-002', 'Pantry', 120, 55.00, 20, '200g', fresh_id, 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=800'),
    
    -- Snacks
    ('Classic Salted Lays', 'SNA-CHI-002', 'Snacks', 150, 50.00, 30, '1 Pack', global_id, 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=800'),
    ('Oreo Biscuits', 'SNA-BIS-002', 'Snacks', 100, 40.00, 20, '1 Pack', global_id, 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=800'),
    ('Dark Chocolate (70%)', 'SNA-CHO-002', 'Snacks', 120, 180.00, 25, '100g', global_id, 'https://images.unsplash.com/photo-1515037893149-de7f402540af?w=800'),
    ('Roasted Almonds', 'SNA-NUT-001', 'Snacks', 80, 450.00, 15, '200g', fresh_id, 'https://images.unsplash.com/photo-1508061253366-f7da158b6d46?w=800'),
    
    -- Beverages
    ('Pure Green Tea', 'BEV-TEA-001', 'Beverages', 100, 280.00, 20, '100g', global_id, 'https://images.unsplash.com/photo-1544787210-2136d80a071d?w=800'),
    ('Coffee (Instant Classic)', 'BEV-COF-001', 'Beverages', 85, 320.00, 15, '200g', global_id, 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=800'),
    ('Orange Juice (Fresh)', 'BEV-JUI-001', 'Beverages', 50, 95.00, 10, '1L', fresh_id, 'https://images.unsplash.com/photo-1624517452488-04869289c4ca?w=800'),
    ('Aerated Water', 'BEV-WAT-001', 'Beverages', 200, 20.00, 40, '1L', global_id, 'https://images.unsplash.com/photo-1523362628744-0c10a1bb20f4?w=800')
    ON CONFLICT (sku) DO UPDATE SET
        quantity = EXCLUDED.quantity,
        price = EXCLUDED.price;
END $$;
