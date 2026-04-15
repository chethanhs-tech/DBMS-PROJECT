const fs = require('fs');

const categories = {
  Fruits: [
    { n: 'Banana', img: '1571771894821-ad9b58a32947' },
    { n: 'Apple Shimla', img: '1560806887-1e436279f0fb' },
    { n: 'Nagpur Orange', img: '1557800636-894a64c1696f' },
    { n: 'Alphonso Mango', img: '1553279768-865429fa0078' },
    { n: 'Green Grapes', img: '1537640538966-79f369b41e8f' },
    { n: 'Pomegranate', img: '1620127812573-04746f338d8a' },
    { n: 'Watermelon', img: '1587049352846-4a222e784d38' },
    { n: 'Strawberry Box', img: '1464965911861-746a04b4bca6' },
    { n: 'Blueberries', img: '1497534446932-c925b458314e' },
    { n: 'Pineapple', img: '1550258859-6af52b9d0dd4' },
    { n: 'Kiwi Gold', img: '1585059895316-298928620301' },
    { n: 'Papaya', img: '1517282001574-3bc887730e4c' },
  ],
  Vegetables: [
    { n: 'Tomato Local', img: '1592924357228-91a4daadcfea' },
    { n: 'Pink Onions', img: '1508747703725-719777637510' },
    { n: 'Potato Agra', img: '1518977676601-b53f82aba655' },
    { n: 'Broccoli', img: '1459411621453-7b03977f4bfc' },
    { n: 'Cucumber', img: '1449333256619-8b05ff81c814' },
    { n: 'Bell Peppers', img: '1566270830-7cb52220badc' },
    { n: 'Sweet Corn', img: '1551754655-cd27e38d2076' },
    { n: 'Carrot Ooty', img: '1444731961956-751ed90465a5' },
    { n: 'Spinach Bundle', img: '1551008475-4533d14444d3' },
    { n: 'Garlic', img: '1540148426945-6cf22a6b2383' },
    { n: 'Ginger Fresh', img: '1599940824399-b87987ceb72a' },
    { n: 'Cabbage', img: '1518977676601-b53f82aba655' },
  ],
  Bakery: [
    { n: 'Whole Wheat Bread', img: '1509440159596-0249088772ff' },
    { n: 'White Milk Bread', img: '1549931319-a545dcf3bc73' },
    { n: 'Brownie Box', img: '1467003909585-2f8a72700288' },
    { n: 'Butter Croissant', img: '1555507036-ab1f4038808a' },
    { n: 'Chocolate Muffin', img: '1558303420-f814d8a590f5' },
    { n: 'Baguette', img: '1586190848861-99aa4a171e90' },
    { n: 'Sourdough Loaf', img: '1589367920951-325644f27154' },
  ],
  Dairy: [
    { n: 'Farm Fresh Eggs', img: '1516448138547-797d7041c0ca' },
    { n: 'Fresh Milk', img: '1550583724-1255818c0533' },
    { n: 'Salted Butter', img: '1588195538320-062080a905a5' },
    { n: 'Cheddar Cheese', img: '1486297678162-eb2a19b0a32d' },
    { n: 'Greek Yogurt', img: '1488477181944-59bbfa2161b9' },
  ],
  Beverages: [
    { n: 'Coca Cola', img: '1622483767028-3f66f32aef97' },
    { n: 'Sprite', img: '1625772290748-39126ddd9d61' },
    { n: 'Nescafe Coffee', img: '1559056199-641a0ac8b55e' },
    { n: 'Green Tea', img: '1544787210-2136d80a071d' },
    { n: 'Tropicana Orange', img: '1624517452488-04869289c4ca' },
    { n: 'Mineral Water', img: '1523362628744-0c10a1bb20f4' },
    { n: 'Apple Juice', img: '1622483767028-3f66f32aef97' }, 
  ],
  Snacks: [
    { n: 'Classic Lays', img: '1566478989037-eec170784d0b' },
    { n: 'Oreo Cookies', img: '1558961363-fa8fdf82db35' },
    { n: 'Dark Chocolate', img: '1515037893149-de7f402540af' },
    { n: 'Mixed Nuts', img: '1532550907401-20addc8fdcb1' },
    { n: 'Protein Bar', img: '1515037893149-de7f402540af' },
  ],
  Pantry: [
    { n: 'Basmati Rice', img: '1586201375761-83865001e31c' },
    { n: 'Wheat Atta', img: '1509440159596-0249088772ff' },
    { n: 'Olive Oil', img: '1474979266404-7eaacbcd87da' },
    { n: 'Himalayan Pink Salt', img: '1514065609653-f7560128a3fe' },
    { n: 'Black Pepper', img: '1596660636236-8c430e462d7c' },
  ]
};

const variants = [
  { w: '250 g', m: 0.25, lbl: '250g' },
  { w: '500 g', m: 0.5, lbl: '500g' },
  { w: '1 kg', m: 1, lbl: '1kg' },
];

let items = [];
const basePrice = 100;
let skuCounter = 1000;

for (const [cat, products] of Object.entries(categories)) {
  for (const p of products) {
    if (cat === 'Fruits' || cat === 'Vegetables' || cat === 'Pantry') {
      variants.forEach(v => {
        let price = Math.round((basePrice * v.m) + (Math.random() * 20));
        let qty = Math.floor(Math.random() * 150) + 20;
        let reorder = 15;
        items.push(`(gen_random_uuid(), '${p.n} (${v.w})', 'SKU-${skuCounter++}', '${cat}', ${qty}, ${price}.00, ${reorder}, '${v.lbl}', 'a1a1a1a1-1111-1111-1111-a1a1a1a1a1a1', 'https://images.unsplash.com/photo-${p.img}?auto=format&fit=crop&q=80&w=800')`);
      });
    } else {
      let price = Math.floor(Math.random() * 100) + 30;
      let qty = Math.floor(Math.random() * 100) + 20;
      items.push(`(gen_random_uuid(), '${p.n}', 'SKU-${skuCounter++}', '${cat}', ${qty}, ${price}.00, 10, '1 unit', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', 'https://images.unsplash.com/photo-${p.img}?auto=format&fit=crop&q=80&w=800')`);
      
      if (cat === 'Beverages' || cat === 'Dairy') {
        // Add a secondary size pack
        items.push(`(gen_random_uuid(), '${p.n} (Pack of 6)', 'SKU-${skuCounter++}', '${cat}', ${qty}, ${price*5}.00, 10, '6 pk', 'b2b2b2b2-2222-2222-2222-b2b2b2b2b2b2', 'https://images.unsplash.com/photo-${p.img}?auto=format&fit=crop&q=80&w=800')`);
      }
    }
  }
}

// Ensure length is over 120
// The loops above yield: (12+12+5)*3 = 87 items. + 7 + 5 + 7 + 5 + 12 = 36. Total: 123 items! Perfect.

let sql = `
---------------------------------------------------------------------
-- 🚀 THE SUPER-MASTER RESTORATION V2 (120+ PREMIUM ITEMS)
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
${items.join(',\n')};

-- 🚨 LOW STOCK TRIGGERS 🚨
UPDATE public.products SET quantity = 3, reorder_level = 10, price = 450.00 WHERE product_name LIKE 'Alphonso Mango (1 kg)';
UPDATE public.products SET quantity = 5, reorder_level = 15, price = 250.00 WHERE product_name LIKE 'Strawberry Box (250 g)';
UPDATE public.products SET quantity = 2, reorder_level = 10, price = 65.00 WHERE product_name LIKE 'Fresh Milk';

INSERT INTO public.alerts (product_id, message, status) 
SELECT id, 'Low stock alert: ' || product_name || ' is running out', 'unread' 
FROM public.products 
WHERE quantity <= 5;

NOTIFY pgrst, 'reload schema';
`;

fs.writeFileSync('COMPLETE_RESTORE_100.sql', sql);
console.log('Script written perfectly to COMPLETE_RESTORE_100.sql. Length:', items.length);
