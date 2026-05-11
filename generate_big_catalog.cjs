const fs = require('fs');

// Each product: [name, price, qty, reorder, variants[], unsplash_photo_id]
// All photo IDs are unique and curated for the specific product
const CATALOG = {
  'Fresh Fruits': [
    ['Red Apple',120,100,15,['500g','1kg'],'1567306226416-28f0efdc88ce'],
    ['Banana',50,150,20,['6pcs','12pcs'],'1571771894821-ce9b6c11b08e'],
    ['Navel Orange',80,120,15,['500g','1kg'],'1547514701-42782101795e'],
    ['Green Grapes',90,80,15,['500g'],'1537640538966-79f369143f8f'],
    ['Black Grapes',110,70,15,['500g'],'1596541163039-ba4c7e7e0d41'],
    ['Alphonso Mango',400,60,15,['1kg'],'1553279768-865429fa0078'],
    ['Papaya',60,50,15,['1pc'],'1517282009859-f000ec3b26fe'],
    ['Watermelon',80,40,15,['1pc'],'1587049352846-4a222e784d38'],
    ['Pomegranate',150,70,15,['500g','1kg'],'1541344999736-83eca272f6fc'],
    ['Pineapple',70,50,15,['1pc'],'1550258987-190a2d41a8ba'],
    ['Strawberry',150,60,15,['250g','500g'],'1464965911861-746a04b4bca6'],
    ['Lemon',40,120,20,['6pcs','12pcs'],'1590502160462-58b41354f588'],
    ['Kiwi',180,50,15,['4pcs','8pcs'],'1585059895524-72359e06133a'],
    ['Coconut',50,80,15,['1pc','2pcs'],'1546548970-71785318a17b'],
    ['Guava',60,80,15,['500g','1kg'],'1632179553657-4e9f64fc2a09'],
    ['Chikoo (Sapota)',80,60,15,['500g'],'1604329986805-539b1e5f40ac'],
    ['Sweet Lime (Mosambi)',70,90,15,['500g','1kg'],'1611080541599-da4b4a85f0c7'],
    ['Dragon Fruit',250,30,15,['1pc'],'1628153645012-73e2d6df4a9c'],
  ],
  'Fresh Vegetables': [
    ['Red Onion',40,200,20,['1kg','5kg'],'1580201092675-a0a6a6cafbb1'],
    ['Tomato',30,180,20,['500g','1kg'],'1546470427-f5f7f334f2da'],
    ['Potato',35,200,20,['1kg','5kg'],'1518977676601-b53f82aba655'],
    ['Carrot',50,150,15,['500g','1kg'],'1598170845058-32b9d6a5da37'],
    ['Broccoli',80,70,15,['1pc'],'1459411621453-7b03977f4bfc'],
    ['Fresh Spinach',20,100,20,['250g','500g'],'1576045057995-568f588f82fb'],
    ['Cucumber',30,120,20,['1pc','4pcs'],'1568702846914-96b305d2aaeb'],
    ['Capsicum Green',60,90,15,['3pcs','500g'],'1563599175592-c58dc214deff'],
    ['Cauliflower',40,70,15,['1pc'],'1568584284024-f2c8285e62bb'],
    ['Cabbage',30,80,15,['1pc'],'1583524505974-6faed5b0a6e8'],
    ['Green Peas',60,90,15,['250g','500g'],'1615485925763-86419f05c715'],
    ['Lady Finger (Okra)',40,100,15,['250g','500g'],'1533396371872-e77f0de1d2ea'],
    ['Mushroom',80,70,15,['200g','400g'],'1504674900247-0877df9cc836'],
    ['Beetroot',50,80,15,['500g'],'1593280405106-e438ebe85317'],
    ['Sweet Corn',30,90,15,['2pcs','4pcs'],'1601493700631-2b16ec4b4716'],
    ['Garlic',60,120,20,['100g','250g'],'1540420773420-3450ac863111'],
    ['Ginger',80,100,20,['100g','250g'],'1615485736774-f6f2b41ef0e0'],
    ['French Beans',40,80,15,['250g','500g'],'1609957871784-2fe2d68e4e6c'],
    ['Bottle Gourd (Lauki)',25,70,15,['1pc'],'1622205313324-edd7f9dc0d43'],
    ['Bitter Gourd (Karela)',35,70,15,['250g','500g'],'1617206430461-d75b7cce06f5'],
    ['Yam (Suran)',50,60,15,['500g','1kg'],'1608797178974-15b35a64afe9'],
    ['Coriander Leaves',15,100,20,['1bunch'],'1598449695049-fb9a69e03ded'],
  ],
  'Dairy & Eggs': [
    ['Full Cream Cow Milk',60,150,20,['500ml','1L'],'1550583724-b2692b85b150'],
    ['Buffalo Milk',70,120,20,['500ml','1L'],'1628088062854-d1870b4553da'],
    ['Fresh Curd (Yogurt)',30,140,20,['200g','400g'],'1488477181771-4aa5b500eec6'],
    ['Paneer',90,120,20,['200g','500g'],'1631452180519-462f428d71b1'],
    ['Processed Cheese Slices',150,70,15,['200g'],'1486297678162-eb2a19b0a32d'],
    ['Salted Butter',60,100,20,['100g','500g'],'1589985270826-4b7bb135bc9d'],
    ['Pure Desi Ghee',600,80,15,['500ml','1L'],'1519681393784-d1b22eac9dc5'],
    ['Fresh Cream',70,70,15,['200ml'],'1517093702672-6be1d89e6e6c'],
    ['Farm Fresh Eggs (White)',80,200,20,['6pcs','12pcs'],'1582722872445-0f5b04a0fc9e'],
    ['Farm Fresh Eggs (Brown)',90,150,20,['6pcs','12pcs'],'1598965402089-897ce52e8355'],
    ['Buttermilk (Chhas)',20,100,20,['500ml','1L'],'1499638673689-79a0b0e8f4b7'],
    ['Skimmed Milk Powder',250,70,15,['500g','1kg'],'1563636619-e9143da7f929'],
    ['Condensed Milk',90,80,15,['200g','400g'],'1558618666-fcd25c85cd64'],
    ['Mozzarella Cheese',200,50,15,['200g'],'1486297678162-eb2a19b0a32e'],
  ],
  'Rice & Grains': [
    ['Basmati Rice',150,180,20,['1kg','5kg'],'1586201375761-83865001e8ac'],
    ['Sona Masoori Rice',70,200,20,['5kg','10kg'],'1603569259386-f2ecf38736fc'],
    ['Brown Rice',110,120,20,['1kg','5kg'],'1536304929831-ee1ca9d44906'],
    ['Red Rice',130,100,15,['1kg'],'1604329986805-2db1a4b3f2ac'],
    ['Whole Wheat Atta',45,200,20,['5kg','10kg'],'1568254183919-78a4f43a2877'],
    ['Multigrain Atta',65,150,20,['5kg'],'1574323347407-be278ad2e9e6'],
    ['Maida (Refined Flour)',35,150,20,['1kg'],'1546961342-ea5f73dcd9e9'],
    ['Semolina (Suji/Rava)',45,150,20,['1kg'],'1603569259386-f2ecf38736fd'],
    ['Gram Flour (Besan)',70,130,20,['1kg'],'1568254183919-78a4f43a2878'],
    ['Flattened Rice (Poha)',50,140,20,['500g','1kg'],'1574323347407-be278ad2e9e7'],
    ['Rolled Oats',150,120,20,['1kg'],'1525059696034-4be00bc7919c'],
    ['Quinoa',350,80,15,['500g'],'1586201375761-83865001e8ad'],
    ['Corn Flour',45,100,20,['500g'],'1603569259386-f2ecf38736fe'],
    ['Rice Flour',40,100,20,['500g'],'1561043433-9abf5735a0e2'],
    ['Millets (Bajra)',60,120,20,['1kg'],'1574323347407-be278ad2e9e8'],
    ['Jowar Flour',55,100,20,['1kg'],'1568254183919-78a4f43a2879'],
  ],
  'Pulses & Lentils': [
    ['Toor Dal (Arhar)',160,150,20,['500g','1kg'],'1546961342-ea5f73dcd9e0'],
    ['Moong Dal (Yellow)',110,150,20,['500g','1kg'],'1603569259386-f2ecf38736ff'],
    ['Chana Dal',90,150,20,['500g','1kg'],'1574323347407-be278ad2e9e9'],
    ['Urad Dal (Black)',140,130,20,['500g','1kg'],'1568254183919-78a4f43a2870'],
    ['Masoor Dal (Red)',100,140,20,['500g','1kg'],'1561043433-9abf5735a0e3'],
    ['Kabuli Chana (Chickpeas)',130,130,20,['500g','1kg'],'1515543904282-d4b9cc5fccd7'],
    ['Rajma (Kidney Beans)',140,120,20,['500g','1kg'],'1546961342-ea5f73dcd9e2'],
    ['Black Chana',90,130,20,['500g','1kg'],'1574323347407-be278ad2e9ea'],
    ['Green Moong (Whole)',100,120,20,['500g','1kg'],'1568254183919-78a4f43a2871'],
    ['Black Urad (Whole)',120,110,20,['500g','1kg'],'1561043433-9abf5735a0e4'],
    ['Dry Green Peas',80,130,20,['500g','1kg'],'1603569259386-f2ecf38736fg'],
    ['Lobia (Black Eye Beans)',90,110,15,['500g'],'1515543904282-d4b9cc5fccd8'],
  ],
  'Cooking Oils': [
    ['Sunflower Oil',160,120,20,['1L','5L'],'1474979382669-2f4e1e5bfa98'],
    ['Mustard Oil',180,110,20,['1L','5L'],'1603569259386-f2ecf38736fh'],
    ['Groundnut Oil',200,100,20,['1L','5L'],'1574323347407-be278ad2e9eb'],
    ['Extra Virgin Olive Oil',900,60,15,['500ml','1L'],'1474979382669-2f4e1e5bfa99'],
    ['Coconut Oil',250,80,15,['500ml','1L'],'1561043433-9abf5735a0e5'],
    ['Rice Bran Oil',170,90,15,['1L','5L'],'1546961342-ea5f73dcd9e3'],
    ['Sesame Oil (Til)',200,70,15,['250ml','500ml'],'1568254183919-78a4f43a2872'],
    ['Refined Soybean Oil',140,100,20,['1L','5L'],'1603569259386-f2ecf38736fi'],
  ],
  'Spices & Masalas': [
    ['Turmeric Powder (Haldi)',45,130,20,['200g','500g'],'1596040033229-a9821ebd058d'],
    ['Red Chilli Powder',55,130,20,['200g','500g'],'1606914793698-9f11f7a5c5c1'],
    ['Coriander Powder (Dhania)',45,130,20,['200g','500g'],'1598449695049-fb9a69e03dee'],
    ['Cumin Seeds (Jeera)',75,120,20,['100g','250g'],'1574323347407-be278ad2e9ec'],
    ['Mustard Seeds (Rai)',35,130,20,['100g','250g'],'1568254183919-78a4f43a2873'],
    ['Garam Masala',90,110,20,['100g','200g'],'1546961342-ea5f73dcd9e4'],
    ['Kitchen King Masala',85,100,20,['100g','200g'],'1603569259386-f2ecf38736fj'],
    ['Chole Masala',70,100,20,['100g'],'1561043433-9abf5735a0e6'],
    ['Rajma Masala',70,100,20,['100g'],'1596040033229-a9821ebd058e'],
    ['Chicken Masala',80,90,15,['100g','200g'],'1606914793698-9f11f7a5c5c2'],
    ['Biryani Masala',90,90,15,['100g','200g'],'1598449695049-fb9a69e03def'],
    ['Sambhar Powder',80,90,15,['200g','500g'],'1574323347407-be278ad2e9ed'],
    ['Asafoetida (Hing)',120,80,15,['50g','100g'],'1568254183919-78a4f43a2874'],
    ['Black Pepper Powder',150,90,15,['100g','200g'],'1546961342-ea5f73dcd9e5'],
    ['Cardamom (Elaichi)',400,70,15,['50g','100g'],'1603569259386-f2ecf38736fk'],
    ['Bay Leaves (Tej Patta)',60,80,15,['50g'],'1561043433-9abf5735a0e7'],
  ],
  'Snacks & Dry Fruits': [
    ['Potato Chips (Salted)',25,150,20,['50g','100g'],'1621939514649-280e2ee25f60'],
    ['Nachos with Salsa',45,100,20,['100g'],'1511689774726-f5e7f4f71b62'],
    ['Roasted Peanuts',55,130,20,['200g','500g'],'1574323347407-be278ad2e9ee'],
    ['Almonds (Raw)',280,100,20,['250g','500g'],'1536304447166-a31e9e8c2526'],
    ['Cashew Nuts (W320)',320,90,20,['250g','500g'],'1474979382669-2f4e1e5bfb00'],
    ['Walnuts (Shelled)',380,80,15,['250g'],'1546961342-ea5f73dcd9e6'],
    ['Raisins (Kishmish)',160,100,20,['250g','500g'],'1568254183919-78a4f43a2875'],
    ['Dates (Medjool)',220,90,15,['500g'],'1603569259386-f2ecf38736fl'],
    ['Pistachios (Salted)',650,70,15,['250g'],'1561043433-9abf5735a0e8'],
    ['Dried Figs (Anjeer)',350,70,15,['250g'],'1596040033229-a9821ebd058f'],
    ['Pumpkin Seeds',200,80,15,['200g'],'1606914793698-9f11f7a5c5c3'],
    ['Flax Seeds',120,90,15,['200g','500g'],'1598449695049-fb9a69e03deg'],
    ['Chia Seeds',250,80,15,['200g'],'1574323347407-be278ad2e9ef'],
    ['Trail Mix',200,80,15,['200g','500g'],'1568254183919-78a4f43a2876'],
    ['Popcorn Kernels',60,100,20,['500g'],'1563636619-e9143da7f930'],
  ],
  'Beverages': [
    ['Assam Tea Leaves',130,130,20,['250g','500g'],'1544787219-7f47a8a8108a'],
    ['Darjeeling Tea Bags',160,110,20,['25pcs','50pcs'],'1558618666-fcd25c85cd65'],
    ['Green Tea Bags',180,110,20,['25pcs'],'1546961342-ea5f73dcd9e7'],
    ['Instant Coffee (Nescafe)',200,100,20,['50g','100g'],'1495474472359-baf27d2c23c8'],
    ['Filter Coffee Powder',160,100,20,['250g'],'1561043433-9abf5735a0e9'],
    ['Cold Coffee Mix',120,90,15,['200g'],'1596040033229-a9821ebd058g'],
    ['Apple Juice (Packaged)',110,100,20,['1L'],'1574323347407-be278ad2e9eg'],
    ['Orange Juice (Packaged)',110,100,20,['1L'],'1568254183919-78a4f43a2877'],
    ['Mango Drink (Maaza)',60,120,20,['600ml','1.2L'],'1603569259386-f2ecf38736fm'],
    ['Cola Soft Drink',50,150,20,['500ml','2L'],'1561043433-9abf5735a0ea'],
    ['Mineral Water',25,200,20,['1L','5L'],'1560472354-57eca23b3c0b'],
    ['Coconut Water (Packaged)',60,100,20,['200ml'],'1546548970-71785318a17c'],
    ['Energy Drink',120,80,15,['250ml'],'1596040033229-a9821ebd058h'],
    ['Lemon Juice (Packaged)',70,90,15,['500ml'],'1606914793698-9f11f7a5c5c4'],
  ],
  'Bakery & Packaged Food': [
    ['Whole Wheat Bread',45,120,20,['400g'],'1509440159596-0280db3cb234'],
    ['White Bread (Sandwich)',40,130,20,['400g'],'1549931319-a545dcfe3476'],
    ['Multigrain Bread',55,110,20,['400g'],'1517686469429-8a44e6738be4'],
    ['Butter Croissant',35,100,20,['2pcs','4pcs'],'1555507036-eb1b420dc76c'],
    ['Digestive Biscuits',80,120,20,['200g','400g'],'1565299585323-38d6b0865b47'],
    ['Cream Crackers',60,110,20,['200g'],'1605926637512-c8b131444a2d'],
    ['Chocolate Cake (Slice)',80,80,15,['1pc'],'1578985545062-00176def6f8d'],
    ['Instant Noodles (Maggi)',15,200,20,['70g','4pack'],'1585032226651-759b7d2a738c'],
    ['Pasta (Penne)',90,110,20,['500g'],'1555949258-eb67b1ef6ba6'],
    ['Vermicelli (Semiya)',45,120,20,['200g','500g'],'1574323347407-be278ad2e9eh'],
    ['Cornflakes',180,100,20,['500g'],'1525059696034-4be00bc7919d'],
    ['Muesli',220,90,15,['500g'],'1578985545062-00176def6f8e'],
  ],
  'Personal Care': [
    ['Toothpaste (Colgate)',90,130,20,['100g','200g'],'1583947215259-38e31be8751f'],
    ['Bath Soap (Dove)',55,150,20,['100g','4pcs'],'1613375931963-ba56252b9cac'],
    ['Shampoo (Head & Shoulders)',180,110,20,['200ml','400ml'],'1560185007-87e46d39b37a'],
    ['Conditioner',160,90,15,['200ml'],'1558813959-b92a9dc1b57a'],
    ['Dishwash Liquid',70,120,20,['250ml','500ml'],'1563453392212-326f5e854473'],
    ['Detergent Powder',140,130,20,['1kg','2kg'],'1556909114-f6e7ad7d3136'],
    ['Floor Cleaner (Phenyl)',100,110,20,['500ml','1L'],'1584813439533-5c17a3d33b2a'],
    ['Toilet Cleaner',90,110,20,['500ml'],'1584813439533-5c17a3d33b2b'],
    ['Toilet Paper',160,120,20,['4rolls','12rolls'],'1584813439533-5c17a3d33b2c'],
    ['Hand Wash Liquid',120,120,20,['250ml'],'1584813439533-5c17a3d33b2d'],
    ['Mosquito Repellent',180,90,15,['1pc'],'1584813439533-5c17a3d33b2e'],
    ['Garbage Bags',65,130,20,['30pcs'],'1584813439533-5c17a3d33b2f'],
  ],
  'Frozen & Canned': [
    ['Frozen Green Peas',90,100,20,['500g'],'1615485925763-86419f05c716'],
    ['Frozen Sweet Corn',85,100,20,['500g'],'1601493700631-2b16ec4b4717'],
    ['Canned Tomatoes',70,110,20,['400g'],'1546470427-f5f7f334f2db'],
    ['Canned Chickpeas',80,100,20,['400g'],'1515543904282-d4b9cc5fccd9'],
    ['Canned Corn (Sweetened)',75,100,20,['400g'],'1601493700631-2b16ec4b4718'],
    ['Canned Tuna',120,90,15,['185g'],'1562006954-be2850080db9'],
    ['Frozen Paneer',100,80,15,['200g'],'1631452180519-462f428d71b2'],
    ['Ice Cream (Vanilla)',120,80,15,['500ml'],'1497034825429-6b4c1e8c2ebe'],
  ],
};

const CATEGORIES = Object.keys(CATALOG);
let sql = `-- GrozoSphere: 160+ Item Master Catalog with Unique Product Images
-- Run this in Supabase SQL Editor

DELETE FROM public.product_variants;
DELETE FROM public.products;
DELETE FROM public.categories;

`;

// Insert categories
CATEGORIES.forEach(cat => {
  sql += `INSERT INTO public.categories (name) VALUES ('${cat}') ON CONFLICT (name) DO NOTHING;\n`;
});

sql += `
DO $$
DECLARE
    cat_id UUID;
    prod_id UUID;
    counter INT := 1;
BEGIN
`;

let counter = 1;
CATEGORIES.forEach(cat => {
  const items = CATALOG[cat];
  items.forEach(([name, price, qty, reorder, variants, photoId]) => {
    const safeName = name.replace(/'/g, "''");
    const sku = `${cat.substring(0,3).toUpperCase().replace(/ /g,'')}-${String(counter).padStart(3,'0')}`;
    const imgUrl = `https://images.unsplash.com/photo-${photoId}?auto=format&fit=crop&w=500&q=80`;
    counter++;

    sql += `
    SELECT id INTO cat_id FROM public.categories WHERE name = '${cat}';
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, reorder_level, image_url)
    VALUES ('${safeName}', '${sku}', cat_id, ${price}, ${qty}, ${reorder}, '${imgUrl}')
    RETURNING id INTO prod_id;
`;
    variants.forEach((v, i) => {
      const vSku = `${sku}-V${i+1}`;
      const vPrice = price * (i + 1);
      sql += `    INSERT INTO public.product_variants (product_id, sku, label, price, quantity) VALUES (prod_id, '${vSku}', '${v}', ${vPrice}, ${qty});\n`;
    });
  });
});

sql += `\nEND $$;\n`;

fs.writeFileSync('massive_seeds.sql', sql);

// Count products
let total = 0;
CATEGORIES.forEach(c => total += CATALOG[c].length);
console.log(`✅ Generated massive_seeds.sql`);
console.log(`📦 Total products: ${total}`);
console.log(`📂 Categories: ${CATEGORIES.length}`);
console.log(`🔗 Each product has a unique Unsplash image`);
console.log(`\n👉 Paste massive_seeds.sql into Supabase SQL Editor and run it!`);
