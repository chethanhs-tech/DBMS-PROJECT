const fs = require('fs');

const CATEGORIES = [
  'Fruits', 'Vegetables', 'Dairy', 'Grains & Rice', 'Pulses', 
  'Oils & Spices', 'Snacks', 'Beverages', 'Daily Essentials'
];

let sql = `-- Massive 120 Item Seeding Script with Perfect AI Generated Product Images\n\n`;

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
    
    // Create a highly optimized prompt for the AI image generator
    const prompt = `A highly detailed professional grocery photography of ${item.n}, clean studio lighting, realistic, 4k`;
    const encodedPrompt = encodeURIComponent(prompt);
    // Pollinations generates the image instantly based on the URL path
    const aiImageUrl = `https://image.pollinations.ai/prompt/${encodedPrompt}?width=500&height=500&nologo=true&seed=${Math.floor(Math.random() * 1000)}`;
    
    catalog.push({
    category: cat,
    name: item.n,
    price: item.p,
    sku: `${cat.substring(0,3).toUpperCase()}-${Math.floor(Math.random()*10000)}-${i}`,
    variants: item.v,
    imgUrl: aiImageUrl
    });
});
};

addItems('Fruits', [
{ n: 'Fresh Apples', p: 120, v: ['500g', '1kg'] },
{ n: 'Ripe Bananas', p: 60, v: ['500g', '1kg'] },
{ n: 'Oranges', p: 80, v: ['500g', '1kg'] },
{ n: 'Green Grapes', p: 90, v: ['500g'] },
{ n: 'Black Grapes', p: 100, v: ['500g'] },
{ n: 'Alphonso Mango', p: 400, v: ['1kg'] },
{ n: 'Papaya', p: 50, v: ['1pc'] },
{ n: 'Watermelon', p: 80, v: ['1pc'] },
{ n: 'Pomegranate', p: 150, v: ['500g', '1kg'] },
{ n: 'Pineapple', p: 70, v: ['1pc'] },
]);
addItems('Vegetables', [
{ n: 'Red Onions', p: 40, v: ['1kg', '5kg'] },
{ n: 'Red Tomatoes', p: 30, v: ['500g', '1kg'] },
{ n: 'Potatoes', p: 35, v: ['1kg', '5kg'] },
{ n: 'Fresh Carrots', p: 50, v: ['500g', '1kg'] },
{ n: 'Broccoli', p: 80, v: ['1pc'] },
{ n: 'Cauliflower', p: 40, v: ['1pc'] },
{ n: 'Fresh Spinach', p: 20, v: ['1bunch'] },
{ n: 'Cabbage', p: 30, v: ['1pc'] },
{ n: 'Green Capsicum', p: 60, v: ['500g'] },
{ n: 'Okra Lady Finger', p: 40, v: ['500g'] },
]);
addItems('Dairy', [
{ n: 'Glass of Cow Milk', p: 50, v: ['500ml', '1L'] },
{ n: 'Bottle of Buffalo Milk', p: 60, v: ['500ml', '1L'] },
{ n: 'Bowl of Fresh Yogurt', p: 30, v: ['200g', '400g'] },
{ n: 'Cubes of Paneer', p: 80, v: ['200g', '500g'] },
{ n: 'Cheese Slices', p: 120, v: ['200g'] },
{ n: 'Block of Butter', p: 55, v: ['100g', '500g'] },
{ n: 'Jar of Clarified Butter Ghee', p: 500, v: ['500ml', '1L'] },
{ n: 'Bowl of Fresh Cream', p: 60, v: ['200ml'] },
]);
addItems('Grains & Rice', [
{ n: 'Basmati Rice', p: 150, v: ['1kg', '5kg'] },
{ n: 'Sona Masoori Rice', p: 60, v: ['5kg', '10kg'] },
{ n: 'Brown Rice', p: 90, v: ['1kg'] },
{ n: 'Whole Wheat Flour', p: 40, v: ['5kg', '10kg'] },
{ n: 'Multigrain Flour', p: 55, v: ['5kg'] },
{ n: 'Refined Wheat Flour Maida', p: 35, v: ['1kg'] },
{ n: 'Semolina Suji', p: 45, v: ['1kg'] },
{ n: 'Gram Flour Besan', p: 70, v: ['1kg'] },
{ n: 'Flattened Rice Poha', p: 50, v: ['500g', '1kg'] },
{ n: 'Rolled Oats', p: 150, v: ['1kg'] },
]);
addItems('Pulses', [
{ n: 'Yellow Pigeon Peas Toor Dal', p: 160, v: ['500g', '1kg'] },
{ n: 'Yellow Lentils Moong Dal', p: 110, v: ['500g', '1kg'] },
{ n: 'Split Chickpeas Chana Dal', p: 90, v: ['500g', '1kg'] },
{ n: 'Black Gram Urad Dal', p: 140, v: ['500g', '1kg'] },
{ n: 'Red Lentils Masoor Dal', p: 100, v: ['500g', '1kg'] },
{ n: 'White Chickpeas', p: 130, v: ['500g', '1kg'] },
{ n: 'Red Kidney Beans Rajma', p: 140, v: ['500g', '1kg'] },
{ n: 'Black Chickpeas', p: 90, v: ['500g', '1kg'] },
]);
addItems('Oils & Spices', [
{ n: 'Bottle of Sunflower Oil', p: 150, v: ['1L', '5L'] },
{ n: 'Bottle of Mustard Oil', p: 180, v: ['1L', '5L'] },
{ n: 'Bottle of Peanut Oil', p: 200, v: ['1L', '5L'] },
{ n: 'Bottle of Olive Oil', p: 800, v: ['500ml', '1L'] },
{ n: 'Turmeric Powder in a bowl', p: 40, v: ['200g', '500g'] },
{ n: 'Red Chilli Powder in a bowl', p: 50, v: ['200g', '500g'] },
{ n: 'Coriander Powder in a bowl', p: 45, v: ['200g', '500g'] },
{ n: 'Cumin Seeds', p: 70, v: ['100g', '200g'] },
{ n: 'Black Mustard Seeds', p: 30, v: ['100g'] },
{ n: 'Garam Masala Spice Mix', p: 80, v: ['100g'] },
]);
addItems('Snacks', [
{ n: 'Bag of Potato Chips', p: 20, v: ['50g', '100g'] },
{ n: 'Nachos with cheese', p: 40, v: ['100g'] },
{ n: 'Roasted Salted Peanuts', p: 50, v: ['200g'] },
{ n: 'Raw Almonds', p: 250, v: ['250g', '500g'] },
{ n: 'Raw Cashew Nuts', p: 300, v: ['250g', '500g'] },
{ n: 'Shelled Walnuts', p: 350, v: ['250g'] },
{ n: 'Sweet Raisins', p: 150, v: ['250g'] },
{ n: 'Sweet Dates', p: 200, v: ['500g'] },
]);
addItems('Beverages', [
{ n: 'Loose Black Tea Leaves', p: 120, v: ['250g', '500g'] },
{ n: 'Green Tea Bags', p: 150, v: ['25pcs'] },
{ n: 'Instant Coffee Powder', p: 180, v: ['50g', '100g'] },
{ n: 'Filter Coffee Powder', p: 140, v: ['250g'] },
{ n: 'Glass of Apple Juice', p: 110, v: ['1L'] },
{ n: 'Glass of Orange Juice', p: 110, v: ['1L'] },
{ n: 'Bottle of Cola Soft Drink', p: 40, v: ['500ml', '2L'] },
{ n: 'Bottle of Mineral Water', p: 20, v: ['1L', '5L'] },
]);
addItems('Daily Essentials', [
{ n: 'Tube of Toothpaste', p: 80, v: ['100g', '200g'] },
{ n: 'Bar of Bath Soap', p: 40, v: ['100g'] },
{ n: 'Bottle of Hair Shampoo', p: 150, v: ['200ml'] },
{ n: 'Bottle of Dishwash Liquid', p: 60, v: ['250ml'] },
{ n: 'Laundry Detergent Powder', p: 120, v: ['1kg'] },
{ n: 'Bottle of Floor Cleaner', p: 90, v: ['500ml'] },
{ n: 'Roll of Toilet Paper', p: 150, v: ['4rolls'] },
{ n: 'Roll of Garbage Bags', p: 60, v: ['30pcs'] },
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
console.log('AI Image SQL generated!');
