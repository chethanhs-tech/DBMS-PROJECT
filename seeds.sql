-- GROZOSPHERE FINAL SEED SCRIPT (PREMIUM AI ASSETS & VERIFIED MAPPING)
TRUNCATE public.transactions CASCADE;
TRUNCATE public.alerts CASCADE;
TRUNCATE public.product_variants CASCADE;
TRUNCATE public.products CASCADE;
TRUNCATE public.suppliers CASCADE;

-- 1. INSERT SUPPLIERS
INSERT INTO public.suppliers (id, supplier_name, contact_name, email, address) VALUES
('f1000000-0000-0000-0000-000000000001', 'Green Valley Fresh', 'John Fresh', 'supply@greenvalley.com', 'Nashik, Maharashtra'),
('f1000000-0000-0000-0000-000000000002', 'Global Dairy Staples', 'Jane Milk', 'orders@globaldairy.in', 'Bangalore, Karnataka'),
('f1000000-0000-0000-0000-000000000003', 'Sunrise Beverage Hub', 'Bob Sips', 'contact@sunrisebevhub.com', 'Mumbai, Maharashtra'),
('f1000000-0000-0000-0000-000000000004', 'Pure Essentials Co.', 'Alice Pure', 'info@pureessentials.com', 'New Delhi, Delhi');

-- 2. INSERT PRODUCTS AND VARIANTS

-- Category: Fruits
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001000', 'Alphonso Mango', 'ALP1000', 'Fruits', 0, 100.00, '/images/products/alphonso_mango.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009000', 'a0000000-0000-0000-0000-000000001000', 'ALP1000-250G', '250g', 15.000000, 5),
  ('b0000000-0000-0000-0000-000000009001', 'a0000000-0000-0000-0000-000000001000', 'ALP1000-500G', '500g', 30.000000, 5),
  ('b0000000-0000-0000-0000-000000009002', 'a0000000-0000-0000-0000-000000001000', 'ALP1000-1KG', '1kg', 50.000000, 5);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001001', 'Shimla Apple', 'SHI1001', 'Fruits', 0, 100.00, '/images/products/shimla_apple.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009003', 'a0000000-0000-0000-0000-000000001001', 'SHI1001-250G', '250g', 15.300000, 5),
  ('b0000000-0000-0000-0000-000000009004', 'a0000000-0000-0000-0000-000000001001', 'SHI1001-500G', '500g', 30.600000, 5),
  ('b0000000-0000-0000-0000-000000009005', 'a0000000-0000-0000-0000-000000001001', 'SHI1001-1KG', '1kg', 51.000000, 5);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001002', 'Banana (Robusta)', 'BAN1002', 'Fruits', 0, 100.00, '/images/products/banana_robusta.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009006', 'a0000000-0000-0000-0000-000000001002', 'BAN1002-250G', '250g', 15.600000, 5),
  ('b0000000-0000-0000-0000-000000009007', 'a0000000-0000-0000-0000-000000001002', 'BAN1002-500G', '500g', 31.200000, 5),
  ('b0000000-0000-0000-0000-000000009008', 'a0000000-0000-0000-0000-000000001002', 'BAN1002-1KG', '1kg', 52.000000, 5);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001003', 'Nagpur Orange', 'NAG1003', 'Fruits', 0, 100.00, '/images/products/nagpur_orange.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009009', 'a0000000-0000-0000-0000-000000001003', 'NAG1003-250G', '250g', 15.900000, 5),
  ('b0000000-0000-0000-0000-000000009010', 'a0000000-0000-0000-0000-000000001003', 'NAG1003-500G', '500g', 31.800000, 60),
  ('b0000000-0000-0000-0000-000000009011', 'a0000000-0000-0000-0000-000000001003', 'NAG1003-1KG', '1kg', 53.000000, 61);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001004', 'Green Grapes', 'GRE1004', 'Fruits', 0, 100.00, '/images/products/green_grapes.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009012', 'a0000000-0000-0000-0000-000000001004', 'GRE1004-250G', '250g', 16.200000, 62),
  ('b0000000-0000-0000-0000-000000009013', 'a0000000-0000-0000-0000-000000001004', 'GRE1004-500G', '500g', 32.400000, 63),
  ('b0000000-0000-0000-0000-000000009014', 'a0000000-0000-0000-0000-000000001004', 'GRE1004-1KG', '1kg', 54.000000, 64);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001005', 'Pomegranate', 'POM1005', 'Fruits', 0, 100.00, '/images/products/pomegranate.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009015', 'a0000000-0000-0000-0000-000000001005', 'POM1005-250G', '250g', 16.500000, 65),
  ('b0000000-0000-0000-0000-000000009016', 'a0000000-0000-0000-0000-000000001005', 'POM1005-500G', '500g', 33.000000, 66),
  ('b0000000-0000-0000-0000-000000009017', 'a0000000-0000-0000-0000-000000001005', 'POM1005-1KG', '1kg', 55.000000, 67);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001006', 'Watermelon', 'WAT1006', 'Fruits', 0, 100.00, '/images/products/watermelon.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009018', 'a0000000-0000-0000-0000-000000001006', 'WAT1006-250G', '250g', 16.800000, 68),
  ('b0000000-0000-0000-0000-000000009019', 'a0000000-0000-0000-0000-000000001006', 'WAT1006-500G', '500g', 33.600000, 69),
  ('b0000000-0000-0000-0000-000000009020', 'a0000000-0000-0000-0000-000000001006', 'WAT1006-1KG', '1kg', 56.000000, 70);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001007', 'Papaya', 'PAP1007', 'Fruits', 0, 100.00, '/images/products/papaya.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009021', 'a0000000-0000-0000-0000-000000001007', 'PAP1007-250G', '250g', 17.100000, 71),
  ('b0000000-0000-0000-0000-000000009022', 'a0000000-0000-0000-0000-000000001007', 'PAP1007-500G', '500g', 34.200000, 72),
  ('b0000000-0000-0000-0000-000000009023', 'a0000000-0000-0000-0000-000000001007', 'PAP1007-1KG', '1kg', 57.000000, 73);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001008', 'Pineapple', 'PIN1008', 'Fruits', 0, 100.00, '/images/products/pineapple.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009024', 'a0000000-0000-0000-0000-000000001008', 'PIN1008-250G', '250g', 17.400000, 74),
  ('b0000000-0000-0000-0000-000000009025', 'a0000000-0000-0000-0000-000000001008', 'PIN1008-500G', '500g', 34.800000, 75),
  ('b0000000-0000-0000-0000-000000009026', 'a0000000-0000-0000-0000-000000001008', 'PIN1008-1KG', '1kg', 58.000000, 76);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001009', 'Kiwi Gold', 'KIW1009', 'Fruits', 0, 100.00, '/images/products/kiwi_gold.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009027', 'a0000000-0000-0000-0000-000000001009', 'KIW1009-250G', '250g', 17.700000, 77),
  ('b0000000-0000-0000-0000-000000009028', 'a0000000-0000-0000-0000-000000001009', 'KIW1009-500G', '500g', 35.400000, 78),
  ('b0000000-0000-0000-0000-000000009029', 'a0000000-0000-0000-0000-000000001009', 'KIW1009-1KG', '1kg', 59.000000, 79);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001010', 'Guava (Pink)', 'GUA1010', 'Fruits', 0, 100.00, '/images/products/guava_pink.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009030', 'a0000000-0000-0000-0000-000000001010', 'GUA1010-250G', '250g', 18.000000, 80),
  ('b0000000-0000-0000-0000-000000009031', 'a0000000-0000-0000-0000-000000001010', 'GUA1010-500G', '500g', 36.000000, 81),
  ('b0000000-0000-0000-0000-000000009032', 'a0000000-0000-0000-0000-000000001010', 'GUA1010-1KG', '1kg', 60.000000, 82);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001011', 'Dragon Fruit', 'DRA1011', 'Fruits', 0, 100.00, '/images/products/dragon_fruit.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009033', 'a0000000-0000-0000-0000-000000001011', 'DRA1011-250G', '250g', 18.300000, 83),
  ('b0000000-0000-0000-0000-000000009034', 'a0000000-0000-0000-0000-000000001011', 'DRA1011-500G', '500g', 36.600000, 84),
  ('b0000000-0000-0000-0000-000000009035', 'a0000000-0000-0000-0000-000000001011', 'DRA1011-1KG', '1kg', 61.000000, 85);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001012', 'Strawberry Box', 'STR1012', 'Fruits', 0, 100.00, '/images/products/strawberry_box.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009036', 'a0000000-0000-0000-0000-000000001012', 'STR1012-250G', '250g', 18.600000, 86),
  ('b0000000-0000-0000-0000-000000009037', 'a0000000-0000-0000-0000-000000001012', 'STR1012-500G', '500g', 37.200000, 87),
  ('b0000000-0000-0000-0000-000000009038', 'a0000000-0000-0000-0000-000000001012', 'STR1012-1KG', '1kg', 62.000000, 88);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001013', 'Blueberry Pack', 'BLU1013', 'Fruits', 0, 100.00, '/images/products/blueberry_pack.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009039', 'a0000000-0000-0000-0000-000000001013', 'BLU1013-250G', '250g', 18.900000, 89),
  ('b0000000-0000-0000-0000-000000009040', 'a0000000-0000-0000-0000-000000001013', 'BLU1013-500G', '500g', 37.800000, 90),
  ('b0000000-0000-0000-0000-000000009041', 'a0000000-0000-0000-0000-000000001013', 'BLU1013-1KG', '1kg', 63.000000, 91);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001014', 'Sweet Lime', 'SWE1014', 'Fruits', 0, 100.00, '/images/products/sweet_lime.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009042', 'a0000000-0000-0000-0000-000000001014', 'SWE1014-250G', '250g', 19.200000, 92),
  ('b0000000-0000-0000-0000-000000009043', 'a0000000-0000-0000-0000-000000001014', 'SWE1014-500G', '500g', 38.400000, 93),
  ('b0000000-0000-0000-0000-000000009044', 'a0000000-0000-0000-0000-000000001014', 'SWE1014-1KG', '1kg', 64.000000, 94);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001015', 'Pear (Green)', 'PEA1015', 'Fruits', 0, 100.00, '/images/products/pear_green.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009045', 'a0000000-0000-0000-0000-000000001015', 'PEA1015-250G', '250g', 19.500000, 95),
  ('b0000000-0000-0000-0000-000000009046', 'a0000000-0000-0000-0000-000000001015', 'PEA1015-500G', '500g', 39.000000, 96),
  ('b0000000-0000-0000-0000-000000009047', 'a0000000-0000-0000-0000-000000001015', 'PEA1015-1KG', '1kg', 65.000000, 97);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001016', 'Plums (Fresh)', 'PLU1016', 'Fruits', 0, 100.00, '/images/products/plums_fresh.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009048', 'a0000000-0000-0000-0000-000000001016', 'PLU1016-250G', '250g', 19.800000, 98),
  ('b0000000-0000-0000-0000-000000009049', 'a0000000-0000-0000-0000-000000001016', 'PLU1016-500G', '500g', 39.600000, 99),
  ('b0000000-0000-0000-0000-000000009050', 'a0000000-0000-0000-0000-000000001016', 'PLU1016-1KG', '1kg', 66.000000, 100);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001017', 'Custard Apple', 'CUS1017', 'Fruits', 0, 100.00, '/images/products/custard_apple.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009051', 'a0000000-0000-0000-0000-000000001017', 'CUS1017-250G', '250g', 20.100000, 101),
  ('b0000000-0000-0000-0000-000000009052', 'a0000000-0000-0000-0000-000000001017', 'CUS1017-500G', '500g', 40.200000, 102),
  ('b0000000-0000-0000-0000-000000009053', 'a0000000-0000-0000-0000-000000001017', 'CUS1017-1KG', '1kg', 67.000000, 103);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001018', 'Avocado', 'AVO1018', 'Fruits', 0, 100.00, '/images/products/avocado.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009054', 'a0000000-0000-0000-0000-000000001018', 'AVO1018-250G', '250g', 20.400000, 104),
  ('b0000000-0000-0000-0000-000000009055', 'a0000000-0000-0000-0000-000000001018', 'AVO1018-500G', '500g', 40.800000, 105),
  ('b0000000-0000-0000-0000-000000009056', 'a0000000-0000-0000-0000-000000001018', 'AVO1018-1KG', '1kg', 68.000000, 106);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001019', 'Peach (Imported)', 'PEA1019', 'Fruits', 0, 100.00, 'https://images.unsplash.com/photo-1521236575383-1f3b7eb3cc7a?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009057', 'a0000000-0000-0000-0000-000000001019', 'PEA1019-250G', '250g', 20.700000, 107),
  ('b0000000-0000-0000-0000-000000009058', 'a0000000-0000-0000-0000-000000001019', 'PEA1019-500G', '500g', 41.400000, 108),
  ('b0000000-0000-0000-0000-000000009059', 'a0000000-0000-0000-0000-000000001019', 'PEA1019-1KG', '1kg', 69.000000, 109);

-- Category: Vegetables
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001020', 'Tomato (Hybrid)', 'TOM1020', 'Vegetables', 0, 100.00, '/images/products/tomato_hybrid.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009060', 'a0000000-0000-0000-0000-000000001020', 'TOM1020-250G', '250g', 21.000000, 110),
  ('b0000000-0000-0000-0000-000000009061', 'a0000000-0000-0000-0000-000000001020', 'TOM1020-500G', '500g', 42.000000, 111),
  ('b0000000-0000-0000-0000-000000009062', 'a0000000-0000-0000-0000-000000001020', 'TOM1020-1KG', '1kg', 70.000000, 112);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001021', 'Onion (Pink)', 'ONI1021', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1626074315485-a7455171765c?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009063', 'a0000000-0000-0000-0000-000000001021', 'ONI1021-250G', '250g', 21.300000, 113),
  ('b0000000-0000-0000-0000-000000009064', 'a0000000-0000-0000-0000-000000001021', 'ONI1021-500G', '500g', 42.600000, 114),
  ('b0000000-0000-0000-0000-000000009065', 'a0000000-0000-0000-0000-000000001021', 'ONI1021-1KG', '1kg', 71.000000, 115);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001022', 'Potato (Agra)', 'POT1022', 'Vegetables', 0, 100.00, '/images/products/potato_agra.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009066', 'a0000000-0000-0000-0000-000000001022', 'POT1022-250G', '250g', 21.600000, 116),
  ('b0000000-0000-0000-0000-000000009067', 'a0000000-0000-0000-0000-000000001022', 'POT1022-500G', '500g', 43.200000, 117),
  ('b0000000-0000-0000-0000-000000009068', 'a0000000-0000-0000-0000-000000001022', 'POT1022-1KG', '1kg', 72.000000, 118);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001023', 'Cauliflower', 'CAU1023', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1568584711075-3d021a7c3ec3?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009069', 'a0000000-0000-0000-0000-000000001023', 'CAU1023-250G', '250g', 21.900000, 119),
  ('b0000000-0000-0000-0000-000000009070', 'a0000000-0000-0000-0000-000000001023', 'CAU1023-500G', '500g', 43.800000, 120),
  ('b0000000-0000-0000-0000-000000009071', 'a0000000-0000-0000-0000-000000001023', 'CAU1023-1KG', '1kg', 73.000000, 121);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001024', 'Broccoli', 'BRO1024', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009072', 'a0000000-0000-0000-0000-000000001024', 'BRO1024-250G', '250g', 22.200000, 122),
  ('b0000000-0000-0000-0000-000000009073', 'a0000000-0000-0000-0000-000000001024', 'BRO1024-500G', '500g', 44.400000, 123),
  ('b0000000-0000-0000-0000-000000009074', 'a0000000-0000-0000-0000-000000001024', 'BRO1024-1KG', '1kg', 74.000000, 124);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001025', 'Capsicum (Green)', 'CAP1025', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1563599175592-c58dc214deff?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009075', 'a0000000-0000-0000-0000-000000001025', 'CAP1025-250G', '250g', 22.500000, 125),
  ('b0000000-0000-0000-0000-000000009076', 'a0000000-0000-0000-0000-000000001025', 'CAP1025-500G', '500g', 45.000000, 126),
  ('b0000000-0000-0000-0000-000000009077', 'a0000000-0000-0000-0000-000000001025', 'CAP1025-1KG', '1kg', 75.000000, 127);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001026', 'Carrot (Orange)', 'CAR1026', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1590868309235-ea34bed7bd7f?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009078', 'a0000000-0000-0000-0000-000000001026', 'CAR1026-250G', '250g', 22.800000, 128),
  ('b0000000-0000-0000-0000-000000009079', 'a0000000-0000-0000-0000-000000001026', 'CAR1026-500G', '500g', 45.600000, 129),
  ('b0000000-0000-0000-0000-000000009080', 'a0000000-0000-0000-0000-000000001026', 'CAR1026-1KG', '1kg', 76.000000, 130);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001027', 'Ginger (Fresh)', 'GIN1027', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1599940824399-b87987ceb72a?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009081', 'a0000000-0000-0000-0000-000000001027', 'GIN1027-250G', '250g', 23.100000, 131),
  ('b0000000-0000-0000-0000-000000009082', 'a0000000-0000-0000-0000-000000001027', 'GIN1027-500G', '500g', 46.200000, 132),
  ('b0000000-0000-0000-0000-000000009083', 'a0000000-0000-0000-0000-000000001027', 'GIN1027-1KG', '1kg', 77.000000, 133);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001028', 'Garlic (Whole)', 'GAR1028', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1540148426945-6cf22a6b2383?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009084', 'a0000000-0000-0000-0000-000000001028', 'GAR1028-250G', '250g', 23.400000, 134),
  ('b0000000-0000-0000-0000-000000009085', 'a0000000-0000-0000-0000-000000001028', 'GAR1028-500G', '500g', 46.800000, 135),
  ('b0000000-0000-0000-0000-000000009086', 'a0000000-0000-0000-0000-000000001028', 'GAR1028-1KG', '1kg', 78.000000, 136);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001029', 'Lemon (Paak)', 'LEM1029', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1585059895318-72624bb73531?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009087', 'a0000000-0000-0000-0000-000000001029', 'LEM1029-250G', '250g', 23.700000, 137),
  ('b0000000-0000-0000-0000-000000009088', 'a0000000-0000-0000-0000-000000001029', 'LEM1029-500G', '500g', 47.400000, 138),
  ('b0000000-0000-0000-0000-000000009089', 'a0000000-0000-0000-0000-000000001029', 'LEM1029-1KG', '1kg', 79.000000, 139);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001030', 'Cabbage', 'CAB1030', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1550159930-401217e21f5c?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009090', 'a0000000-0000-0000-0000-000000001030', 'CAB1030-250G', '250g', 24.000000, 140),
  ('b0000000-0000-0000-0000-000000009091', 'a0000000-0000-0000-0000-000000001030', 'CAB1030-500G', '500g', 48.000000, 141),
  ('b0000000-0000-0000-0000-000000009092', 'a0000000-0000-0000-0000-000000001030', 'CAB1030-1KG', '1kg', 80.000000, 142);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001031', 'Spinach (Palak)', 'SPI1031', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009093', 'a0000000-0000-0000-0000-000000001031', 'SPI1031-250G', '250g', 24.300000, 143),
  ('b0000000-0000-0000-0000-000000009094', 'a0000000-0000-0000-0000-000000001031', 'SPI1031-500G', '500g', 48.600000, 144),
  ('b0000000-0000-0000-0000-000000009095', 'a0000000-0000-0000-0000-000000001031', 'SPI1031-1KG', '1kg', 81.000000, 145);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001032', 'Green Masala Mix', 'GRE1032', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009096', 'a0000000-0000-0000-0000-000000001032', 'GRE1032-250G', '250g', 24.600000, 146),
  ('b0000000-0000-0000-0000-000000009097', 'a0000000-0000-0000-0000-000000001032', 'GRE1032-500G', '500g', 49.200000, 147),
  ('b0000000-0000-0000-0000-000000009098', 'a0000000-0000-0000-0000-000000001032', 'GRE1032-1KG', '1kg', 82.000000, 148);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001033', 'Cucumber', 'CUC1033', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1596560548464-f63935398cf2?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009099', 'a0000000-0000-0000-0000-000000001033', 'CUC1033-250G', '250g', 24.900000, 149),
  ('b0000000-0000-0000-0000-000000009100', 'a0000000-0000-0000-0000-000000001033', 'CUC1033-500G', '500g', 49.800000, 150),
  ('b0000000-0000-0000-0000-000000009101', 'a0000000-0000-0000-0000-000000001033', 'CUC1033-1KG', '1kg', 83.000000, 151);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001034', 'Ladies Finger', 'LAD1034', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1449339040480-2c27c70c4bd7?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009102', 'a0000000-0000-0000-0000-000000001034', 'LAD1034-250G', '250g', 25.200000, 152),
  ('b0000000-0000-0000-0000-000000009103', 'a0000000-0000-0000-0000-000000001034', 'LAD1034-500G', '500g', 50.400000, 153),
  ('b0000000-0000-0000-0000-000000009104', 'a0000000-0000-0000-0000-000000001034', 'LAD1034-1KG', '1kg', 84.000000, 154);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001035', 'Brinjal (Large)', 'BRI1035', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1615485925600-97237c4fc1ec?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009105', 'a0000000-0000-0000-0000-000000001035', 'BRI1035-250G', '250g', 25.500000, 155),
  ('b0000000-0000-0000-0000-000000009106', 'a0000000-0000-0000-0000-000000001035', 'BRI1035-500G', '500g', 51.000000, 156),
  ('b0000000-0000-0000-0000-000000009107', 'a0000000-0000-0000-0000-000000001035', 'BRI1035-1KG', '1kg', 85.000000, 157);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001036', 'Bitter Gourd', 'BIT1036', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1615485925600-97237c4fc1ec?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009108', 'a0000000-0000-0000-0000-000000001036', 'BIT1036-250G', '250g', 25.800000, 158),
  ('b0000000-0000-0000-0000-000000009109', 'a0000000-0000-0000-0000-000000001036', 'BIT1036-500G', '500g', 51.600000, 159),
  ('b0000000-0000-0000-0000-000000009110', 'a0000000-0000-0000-0000-000000001036', 'BIT1036-1KG', '1kg', 86.000000, 160);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001037', 'Mushrooms (Button)', 'MUS1037', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009111', 'a0000000-0000-0000-0000-000000001037', 'MUS1037-250G', '250g', 26.100000, 161),
  ('b0000000-0000-0000-0000-000000009112', 'a0000000-0000-0000-0000-000000001037', 'MUS1037-500G', '500g', 52.200000, 162),
  ('b0000000-0000-0000-0000-000000009113', 'a0000000-0000-0000-0000-000000001037', 'MUS1037-1KG', '1kg', 87.000000, 163);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001038', 'Sweet Corn', 'SWE1038', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1551754655-cd27e38d2076?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009114', 'a0000000-0000-0000-0000-000000001038', 'SWE1038-250G', '250g', 26.400000, 164),
  ('b0000000-0000-0000-0000-000000009115', 'a0000000-0000-0000-0000-000000001038', 'SWE1038-500G', '500g', 52.800000, 165),
  ('b0000000-0000-0000-0000-000000009116', 'a0000000-0000-0000-0000-000000001038', 'SWE1038-1KG', '1kg', 88.000000, 166);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001039', 'Pumpkin', 'PUM1039', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1506869683304-fab9bcdec60c?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009117', 'a0000000-0000-0000-0000-000000001039', 'PUM1039-250G', '250g', 26.700000, 167),
  ('b0000000-0000-0000-0000-000000009118', 'a0000000-0000-0000-0000-000000001039', 'PUM1039-500G', '500g', 53.400000, 168),
  ('b0000000-0000-0000-0000-000000009119', 'a0000000-0000-0000-0000-000000001039', 'PUM1039-1KG', '1kg', 89.000000, 169);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001040', 'Bottle Gourd', 'BOT1040', 'Vegetables', 0, 100.00, 'https://images.unsplash.com/photo-1551754655-cd27e38d2076?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009120', 'a0000000-0000-0000-0000-000000001040', 'BOT1040-250G', '250g', 27.000000, 170),
  ('b0000000-0000-0000-0000-000000009121', 'a0000000-0000-0000-0000-000000001040', 'BOT1040-500G', '500g', 54.000000, 171),
  ('b0000000-0000-0000-0000-000000009122', 'a0000000-0000-0000-0000-000000001040', 'BOT1040-1KG', '1kg', 90.000000, 172);

-- Category: Dairy & Bakery
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001041', 'Full Cream Milk', 'FUL1041', 'Dairy & Bakery', 0, 100.00, '/images/products/full_cream_milk.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009123', 'a0000000-0000-0000-0000-000000001041', 'FUL1041-500ML', '500ml', 45.500000, 173),
  ('b0000000-0000-0000-0000-000000009124', 'a0000000-0000-0000-0000-000000001041', 'FUL1041-1L', '1L', 91.000000, 174),
  ('b0000000-0000-0000-0000-000000009125', 'a0000000-0000-0000-0000-000000001041', 'FUL1041-2L', '2L', 163.800000, 175);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001042', 'Toned Milk', 'TON1042', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009126', 'a0000000-0000-0000-0000-000000001042', 'TON1042-500ML', '500ml', 46.000000, 176),
  ('b0000000-0000-0000-0000-000000009127', 'a0000000-0000-0000-0000-000000001042', 'TON1042-1L', '1L', 92.000000, 177),
  ('b0000000-0000-0000-0000-000000009128', 'a0000000-0000-0000-0000-000000001042', 'TON1042-2L', '2L', 165.600000, 178);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001043', 'Fresh Curd', 'FRE1043', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009129', 'a0000000-0000-0000-0000-000000001043', 'FRE1043-500ML', '500ml', 46.500000, 179),
  ('b0000000-0000-0000-0000-000000009130', 'a0000000-0000-0000-0000-000000001043', 'FRE1043-1L', '1L', 93.000000, 180),
  ('b0000000-0000-0000-0000-000000009131', 'a0000000-0000-0000-0000-000000001043', 'FRE1043-2L', '2L', 167.400000, 181);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001044', 'Paneer (Pure)', 'PAN1044', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1658428172935-502a2817730e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009132', 'a0000000-0000-0000-0000-000000001044', 'PAN1044-500ML', '500ml', 47.000000, 182),
  ('b0000000-0000-0000-0000-000000009133', 'a0000000-0000-0000-0000-000000001044', 'PAN1044-1L', '1L', 94.000000, 183),
  ('b0000000-0000-0000-0000-000000009134', 'a0000000-0000-0000-0000-000000001044', 'PAN1044-2L', '2L', 169.200000, 184);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001045', 'Greek Yogurt', 'GRE1045', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009135', 'a0000000-0000-0000-0000-000000001045', 'GRE1045-500ML', '500ml', 47.500000, 185),
  ('b0000000-0000-0000-0000-000000009136', 'a0000000-0000-0000-0000-000000001045', 'GRE1045-1L', '1L', 95.000000, 186),
  ('b0000000-0000-0000-0000-000000009137', 'a0000000-0000-0000-0000-000000001045', 'GRE1045-2L', '2L', 171.000000, 187);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001046', 'Salted Butter', 'SAL1046', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1589245781442-fb6b1ad45199?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009138', 'a0000000-0000-0000-0000-000000001046', 'SAL1046-500ML', '500ml', 48.000000, 188),
  ('b0000000-0000-0000-0000-000000009139', 'a0000000-0000-0000-0000-000000001046', 'SAL1046-1L', '1L', 96.000000, 189),
  ('b0000000-0000-0000-0000-000000009140', 'a0000000-0000-0000-0000-000000001046', 'SAL1046-2L', '2L', 172.800000, 190);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001047', 'Amul Cheese Slices', 'AMU1047', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1528750955925-97f6c3960fbe?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009141', 'a0000000-0000-0000-0000-000000001047', 'AMU1047-500ML', '500ml', 48.500000, 191),
  ('b0000000-0000-0000-0000-000000009142', 'a0000000-0000-0000-0000-000000001047', 'AMU1047-1L', '1L', 97.000000, 192),
  ('b0000000-0000-0000-0000-000000009143', 'a0000000-0000-0000-0000-000000001047', 'AMU1047-2L', '2L', 174.600000, 193);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001048', 'Whipping Cream', 'WHI1048', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1553909489-601445722421?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009144', 'a0000000-0000-0000-0000-000000001048', 'WHI1048-500ML', '500ml', 49.000000, 194),
  ('b0000000-0000-0000-0000-000000009145', 'a0000000-0000-0000-0000-000000001048', 'WHI1048-1L', '1L', 98.000000, 195),
  ('b0000000-0000-0000-0000-000000009146', 'a0000000-0000-0000-0000-000000001048', 'WHI1048-2L', '2L', 176.400000, 196);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001049', 'Milk Bread', 'MIL1049', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009147', 'a0000000-0000-0000-0000-000000001049', 'MIL1049-500ML', '500ml', 49.500000, 197),
  ('b0000000-0000-0000-0000-000000009148', 'a0000000-0000-0000-0000-000000001049', 'MIL1049-1L', '1L', 99.000000, 198),
  ('b0000000-0000-0000-0000-000000009149', 'a0000000-0000-0000-0000-000000001049', 'MIL1049-2L', '2L', 178.200000, 199);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001050', 'Brown Bread', 'BRO1050', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009150', 'a0000000-0000-0000-0000-000000001050', 'BRO1050-500ML', '500ml', 50.000000, 50),
  ('b0000000-0000-0000-0000-000000009151', 'a0000000-0000-0000-0000-000000001050', 'BRO1050-1L', '1L', 100.000000, 51),
  ('b0000000-0000-0000-0000-000000009152', 'a0000000-0000-0000-0000-000000001050', 'BRO1050-2L', '2L', 180.000000, 52);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001051', 'Fruit Bun', 'FRU1051', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009153', 'a0000000-0000-0000-0000-000000001051', 'FRU1051-500ML', '500ml', 50.500000, 53),
  ('b0000000-0000-0000-0000-000000009154', 'a0000000-0000-0000-0000-000000001051', 'FRU1051-1L', '1L', 101.000000, 54),
  ('b0000000-0000-0000-0000-000000009155', 'a0000000-0000-0000-0000-000000001051', 'FRU1051-2L', '2L', 181.800000, 55);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001052', 'Eggless Cake', 'EGG1052', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009156', 'a0000000-0000-0000-0000-000000001052', 'EGG1052-500ML', '500ml', 51.000000, 56),
  ('b0000000-0000-0000-0000-000000009157', 'a0000000-0000-0000-0000-000000001052', 'EGG1052-1L', '1L', 102.000000, 57),
  ('b0000000-0000-0000-0000-000000009158', 'a0000000-0000-0000-0000-000000001052', 'EGG1052-2L', '2L', 183.600000, 58);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001053', 'Chocolate Croissant', 'CHO1053', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009159', 'a0000000-0000-0000-0000-000000001053', 'CHO1053-500ML', '500ml', 51.500000, 59),
  ('b0000000-0000-0000-0000-000000009160', 'a0000000-0000-0000-0000-000000001053', 'CHO1053-1L', '1L', 103.000000, 60),
  ('b0000000-0000-0000-0000-000000009161', 'a0000000-0000-0000-0000-000000001053', 'CHO1053-2L', '2L', 185.400000, 61);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001054', 'Multigrain Cookies', 'MUL1054', 'Dairy & Bakery', 0, 100.00, '/images/products/chocolate_cookies.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009162', 'a0000000-0000-0000-0000-000000001054', 'MUL1054-500ML', '500ml', 52.000000, 62),
  ('b0000000-0000-0000-0000-000000009163', 'a0000000-0000-0000-0000-000000001054', 'MUL1054-1L', '1L', 104.000000, 63),
  ('b0000000-0000-0000-0000-000000009164', 'a0000000-0000-0000-0000-000000001054', 'MUL1054-2L', '2L', 187.200000, 64);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001055', 'Cheese Spread', 'CHE1055', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009165', 'a0000000-0000-0000-0000-000000001055', 'CHE1055-500ML', '500ml', 52.500000, 65),
  ('b0000000-0000-0000-0000-000000009166', 'a0000000-0000-0000-0000-000000001055', 'CHE1055-1L', '1L', 105.000000, 66),
  ('b0000000-0000-0000-0000-000000009167', 'a0000000-0000-0000-0000-000000001055', 'CHE1055-2L', '2L', 189.000000, 67);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001056', 'Condensed Milk', 'CON1056', 'Dairy & Bakery', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009168', 'a0000000-0000-0000-0000-000000001056', 'CON1056-500ML', '500ml', 53.000000, 68),
  ('b0000000-0000-0000-0000-000000009169', 'a0000000-0000-0000-0000-000000001056', 'CON1056-1L', '1L', 106.000000, 69),
  ('b0000000-0000-0000-0000-000000009170', 'a0000000-0000-0000-0000-000000001056', 'CON1056-2L', '2L', 190.800000, 70);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001057', 'Fresh Eggs (6pc)', 'FRE1057', 'Dairy & Bakery', 0, 100.00, '/images/products/fresh_eggs.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009171', 'a0000000-0000-0000-0000-000000001057', 'FRE1057-500ML', '500ml', 53.500000, 71),
  ('b0000000-0000-0000-0000-000000009172', 'a0000000-0000-0000-0000-000000001057', 'FRE1057-1L', '1L', 107.000000, 72),
  ('b0000000-0000-0000-0000-000000009173', 'a0000000-0000-0000-0000-000000001057', 'FRE1057-2L', '2L', 192.600000, 73);

-- Category: Staples & Grains
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001058', 'Basmati Rice (Long)', 'BAS1058', 'Staples & Grains', 0, 100.00, '/images/products/basmati_rice.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009174', 'a0000000-0000-0000-0000-000000001058', 'BAS1058-1KG', '1kg', 108.000000, 74),
  ('b0000000-0000-0000-0000-000000009175', 'a0000000-0000-0000-0000-000000001058', 'BAS1058-5KG', '5kg', 486.000000, 75),
  ('b0000000-0000-0000-0000-000000009176', 'a0000000-0000-0000-0000-000000001058', 'BAS1058-10KG', '10kg', 918.000000, 76);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001059', 'Sona Masuri Rice', 'SON1059', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009177', 'a0000000-0000-0000-0000-000000001059', 'SON1059-1KG', '1kg', 109.000000, 77),
  ('b0000000-0000-0000-0000-000000009178', 'a0000000-0000-0000-0000-000000001059', 'SON1059-5KG', '5kg', 490.500000, 78),
  ('b0000000-0000-0000-0000-000000009179', 'a0000000-0000-0000-0000-000000001059', 'SON1059-10KG', '10kg', 926.500000, 79);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001060', 'Wheat Atta (Chakki)', 'WHE1060', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009180', 'a0000000-0000-0000-0000-000000001060', 'WHE1060-1KG', '1kg', 110.000000, 80),
  ('b0000000-0000-0000-0000-000000009181', 'a0000000-0000-0000-0000-000000001060', 'WHE1060-5KG', '5kg', 495.000000, 81),
  ('b0000000-0000-0000-0000-000000009182', 'a0000000-0000-0000-0000-000000001060', 'WHE1060-10KG', '10kg', 935.000000, 82);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001061', 'Maida', 'MAI1061', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009183', 'a0000000-0000-0000-0000-000000001061', 'MAI1061-1KG', '1kg', 111.000000, 83),
  ('b0000000-0000-0000-0000-000000009184', 'a0000000-0000-0000-0000-000000001061', 'MAI1061-5KG', '5kg', 499.500000, 84),
  ('b0000000-0000-0000-0000-000000009185', 'a0000000-0000-0000-0000-000000001061', 'MAI1061-10KG', '10kg', 943.500000, 85);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001062', 'Besan', 'BES1062', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009186', 'a0000000-0000-0000-0000-000000001062', 'BES1062-1KG', '1kg', 112.000000, 86),
  ('b0000000-0000-0000-0000-000000009187', 'a0000000-0000-0000-0000-000000001062', 'BES1062-5KG', '5kg', 504.000000, 87),
  ('b0000000-0000-0000-0000-000000009188', 'a0000000-0000-0000-0000-000000001062', 'BES1062-10KG', '10kg', 952.000000, 88);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001063', 'Moong Dal', 'MOO1063', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009189', 'a0000000-0000-0000-0000-000000001063', 'MOO1063-1KG', '1kg', 113.000000, 89),
  ('b0000000-0000-0000-0000-000000009190', 'a0000000-0000-0000-0000-000000001063', 'MOO1063-5KG', '5kg', 508.500000, 90),
  ('b0000000-0000-0000-0000-000000009191', 'a0000000-0000-0000-0000-000000001063', 'MOO1063-10KG', '10kg', 960.500000, 91);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001064', 'Toor Dal', 'TOO1064', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009192', 'a0000000-0000-0000-0000-000000001064', 'TOO1064-1KG', '1kg', 114.000000, 92),
  ('b0000000-0000-0000-0000-000000009193', 'a0000000-0000-0000-0000-000000001064', 'TOO1064-5KG', '5kg', 513.000000, 93),
  ('b0000000-0000-0000-0000-000000009194', 'a0000000-0000-0000-0000-000000001064', 'TOO1064-10KG', '10kg', 969.000000, 94);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001065', 'Chana Dal', 'CHA1065', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009195', 'a0000000-0000-0000-0000-000000001065', 'CHA1065-1KG', '1kg', 115.000000, 95),
  ('b0000000-0000-0000-0000-000000009196', 'a0000000-0000-0000-0000-000000001065', 'CHA1065-5KG', '5kg', 517.500000, 96),
  ('b0000000-0000-0000-0000-000000009197', 'a0000000-0000-0000-0000-000000001065', 'CHA1065-10KG', '10kg', 977.500000, 97);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001066', 'Urad Dal', 'URA1066', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009198', 'a0000000-0000-0000-0000-000000001066', 'URA1066-1KG', '1kg', 116.000000, 98),
  ('b0000000-0000-0000-0000-000000009199', 'a0000000-0000-0000-0000-000000001066', 'URA1066-5KG', '5kg', 522.000000, 99),
  ('b0000000-0000-0000-0000-000000009200', 'a0000000-0000-0000-0000-000000001066', 'URA1066-10KG', '10kg', 986.000000, 100);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001067', 'Red Rajma', 'RED1067', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009201', 'a0000000-0000-0000-0000-000000001067', 'RED1067-1KG', '1kg', 117.000000, 101),
  ('b0000000-0000-0000-0000-000000009202', 'a0000000-0000-0000-0000-000000001067', 'RED1067-5KG', '5kg', 526.500000, 102),
  ('b0000000-0000-0000-0000-000000009203', 'a0000000-0000-0000-0000-000000001067', 'RED1067-10KG', '10kg', 994.500000, 103);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001068', 'Kabuli Chana', 'KAB1068', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009204', 'a0000000-0000-0000-0000-000000001068', 'KAB1068-1KG', '1kg', 118.000000, 104),
  ('b0000000-0000-0000-0000-000000009205', 'a0000000-0000-0000-0000-000000001068', 'KAB1068-5KG', '5kg', 531.000000, 105),
  ('b0000000-0000-0000-0000-000000009206', 'a0000000-0000-0000-0000-000000001068', 'KAB1068-10KG', '10kg', 1003.000000, 106);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001069', 'Sugar (White)', 'SUG1069', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1581447100512-3df2ecdf99cc?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009207', 'a0000000-0000-0000-0000-000000001069', 'SUG1069-1KG', '1kg', 119.000000, 107),
  ('b0000000-0000-0000-0000-000000009208', 'a0000000-0000-0000-0000-000000001069', 'SUG1069-5KG', '5kg', 535.500000, 108),
  ('b0000000-0000-0000-0000-000000009209', 'a0000000-0000-0000-0000-000000001069', 'SUG1069-10KG', '10kg', 1011.500000, 109);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001070', 'Jaggery Powder', 'JAG1070', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009210', 'a0000000-0000-0000-0000-000000001070', 'JAG1070-1KG', '1kg', 120.000000, 110),
  ('b0000000-0000-0000-0000-000000009211', 'a0000000-0000-0000-0000-000000001070', 'JAG1070-5KG', '5kg', 540.000000, 111),
  ('b0000000-0000-0000-0000-000000009212', 'a0000000-0000-0000-0000-000000001070', 'JAG1070-10KG', '10kg', 1020.000000, 112);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001071', 'Refined Oil', 'REF1071', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009213', 'a0000000-0000-0000-0000-000000001071', 'REF1071-1KG', '1kg', 121.000000, 113),
  ('b0000000-0000-0000-0000-000000009214', 'a0000000-0000-0000-0000-000000001071', 'REF1071-5KG', '5kg', 544.500000, 114),
  ('b0000000-0000-0000-0000-000000009215', 'a0000000-0000-0000-0000-000000001071', 'REF1071-10KG', '10kg', 1028.500000, 115);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001072', 'Mustard Oil', 'MUS1072', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009216', 'a0000000-0000-0000-0000-000000001072', 'MUS1072-1KG', '1kg', 122.000000, 116),
  ('b0000000-0000-0000-0000-000000009217', 'a0000000-0000-0000-0000-000000001072', 'MUS1072-5KG', '5kg', 549.000000, 117),
  ('b0000000-0000-0000-0000-000000009218', 'a0000000-0000-0000-0000-000000001072', 'MUS1072-10KG', '10kg', 1037.000000, 118);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001073', 'Desi Ghee', 'DES1073', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009219', 'a0000000-0000-0000-0000-000000001073', 'DES1073-1KG', '1kg', 123.000000, 119),
  ('b0000000-0000-0000-0000-000000009220', 'a0000000-0000-0000-0000-000000001073', 'DES1073-5KG', '5kg', 553.500000, 120),
  ('b0000000-0000-0000-0000-000000009221', 'a0000000-0000-0000-0000-000000001073', 'DES1073-10KG', '10kg', 1045.500000, 121);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001074', 'Salt (Iodized)', 'SAL1074', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1518113175771-0a5669aef0c1?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009222', 'a0000000-0000-0000-0000-000000001074', 'SAL1074-1KG', '1kg', 124.000000, 122),
  ('b0000000-0000-0000-0000-000000009223', 'a0000000-0000-0000-0000-000000001074', 'SAL1074-5KG', '5kg', 558.000000, 123),
  ('b0000000-0000-0000-0000-000000009224', 'a0000000-0000-0000-0000-000000001074', 'SAL1074-10KG', '10kg', 1054.000000, 124);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001075', 'Turmeric Powder', 'TUR1075', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009225', 'a0000000-0000-0000-0000-000000001075', 'TUR1075-1KG', '1kg', 125.000000, 125),
  ('b0000000-0000-0000-0000-000000009226', 'a0000000-0000-0000-0000-000000001075', 'TUR1075-5KG', '5kg', 562.500000, 126),
  ('b0000000-0000-0000-0000-000000009227', 'a0000000-0000-0000-0000-000000001075', 'TUR1075-10KG', '10kg', 1062.500000, 127);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001076', 'Coriander Powder', 'COR1076', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009228', 'a0000000-0000-0000-0000-000000001076', 'COR1076-1KG', '1kg', 126.000000, 128),
  ('b0000000-0000-0000-0000-000000009229', 'a0000000-0000-0000-0000-000000001076', 'COR1076-5KG', '5kg', 567.000000, 129),
  ('b0000000-0000-0000-0000-000000009230', 'a0000000-0000-0000-0000-000000001076', 'COR1076-10KG', '10kg', 1071.000000, 130);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001077', 'Red Chilli Powder', 'RED1077', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009231', 'a0000000-0000-0000-0000-000000001077', 'RED1077-1KG', '1kg', 127.000000, 131),
  ('b0000000-0000-0000-0000-000000009232', 'a0000000-0000-0000-0000-000000001077', 'RED1077-5KG', '5kg', 571.500000, 132),
  ('b0000000-0000-0000-0000-000000009233', 'a0000000-0000-0000-0000-000000001077', 'RED1077-10KG', '10kg', 1079.500000, 133);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001078', 'Black Pepper', 'BLA1078', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009234', 'a0000000-0000-0000-0000-000000001078', 'BLA1078-1KG', '1kg', 128.000000, 134),
  ('b0000000-0000-0000-0000-000000009235', 'a0000000-0000-0000-0000-000000001078', 'BLA1078-5KG', '5kg', 576.000000, 135),
  ('b0000000-0000-0000-0000-000000009236', 'a0000000-0000-0000-0000-000000001078', 'BLA1078-10KG', '10kg', 1088.000000, 136);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001079', 'Tea Dust', 'TEA1079', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009237', 'a0000000-0000-0000-0000-000000001079', 'TEA1079-1KG', '1kg', 129.000000, 137),
  ('b0000000-0000-0000-0000-000000009238', 'a0000000-0000-0000-0000-000000001079', 'TEA1079-5KG', '5kg', 580.500000, 138),
  ('b0000000-0000-0000-0000-000000009239', 'a0000000-0000-0000-0000-000000001079', 'TEA1079-10KG', '10kg', 1096.500000, 139);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001080', 'Instant Coffee', 'INS1080', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009240', 'a0000000-0000-0000-0000-000000001080', 'INS1080-1KG', '1kg', 130.000000, 140),
  ('b0000000-0000-0000-0000-000000009241', 'a0000000-0000-0000-0000-000000001080', 'INS1080-5KG', '5kg', 585.000000, 141),
  ('b0000000-0000-0000-0000-000000009242', 'a0000000-0000-0000-0000-000000001080', 'INS1080-10KG', '10kg', 1105.000000, 142);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001081', 'Poha (Flattened)', 'POH1081', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009243', 'a0000000-0000-0000-0000-000000001081', 'POH1081-1KG', '1kg', 131.000000, 143),
  ('b0000000-0000-0000-0000-000000009244', 'a0000000-0000-0000-0000-000000001081', 'POH1081-5KG', '5kg', 589.500000, 144),
  ('b0000000-0000-0000-0000-000000009245', 'a0000000-0000-0000-0000-000000001081', 'POH1081-10KG', '10kg', 1113.500000, 145);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001082', 'Honey (Organic)', 'HON1082', 'Staples & Grains', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009246', 'a0000000-0000-0000-0000-000000001082', 'HON1082-1KG', '1kg', 132.000000, 146),
  ('b0000000-0000-0000-0000-000000009247', 'a0000000-0000-0000-0000-000000001082', 'HON1082-5KG', '5kg', 594.000000, 147),
  ('b0000000-0000-0000-0000-000000009248', 'a0000000-0000-0000-0000-000000001082', 'HON1082-10KG', '10kg', 1122.000000, 148);

-- Category: Snacks & Munchies
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001083', 'Potato Chips', 'POT1083', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1566478433292-06bd7076d3f2?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009249', 'a0000000-0000-0000-0000-000000001083', 'POT1083-SMALL', 'Small', 66.500000, 149),
  ('b0000000-0000-0000-0000-000000009250', 'a0000000-0000-0000-0000-000000001083', 'POT1083-STANDARD', 'Standard', 133.000000, 150),
  ('b0000000-0000-0000-0000-000000009251', 'a0000000-0000-0000-0000-000000001083', 'POT1083-FAMILYPACK', 'Family Pack', 266.000000, 151);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001084', 'Nachos (Cheese)', 'NAC1084', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009252', 'a0000000-0000-0000-0000-000000001084', 'NAC1084-SMALL', 'Small', 67.000000, 152),
  ('b0000000-0000-0000-0000-000000009253', 'a0000000-0000-0000-0000-000000001084', 'NAC1084-STANDARD', 'Standard', 134.000000, 153),
  ('b0000000-0000-0000-0000-000000009254', 'a0000000-0000-0000-0000-000000001084', 'NAC1084-FAMILYPACK', 'Family Pack', 268.000000, 154);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001085', 'Roasted Almonds', 'ROA1085', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1534431713028-1f6b539cb9a4?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009255', 'a0000000-0000-0000-0000-000000001085', 'ROA1085-SMALL', 'Small', 67.500000, 155),
  ('b0000000-0000-0000-0000-000000009256', 'a0000000-0000-0000-0000-000000001085', 'ROA1085-STANDARD', 'Standard', 135.000000, 156),
  ('b0000000-0000-0000-0000-000000009257', 'a0000000-0000-0000-0000-000000001085', 'ROA1085-FAMILYPACK', 'Family Pack', 270.000000, 157);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001086', 'Cashews (W320)', 'CAS1086', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1534431713028-1f6b539cb9a4?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009258', 'a0000000-0000-0000-0000-000000001086', 'CAS1086-SMALL', 'Small', 68.000000, 158),
  ('b0000000-0000-0000-0000-000000009259', 'a0000000-0000-0000-0000-000000001086', 'CAS1086-STANDARD', 'Standard', 136.000000, 159),
  ('b0000000-0000-0000-0000-000000009260', 'a0000000-0000-0000-0000-000000001086', 'CAS1086-FAMILYPACK', 'Family Pack', 272.000000, 160);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001087', 'Walnut Kernels', 'WAL1087', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009261', 'a0000000-0000-0000-0000-000000001087', 'WAL1087-SMALL', 'Small', 68.500000, 161),
  ('b0000000-0000-0000-0000-000000009262', 'a0000000-0000-0000-0000-000000001087', 'WAL1087-STANDARD', 'Standard', 137.000000, 162),
  ('b0000000-0000-0000-0000-000000009263', 'a0000000-0000-0000-0000-000000001087', 'WAL1087-FAMILYPACK', 'Family Pack', 274.000000, 163);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001088', 'Dates (Kimia)', 'DAT1088', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009264', 'a0000000-0000-0000-0000-000000001088', 'DAT1088-SMALL', 'Small', 69.000000, 164),
  ('b0000000-0000-0000-0000-000000009265', 'a0000000-0000-0000-0000-000000001088', 'DAT1088-STANDARD', 'Standard', 138.000000, 165),
  ('b0000000-0000-0000-0000-000000009266', 'a0000000-0000-0000-0000-000000001088', 'DAT1088-FAMILYPACK', 'Family Pack', 276.000000, 166);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001089', 'Peanut Butter', 'PEA1089', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1541544336715-dd447b4bc063?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009267', 'a0000000-0000-0000-0000-000000001089', 'PEA1089-SMALL', 'Small', 69.500000, 167),
  ('b0000000-0000-0000-0000-000000009268', 'a0000000-0000-0000-0000-000000001089', 'PEA1089-STANDARD', 'Standard', 139.000000, 168),
  ('b0000000-0000-0000-0000-000000009269', 'a0000000-0000-0000-0000-000000001089', 'PEA1089-FAMILYPACK', 'Family Pack', 278.000000, 169);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001090', 'Fruit Jam', 'FRU1090', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1535498730771-e735b998cd64?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009270', 'a0000000-0000-0000-0000-000000001090', 'FRU1090-SMALL', 'Small', 70.000000, 170),
  ('b0000000-0000-0000-0000-000000009271', 'a0000000-0000-0000-0000-000000001090', 'FRU1090-STANDARD', 'Standard', 140.000000, 171),
  ('b0000000-0000-0000-0000-000000009272', 'a0000000-0000-0000-0000-000000001090', 'FRU1090-FAMILYPACK', 'Family Pack', 280.000000, 172);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001091', 'Maggi Masala', 'MAG1091', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009273', 'a0000000-0000-0000-0000-000000001091', 'MAG1091-SMALL', 'Small', 70.500000, 173),
  ('b0000000-0000-0000-0000-000000009274', 'a0000000-0000-0000-0000-000000001091', 'MAG1091-STANDARD', 'Standard', 141.000000, 174),
  ('b0000000-0000-0000-0000-000000009275', 'a0000000-0000-0000-0000-000000001091', 'MAG1091-FAMILYPACK', 'Family Pack', 282.000000, 175);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001092', 'Pasta (Penne)', 'PAS1092', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009276', 'a0000000-0000-0000-0000-000000001092', 'PAS1092-SMALL', 'Small', 71.000000, 176),
  ('b0000000-0000-0000-0000-000000009277', 'a0000000-0000-0000-0000-000000001092', 'PAS1092-STANDARD', 'Standard', 142.000000, 177),
  ('b0000000-0000-0000-0000-000000009278', 'a0000000-0000-0000-0000-000000001092', 'PAS1092-FAMILYPACK', 'Family Pack', 284.000000, 178);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001093', 'Tomato Ketchup', 'TOM1093', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009279', 'a0000000-0000-0000-0000-000000001093', 'TOM1093-SMALL', 'Small', 71.500000, 179),
  ('b0000000-0000-0000-0000-000000009280', 'a0000000-0000-0000-0000-000000001093', 'TOM1093-STANDARD', 'Standard', 143.000000, 180),
  ('b0000000-0000-0000-0000-000000009281', 'a0000000-0000-0000-0000-000000001093', 'TOM1093-FAMILYPACK', 'Family Pack', 286.000000, 181);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001094', 'Green Chilli Sauce', 'GRE1094', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009282', 'a0000000-0000-0000-0000-000000001094', 'GRE1094-SMALL', 'Small', 72.000000, 182),
  ('b0000000-0000-0000-0000-000000009283', 'a0000000-0000-0000-0000-000000001094', 'GRE1094-STANDARD', 'Standard', 144.000000, 183),
  ('b0000000-0000-0000-0000-000000009284', 'a0000000-0000-0000-0000-000000001094', 'GRE1094-FAMILYPACK', 'Family Pack', 288.000000, 184);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001095', 'Soya Sauce', 'SOY1095', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009285', 'a0000000-0000-0000-0000-000000001095', 'SOY1095-SMALL', 'Small', 72.500000, 185),
  ('b0000000-0000-0000-0000-000000009286', 'a0000000-0000-0000-0000-000000001095', 'SOY1095-STANDARD', 'Standard', 145.000000, 186),
  ('b0000000-0000-0000-0000-000000009287', 'a0000000-0000-0000-0000-000000001095', 'SOY1095-FAMILYPACK', 'Family Pack', 290.000000, 187);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001096', 'Oats (Rolled)', 'OAT1096', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009288', 'a0000000-0000-0000-0000-000000001096', 'OAT1096-SMALL', 'Small', 73.000000, 188),
  ('b0000000-0000-0000-0000-000000009289', 'a0000000-0000-0000-0000-000000001096', 'OAT1096-STANDARD', 'Standard', 146.000000, 189),
  ('b0000000-0000-0000-0000-000000009290', 'a0000000-0000-0000-0000-000000001096', 'OAT1096-FAMILYPACK', 'Family Pack', 292.000000, 190);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001097', 'Corn Flakes', 'COR1097', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009291', 'a0000000-0000-0000-0000-000000001097', 'COR1097-SMALL', 'Small', 73.500000, 191),
  ('b0000000-0000-0000-0000-000000009292', 'a0000000-0000-0000-0000-000000001097', 'COR1097-STANDARD', 'Standard', 147.000000, 192),
  ('b0000000-0000-0000-0000-000000009293', 'a0000000-0000-0000-0000-000000001097', 'COR1097-FAMILYPACK', 'Family Pack', 294.000000, 193);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001098', 'Muesli (Fruit & Nut)', 'MUE1098', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009294', 'a0000000-0000-0000-0000-000000001098', 'MUE1098-SMALL', 'Small', 74.000000, 194),
  ('b0000000-0000-0000-0000-000000009295', 'a0000000-0000-0000-0000-000000001098', 'MUE1098-STANDARD', 'Standard', 148.000000, 195),
  ('b0000000-0000-0000-0000-000000009296', 'a0000000-0000-0000-0000-000000001098', 'MUE1098-FAMILYPACK', 'Family Pack', 296.000000, 196);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001099', 'Dark Chocolate', 'DAR1099', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1511381939415-e4401546383d?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009297', 'a0000000-0000-0000-0000-000000001099', 'DAR1099-SMALL', 'Small', 74.500000, 197),
  ('b0000000-0000-0000-0000-000000009298', 'a0000000-0000-0000-0000-000000001099', 'DAR1099-STANDARD', 'Standard', 149.000000, 198),
  ('b0000000-0000-0000-0000-000000009299', 'a0000000-0000-0000-0000-000000001099', 'DAR1099-FAMILYPACK', 'Family Pack', 298.000000, 199);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001100', 'Milk Chocolate', 'MIL1100', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009300', 'a0000000-0000-0000-0000-000000001100', 'MIL1100-SMALL', 'Small', 75.000000, 50),
  ('b0000000-0000-0000-0000-000000009301', 'a0000000-0000-0000-0000-000000001100', 'MIL1100-STANDARD', 'Standard', 150.000000, 51),
  ('b0000000-0000-0000-0000-000000009302', 'a0000000-0000-0000-0000-000000001100', 'MIL1100-FAMILYPACK', 'Family Pack', 300.000000, 52);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001101', 'Wafer Biscuits', 'WAF1101', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009303', 'a0000000-0000-0000-0000-000000001101', 'WAF1101-SMALL', 'Small', 75.500000, 53),
  ('b0000000-0000-0000-0000-000000009304', 'a0000000-0000-0000-0000-000000001101', 'WAF1101-STANDARD', 'Standard', 151.000000, 54),
  ('b0000000-0000-0000-0000-000000009305', 'a0000000-0000-0000-0000-000000001101', 'WAF1101-FAMILYPACK', 'Family Pack', 302.000000, 55);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001102', 'Salty Biscuits', 'SAL1102', 'Snacks & Munchies', 0, 100.00, 'https://images.unsplash.com/photo-1463453091185-61582044d556?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009306', 'a0000000-0000-0000-0000-000000001102', 'SAL1102-SMALL', 'Small', 76.000000, 56),
  ('b0000000-0000-0000-0000-000000009307', 'a0000000-0000-0000-0000-000000001102', 'SAL1102-STANDARD', 'Standard', 152.000000, 57),
  ('b0000000-0000-0000-0000-000000009308', 'a0000000-0000-0000-0000-000000001102', 'SAL1102-FAMILYPACK', 'Family Pack', 304.000000, 58);

-- Category: Beverages
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001103', 'Orange Juice', 'ORA1103', 'Beverages', 0, 100.00, '/images/products/orange_juice.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009309', 'a0000000-0000-0000-0000-000000001103', 'ORA1103-250ML', '250ml', 45.900000, 59),
  ('b0000000-0000-0000-0000-000000009310', 'a0000000-0000-0000-0000-000000001103', 'ORA1103-500ML', '500ml', 76.500000, 60),
  ('b0000000-0000-0000-0000-000000009311', 'a0000000-0000-0000-0000-000000001103', 'ORA1103-1.5L', '1.5L', 153.000000, 61),
  ('b0000000-0000-0000-0000-000000009312', 'a0000000-0000-0000-0000-000000001103', 'ORA1103-2L', '2L', 198.900000, 62);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001104', 'Apple Juice', 'APP1104', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009313', 'a0000000-0000-0000-0000-000000001104', 'APP1104-250ML', '250ml', 46.200000, 63),
  ('b0000000-0000-0000-0000-000000009314', 'a0000000-0000-0000-0000-000000001104', 'APP1104-500ML', '500ml', 77.000000, 64),
  ('b0000000-0000-0000-0000-000000009315', 'a0000000-0000-0000-0000-000000001104', 'APP1104-1.5L', '1.5L', 154.000000, 65),
  ('b0000000-0000-0000-0000-000000009316', 'a0000000-0000-0000-0000-000000001104', 'APP1104-2L', '2L', 200.200000, 66);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001105', 'Mixed Fruit Juice', 'MIX1105', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1621506289937-db8e4dfabb3a?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009317', 'a0000000-0000-0000-0000-000000001105', 'MIX1105-250ML', '250ml', 46.500000, 67),
  ('b0000000-0000-0000-0000-000000009318', 'a0000000-0000-0000-0000-000000001105', 'MIX1105-500ML', '500ml', 77.500000, 68),
  ('b0000000-0000-0000-0000-000000009319', 'a0000000-0000-0000-0000-000000001105', 'MIX1105-1.5L', '1.5L', 155.000000, 69),
  ('b0000000-0000-0000-0000-000000009320', 'a0000000-0000-0000-0000-000000001105', 'MIX1105-2L', '2L', 201.500000, 70);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001106', 'Coconut Water', 'COC1106', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1526440263690-36ba9576da7f?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009321', 'a0000000-0000-0000-0000-000000001106', 'COC1106-250ML', '250ml', 46.800000, 71),
  ('b0000000-0000-0000-0000-000000009322', 'a0000000-0000-0000-0000-000000001106', 'COC1106-500ML', '500ml', 78.000000, 72),
  ('b0000000-0000-0000-0000-000000009323', 'a0000000-0000-0000-0000-000000001106', 'COC1106-1.5L', '1.5L', 156.000000, 73),
  ('b0000000-0000-0000-0000-000000009324', 'a0000000-0000-0000-0000-000000001106', 'COC1106-2L', '2L', 202.800000, 74);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001107', 'Pepsi (2L)', 'PEP1107', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009325', 'a0000000-0000-0000-0000-000000001107', 'PEP1107-250ML', '250ml', 47.100000, 75),
  ('b0000000-0000-0000-0000-000000009326', 'a0000000-0000-0000-0000-000000001107', 'PEP1107-500ML', '500ml', 78.500000, 76),
  ('b0000000-0000-0000-0000-000000009327', 'a0000000-0000-0000-0000-000000001107', 'PEP1107-1.5L', '1.5L', 157.000000, 77),
  ('b0000000-0000-0000-0000-000000009328', 'a0000000-0000-0000-0000-000000001107', 'PEP1107-2L', '2L', 204.100000, 78);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001108', 'Thumbs Up (750ml)', 'THU1108', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009329', 'a0000000-0000-0000-0000-000000001108', 'THU1108-250ML', '250ml', 47.400000, 79),
  ('b0000000-0000-0000-0000-000000009330', 'a0000000-0000-0000-0000-000000001108', 'THU1108-500ML', '500ml', 79.000000, 80),
  ('b0000000-0000-0000-0000-000000009331', 'a0000000-0000-0000-0000-000000001108', 'THU1108-1.5L', '1.5L', 158.000000, 81),
  ('b0000000-0000-0000-0000-000000009332', 'a0000000-0000-0000-0000-000000001108', 'THU1108-2L', '2L', 205.400000, 82);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001109', 'Red Bull', 'RED1109', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1622543953495-4742bc2c8e2b?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009333', 'a0000000-0000-0000-0000-000000001109', 'RED1109-250ML', '250ml', 47.700000, 83),
  ('b0000000-0000-0000-0000-000000009334', 'a0000000-0000-0000-0000-000000001109', 'RED1109-500ML', '500ml', 79.500000, 84),
  ('b0000000-0000-0000-0000-000000009335', 'a0000000-0000-0000-0000-000000001109', 'RED1109-1.5L', '1.5L', 159.000000, 85),
  ('b0000000-0000-0000-0000-000000009336', 'a0000000-0000-0000-0000-000000001109', 'RED1109-2L', '2L', 206.700000, 86);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001110', 'Energy Drink', 'ENE1110', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009337', 'a0000000-0000-0000-0000-000000001110', 'ENE1110-250ML', '250ml', 48.000000, 87),
  ('b0000000-0000-0000-0000-000000009338', 'a0000000-0000-0000-0000-000000001110', 'ENE1110-500ML', '500ml', 80.000000, 88),
  ('b0000000-0000-0000-0000-000000009339', 'a0000000-0000-0000-0000-000000001110', 'ENE1110-1.5L', '1.5L', 160.000000, 89),
  ('b0000000-0000-0000-0000-000000009340', 'a0000000-0000-0000-0000-000000001110', 'ENE1110-2L', '2L', 208.000000, 90);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001111', 'Mineral Water', 'MIN1111', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009341', 'a0000000-0000-0000-0000-000000001111', 'MIN1111-250ML', '250ml', 48.300000, 91),
  ('b0000000-0000-0000-0000-000000009342', 'a0000000-0000-0000-0000-000000001111', 'MIN1111-500ML', '500ml', 80.500000, 92),
  ('b0000000-0000-0000-0000-000000009343', 'a0000000-0000-0000-0000-000000001111', 'MIN1111-1.5L', '1.5L', 161.000000, 93),
  ('b0000000-0000-0000-0000-000000009344', 'a0000000-0000-0000-0000-000000001111', 'MIN1111-2L', '2L', 209.300000, 94);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001112', 'Sparkling Water', 'SPA1112', 'Beverages', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009345', 'a0000000-0000-0000-0000-000000001112', 'SPA1112-250ML', '250ml', 48.600000, 95),
  ('b0000000-0000-0000-0000-000000009346', 'a0000000-0000-0000-0000-000000001112', 'SPA1112-500ML', '500ml', 81.000000, 96),
  ('b0000000-0000-0000-0000-000000009347', 'a0000000-0000-0000-0000-000000001112', 'SPA1112-1.5L', '1.5L', 162.000000, 97),
  ('b0000000-0000-0000-0000-000000009348', 'a0000000-0000-0000-0000-000000001112', 'SPA1112-2L', '2L', 210.600000, 98);

-- Category: Household & Personal Care
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001113', 'Detergent Powder', 'DET1113', 'Household & Personal Care', 0, 100.00, '/images/products/detergent_powder.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009349', 'a0000000-0000-0000-0000-000000001113', 'DET1113-STANDARD', 'Standard', 163.000000, 99),
  ('b0000000-0000-0000-0000-000000009350', 'a0000000-0000-0000-0000-000000001113', 'DET1113-COMBOPACK', 'Combo Pack', 293.400000, 100);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001114', 'Dishwash Gel', 'DIS1114', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009351', 'a0000000-0000-0000-0000-000000001114', 'DIS1114-STANDARD', 'Standard', 164.000000, 101),
  ('b0000000-0000-0000-0000-000000009352', 'a0000000-0000-0000-0000-000000001114', 'DIS1114-COMBOPACK', 'Combo Pack', 295.200000, 102);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001115', 'Floor Cleaner', 'FLO1115', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009353', 'a0000000-0000-0000-0000-000000001115', 'FLO1115-STANDARD', 'Standard', 165.000000, 103),
  ('b0000000-0000-0000-0000-000000009354', 'a0000000-0000-0000-0000-000000001115', 'FLO1115-COMBOPACK', 'Combo Pack', 297.000000, 104);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001116', 'Glass Cleaner', 'GLA1116', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009355', 'a0000000-0000-0000-0000-000000001116', 'GLA1116-STANDARD', 'Standard', 166.000000, 105),
  ('b0000000-0000-0000-0000-000000009356', 'a0000000-0000-0000-0000-000000001116', 'GLA1116-COMBOPACK', 'Combo Pack', 298.800000, 106);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001117', 'Kitchen Tissue', 'KIT1117', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1584622781564-1d9876a13d1e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009357', 'a0000000-0000-0000-0000-000000001117', 'KIT1117-STANDARD', 'Standard', 167.000000, 107),
  ('b0000000-0000-0000-0000-000000009358', 'a0000000-0000-0000-0000-000000001117', 'KIT1117-COMBOPACK', 'Combo Pack', 300.600000, 108);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001118', 'Toilet Paper', 'TOI1118', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009359', 'a0000000-0000-0000-0000-000000001118', 'TOI1118-STANDARD', 'Standard', 168.000000, 109),
  ('b0000000-0000-0000-0000-000000009360', 'a0000000-0000-0000-0000-000000001118', 'TOI1118-COMBOPACK', 'Combo Pack', 302.400000, 110);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001119', 'Garbage Bags', 'GAR1119', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009361', 'a0000000-0000-0000-0000-000000001119', 'GAR1119-STANDARD', 'Standard', 169.000000, 111),
  ('b0000000-0000-0000-0000-000000009362', 'a0000000-0000-0000-0000-000000001119', 'GAR1119-COMBOPACK', 'Combo Pack', 304.200000, 112);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001120', 'Bathing Soap', 'BAT1120', 'Household & Personal Care', 0, 100.00, '/images/products/bathing_soap.png', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009363', 'a0000000-0000-0000-0000-000000001120', 'BAT1120-STANDARD', 'Standard', 170.000000, 113),
  ('b0000000-0000-0000-0000-000000009364', 'a0000000-0000-0000-0000-000000001120', 'BAT1120-COMBOPACK', 'Combo Pack', 306.000000, 114);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001121', 'Handwash Liquid', 'HAN1121', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009365', 'a0000000-0000-0000-0000-000000001121', 'HAN1121-STANDARD', 'Standard', 171.000000, 115),
  ('b0000000-0000-0000-0000-000000009366', 'a0000000-0000-0000-0000-000000001121', 'HAN1121-COMBOPACK', 'Combo Pack', 307.800000, 116);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001122', 'Shampoo (Anti-dandruff)', 'SHA1122', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009367', 'a0000000-0000-0000-0000-000000001122', 'SHA1122-STANDARD', 'Standard', 172.000000, 117),
  ('b0000000-0000-0000-0000-000000009368', 'a0000000-0000-0000-0000-000000001122', 'SHA1122-COMBOPACK', 'Combo Pack', 309.600000, 118);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001123', 'Toothpaste (Herbal)', 'TOO1123', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009369', 'a0000000-0000-0000-0000-000000001123', 'TOO1123-STANDARD', 'Standard', 173.000000, 119),
  ('b0000000-0000-0000-0000-000000009370', 'a0000000-0000-0000-0000-000000001123', 'TOO1123-COMBOPACK', 'Combo Pack', 311.400000, 120);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001124', 'Face Wash', 'FAC1124', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009371', 'a0000000-0000-0000-0000-000000001124', 'FAC1124-STANDARD', 'Standard', 174.000000, 121),
  ('b0000000-0000-0000-0000-000000009372', 'a0000000-0000-0000-0000-000000001124', 'FAC1124-COMBOPACK', 'Combo Pack', 313.200000, 122);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001125', 'Body Lotion', 'BOD1125', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009373', 'a0000000-0000-0000-0000-000000001125', 'BOD1125-STANDARD', 'Standard', 175.000000, 123),
  ('b0000000-0000-0000-0000-000000009374', 'a0000000-0000-0000-0000-000000001125', 'BOD1125-COMBOPACK', 'Combo Pack', 315.000000, 124);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001126', 'Deodorant', 'DEO1126', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009375', 'a0000000-0000-0000-0000-000000001126', 'DEO1126-STANDARD', 'Standard', 176.000000, 125),
  ('b0000000-0000-0000-0000-000000009376', 'a0000000-0000-0000-0000-000000001126', 'DEO1126-COMBOPACK', 'Combo Pack', 316.800000, 126);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001127', 'Sanitary Pads', 'SAN1127', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009377', 'a0000000-0000-0000-0000-000000001127', 'SAN1127-STANDARD', 'Standard', 177.000000, 127),
  ('b0000000-0000-0000-0000-000000009378', 'a0000000-0000-0000-0000-000000001127', 'SAN1127-COMBOPACK', 'Combo Pack', 318.600000, 128);
INSERT INTO public.products (id, product_name, sku, category, quantity, price, image_url, supplier_id) VALUES ('a0000000-0000-0000-0000-000000001128', 'Air Freshener', 'AIR1128', 'Household & Personal Care', 0, 100.00, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80', 'f1000000-0000-0000-0000-000000000001');
INSERT INTO public.product_variants (id, product_id, sku, label, price, quantity) VALUES
  ('b0000000-0000-0000-0000-000000009379', 'a0000000-0000-0000-0000-000000001128', 'AIR1128-STANDARD', 'Standard', 178.000000, 129),
  ('b0000000-0000-0000-0000-000000009380', 'a0000000-0000-0000-0000-000000001128', 'AIR1128-COMBOPACK', 'Combo Pack', 320.400000, 130);

NOTIFY pgrst, 'reload schema';