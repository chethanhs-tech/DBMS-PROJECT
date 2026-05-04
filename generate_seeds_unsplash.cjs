const fs = require('fs');

const CATEGORY_IMAGES = {
  'Fruits': 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?auto=format&fit=crop&w=500&q=80',
  'Vegetables': 'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?auto=format&fit=crop&w=500&q=80',
  'Dairy': 'https://images.unsplash.com/photo-1628088062854-d1870b4553da?auto=format&fit=crop&w=500&q=80',
  'Grains & Rice': 'https://images.unsplash.com/photo-1586201375761-83865001e8ac?auto=format&fit=crop&w=500&q=80',
  'Pulses': 'https://images.unsplash.com/photo-1515543237350-b3eea1ec8082?auto=format&fit=crop&w=500&q=80',
  'Oils & Spices': 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=500&q=80',
  'Snacks': 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?auto=format&fit=crop&w=500&q=80',
  'Beverages': 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=500&q=80',
  'Daily Essentials': 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?auto=format&fit=crop&w=500&q=80'
};

const CATEGORIES = Object.keys(CATEGORY_IMAGES);

let sql = `-- Massive 120 Item Seeding Script with Premium Unsplash Images\n\n`;

sql += `
-- 1. DELETE existing products and variants to prevent duplication
DELETE FROM public.product_variants;
DELETE FROM public.products;
DELETE FROM public.categories;
\n`;

sql += `-- 2. Insert Categories\n`;
CATEGORIES.forEach(cat => {
    sql += `INSERT INTO public.categories (name) VALUES ('${cat}') ON CONFLICT (name) DO NOTHING;\n`;
});

sql += `\n-- 3. Insert Products\n`;

const catalog = [];
const addItems = (cat, items) => {
items.forEach((item, i) => {
    catalog.push({
    category: cat,
    name: item.n,
    price: item.p,
    sku: `${cat.substring(0,3).toUpperCase()}-${Math.floor(Math.random()*10000)}-${i}`,
    variants: item.v,
    imgUrl: CATEGORY_IMAGES[cat]
    });
});
};

addItems('Fruits', [
{ n: 'Fresh Apples', p: 120, v: ['500g', '1kg'] },
{ n: 'Ripe Bananas', p: 60, v: ['500g', '1kg'] },
{ n: 'Oranges', p: 80, v: ['500g', '1kg'] },
{ n: 'Grapes Green', p: 90, v: ['500g'] },
{ n: 'Grapes Black', p: 100, v: ['500g'] },
{ n: 'Mango Alphonso', p: 400, v: ['1kg'] },
{ n: 'Papaya', p: 50, v: ['1pc'] },
{ n: 'Watermelon', p: 80, v: ['1pc'] },
{ n: 'Pomegranate', p: 150, v: ['500g', '1kg'] },
{ n: 'Pineapple', p: 70, v: ['1pc'] },
]);
addItems('Vegetables', [
{ n: 'Onions', p: 40, v: ['1kg', '5kg'] },
{ n: 'Tomatoes', p: 30, v: ['500g', '1kg'] },
{ n: 'Potatoes', p: 35, v: ['1kg', '5kg'] },
{ n: 'Carrots', p: 50, v: ['500g', '1kg'] },
{ n: 'Broccoli', p: 80, v: ['1pc'] },
{ n: 'Cauliflower', p: 40, v: ['1pc'] },
{ n: 'Spinach', p: 20, v: ['1bunch'] },
{ n: 'Cabbage', p: 30, v: ['1pc'] },
{ n: 'Capsicum Green', p: 60, v: ['500g'] },
{ n: 'Lady Finger', p: 40, v: ['500g'] },
]);
addItems('Dairy', [
{ n: 'Cow Milk', p: 50, v: ['500ml', '1L'] },
{ n: 'Buffalo Milk', p: 60, v: ['500ml', '1L'] },
{ n: 'Curd/Yogurt', p: 30, v: ['200g', '400g'] },
{ n: 'Paneer', p: 80, v: ['200g', '500g'] },
{ n: 'Cheese Slices', p: 120, v: ['200g'] },
{ n: 'Butter', p: 55, v: ['100g', '500g'] },
{ n: 'Ghee', p: 500, v: ['500ml', '1L'] },
{ n: 'Fresh Cream', p: 60, v: ['200ml'] },
]);
addItems('Grains & Rice', [
{ n: 'Basmati Rice', p: 150, v: ['1kg', '5kg'] },
{ n: 'Sona Masoori Rice', p: 60, v: ['5kg', '10kg'] },
{ n: 'Brown Rice', p: 90, v: ['1kg'] },
{ n: 'Whole Wheat Atta', p: 40, v: ['5kg', '10kg'] },
{ n: 'Multigrain Atta', p: 55, v: ['5kg'] },
{ n: 'Maida', p: 35, v: ['1kg'] },
{ n: 'Suji / Rava', p: 45, v: ['1kg'] },
{ n: 'Besan', p: 70, v: ['1kg'] },
{ n: 'Poha', p: 50, v: ['500g', '1kg'] },
{ n: 'Oats', p: 150, v: ['1kg'] },
]);
addItems('Pulses', [
{ n: 'Toor Dal', p: 160, v: ['500g', '1kg'] },
{ n: 'Moong Dal', p: 110, v: ['500g', '1kg'] },
{ n: 'Chana Dal', p: 90, v: ['500g', '1kg'] },
{ n: 'Urad Dal', p: 140, v: ['500g', '1kg'] },
{ n: 'Masoor Dal', p: 100, v: ['500g', '1kg'] },
{ n: 'Kabuli Chana', p: 130, v: ['500g', '1kg'] },
{ n: 'Rajma', p: 140, v: ['500g', '1kg'] },
{ n: 'Black Chana', p: 90, v: ['500g', '1kg'] },
]);
addItems('Oils & Spices', [
{ n: 'Sunflower Oil', p: 150, v: ['1L', '5L'] },
{ n: 'Mustard Oil', p: 180, v: ['1L', '5L'] },
{ n: 'Groundnut Oil', p: 200, v: ['1L', '5L'] },
{ n: 'Olive Oil', p: 800, v: ['500ml', '1L'] },
{ n: 'Turmeric Powder', p: 40, v: ['200g', '500g'] },
{ n: 'Red Chilli Powder', p: 50, v: ['200g', '500g'] },
{ n: 'Coriander Powder', p: 45, v: ['200g', '500g'] },
{ n: 'Cumin Seeds', p: 70, v: ['100g', '200g'] },
{ n: 'Mustard Seeds', p: 30, v: ['100g'] },
{ n: 'Garam Masala', p: 80, v: ['100g'] },
]);
addItems('Snacks', [
{ n: 'Potato Chips', p: 20, v: ['50g', '100g'] },
{ n: 'Nachos', p: 40, v: ['100g'] },
{ n: 'Roasted Peanuts', p: 50, v: ['200g'] },
{ n: 'Almonds', p: 250, v: ['250g', '500g'] },
{ n: 'Cashews', p: 300, v: ['250g', '500g'] },
{ n: 'Walnuts', p: 350, v: ['250g'] },
{ n: 'Raisins', p: 150, v: ['250g'] },
{ n: 'Dates', p: 200, v: ['500g'] },
]);
addItems('Beverages', [
{ n: 'Tea Leaves', p: 120, v: ['250g', '500g'] },
{ n: 'Green Tea Bags', p: 150, v: ['25pcs'] },
{ n: 'Instant Coffee', p: 180, v: ['50g', '100g'] },
{ n: 'Filter Coffee Powder', p: 140, v: ['250g'] },
{ n: 'Apple Juice', p: 110, v: ['1L'] },
{ n: 'Orange Juice', p: 110, v: ['1L'] },
{ n: 'Cola Soft Drink', p: 40, v: ['500ml', '2L'] },
{ n: 'Mineral Water', p: 20, v: ['1L', '5L'] },
]);
addItems('Daily Essentials', [
{ n: 'Toothpaste', p: 80, v: ['100g', '200g'] },
{ n: 'Bath Soap', p: 40, v: ['100g'] },
{ n: 'Shampoo', p: 150, v: ['200ml'] },
{ n: 'Dishwash Liquid', p: 60, v: ['250ml'] },
{ n: 'Detergent Powder', p: 120, v: ['1kg'] },
{ n: 'Floor Cleaner', p: 90, v: ['500ml'] },
{ n: 'Toilet Paper', p: 150, v: ['4rolls'] },
{ n: 'Garbage Bags', p: 60, v: ['30pcs'] },
]);

sql += `
DO $$
DECLARE
    cat_id UUID;
    prod_id UUID;
BEGIN
`;

catalog.forEach((item, i) => {
    sql += `
    SELECT id INTO cat_id FROM public.categories WHERE name = '${item.category}';
    
    INSERT INTO public.products (product_name, sku, category_id, price, quantity, image_url)
    VALUES (
        '${item.name.replace(/'/g, "''")}', 
        '${item.sku}', 
        cat_id, 
        ${item.price}, 
        100, 
        '${item.imgUrl}'
    ) RETURNING id INTO prod_id;
    `;
    
    item.variants.forEach((v, idx) => {
        sql += `
    INSERT INTO public.product_variants (product_id, sku, label, price, quantity)
    VALUES (prod_id, '${item.sku}-V${idx+1}', '${v}', ${item.price * (idx + 1)}, 50);
        `;
    });
});

sql += `\nEND $$;\n`;

fs.writeFileSync('massive_seeds.sql', sql);
console.log('Unsplash SQL generated!');
