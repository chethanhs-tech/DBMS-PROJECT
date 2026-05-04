const fs = require('fs');

const CATEGORIES = [
  'Fruits', 'Vegetables', 'Dairy', 'Grains & Rice', 'Pulses', 
  'Oils & Spices', 'Snacks', 'Beverages', 'Daily Essentials'
];

let sql = `-- Massive 120 Item Seeding Script\n\n`;

const genId = () => 'gen_random_uuid()';

sql += `-- Insert Categories\n`;
CATEGORIES.forEach(cat => {
    sql += `INSERT INTO public.categories (name) VALUES ('${cat}') ON CONFLICT (name) DO NOTHING;\n`;
});

sql += `\n-- Insert Products\n`;

const catalog = [];
const addItems = (cat, items) => {
items.forEach((item, i) => {
    catalog.push({
    category: cat,
    name: item.n,
    price: item.p,
    sku: `${cat.substring(0,3).toUpperCase()}-${Math.floor(Math.random()*10000)}-${i}`,
    variants: item.v,
    imgKeyword: item.imgKeyword
    });
});
};

addItems('Fruits', [
{ n: 'Fresh Apples', p: 120, v: ['500g', '1kg'], imgKeyword: 'apple,fruit' },
{ n: 'Ripe Bananas', p: 60, v: ['500g', '1kg'], imgKeyword: 'banana,fruit' },
{ n: 'Oranges', p: 80, v: ['500g', '1kg'], imgKeyword: 'orange,fruit' },
{ n: 'Grapes Green', p: 90, v: ['500g'], imgKeyword: 'grapes,fruit' },
{ n: 'Grapes Black', p: 100, v: ['500g'], imgKeyword: 'blackgrapes,fruit' },
{ n: 'Mango Alphonso', p: 400, v: ['1kg'], imgKeyword: 'mango,fruit' },
{ n: 'Papaya', p: 50, v: ['1pc'], imgKeyword: 'papaya,fruit' },
{ n: 'Watermelon', p: 80, v: ['1pc'], imgKeyword: 'watermelon,fruit' },
{ n: 'Pomegranate', p: 150, v: ['500g', '1kg'], imgKeyword: 'pomegranate,fruit' },
{ n: 'Pineapple', p: 70, v: ['1pc'], imgKeyword: 'pineapple,fruit' },
]);
addItems('Vegetables', [
{ n: 'Onions', p: 40, v: ['1kg', '5kg'], imgKeyword: 'onion,vegetable' },
{ n: 'Tomatoes', p: 30, v: ['500g', '1kg'], imgKeyword: 'tomato,vegetable' },
{ n: 'Potatoes', p: 35, v: ['1kg', '5kg'], imgKeyword: 'potato,vegetable' },
{ n: 'Carrots', p: 50, v: ['500g', '1kg'], imgKeyword: 'carrot,vegetable' },
{ n: 'Broccoli', p: 80, v: ['1pc'], imgKeyword: 'broccoli,vegetable' },
{ n: 'Cauliflower', p: 40, v: ['1pc'], imgKeyword: 'cauliflower,vegetable' },
{ n: 'Spinach', p: 20, v: ['1bunch'], imgKeyword: 'spinach,vegetable' },
{ n: 'Cabbage', p: 30, v: ['1pc'], imgKeyword: 'cabbage,vegetable' },
{ n: 'Capsicum Green', p: 60, v: ['500g'], imgKeyword: 'capsicum,vegetable' },
{ n: 'Lady Finger', p: 40, v: ['500g'], imgKeyword: 'okra,vegetable' },
]);
addItems('Dairy', [
{ n: 'Cow Milk', p: 50, v: ['500ml', '1L'], imgKeyword: 'milk,dairy' },
{ n: 'Buffalo Milk', p: 60, v: ['500ml', '1L'], imgKeyword: 'milk,glass' },
{ n: 'Curd/Yogurt', p: 30, v: ['200g', '400g'], imgKeyword: 'yogurt,dairy' },
{ n: 'Paneer', p: 80, v: ['200g', '500g'], imgKeyword: 'paneer,dairy' },
{ n: 'Cheese Slices', p: 120, v: ['200g'], imgKeyword: 'cheese,slice' },
{ n: 'Butter', p: 55, v: ['100g', '500g'], imgKeyword: 'butter,dairy' },
{ n: 'Ghee', p: 500, v: ['500ml', '1L'], imgKeyword: 'ghee,dairy' },
{ n: 'Fresh Cream', p: 60, v: ['200ml'], imgKeyword: 'cream,dairy' },
]);
addItems('Grains & Rice', [
{ n: 'Basmati Rice', p: 150, v: ['1kg', '5kg'], imgKeyword: 'basmatirice' },
{ n: 'Sona Masoori Rice', p: 60, v: ['5kg', '10kg'], imgKeyword: 'rice,grain' },
{ n: 'Brown Rice', p: 90, v: ['1kg'], imgKeyword: 'brownrice' },
{ n: 'Whole Wheat Atta', p: 40, v: ['5kg', '10kg'], imgKeyword: 'wheatflour' },
{ n: 'Multigrain Atta', p: 55, v: ['5kg'], imgKeyword: 'multigrainflour' },
{ n: 'Maida', p: 35, v: ['1kg'], imgKeyword: 'maida,flour' },
{ n: 'Suji / Rava', p: 45, v: ['1kg'], imgKeyword: 'suji,semolina' },
{ n: 'Besan', p: 70, v: ['1kg'], imgKeyword: 'besan,flour' },
{ n: 'Poha', p: 50, v: ['500g', '1kg'], imgKeyword: 'poha,rice' },
{ n: 'Oats', p: 150, v: ['1kg'], imgKeyword: 'oats,grain' },
]);
addItems('Pulses', [
{ n: 'Toor Dal', p: 160, v: ['500g', '1kg'], imgKeyword: 'toordal,pulse' },
{ n: 'Moong Dal', p: 110, v: ['500g', '1kg'], imgKeyword: 'moongdal' },
{ n: 'Chana Dal', p: 90, v: ['500g', '1kg'], imgKeyword: 'chanadal' },
{ n: 'Urad Dal', p: 140, v: ['500g', '1kg'], imgKeyword: 'uraddal' },
{ n: 'Masoor Dal', p: 100, v: ['500g', '1kg'], imgKeyword: 'masoordal' },
{ n: 'Kabuli Chana', p: 130, v: ['500g', '1kg'], imgKeyword: 'chickpeas' },
{ n: 'Rajma', p: 140, v: ['500g', '1kg'], imgKeyword: 'rajma,beans' },
{ n: 'Black Chana', p: 90, v: ['500g', '1kg'], imgKeyword: 'blackchana' },
]);
addItems('Oils & Spices', [
{ n: 'Sunflower Oil', p: 150, v: ['1L', '5L'], imgKeyword: 'sunfloweroil' },
{ n: 'Mustard Oil', p: 180, v: ['1L', '5L'], imgKeyword: 'mustardoil' },
{ n: 'Groundnut Oil', p: 200, v: ['1L', '5L'], imgKeyword: 'peanutoil' },
{ n: 'Olive Oil', p: 800, v: ['500ml', '1L'], imgKeyword: 'oliveoil' },
{ n: 'Turmeric Powder', p: 40, v: ['200g', '500g'], imgKeyword: 'turmericpowder' },
{ n: 'Red Chilli Powder', p: 50, v: ['200g', '500g'], imgKeyword: 'chillipowder' },
{ n: 'Coriander Powder', p: 45, v: ['200g', '500g'], imgKeyword: 'corianderpowder' },
{ n: 'Cumin Seeds', p: 70, v: ['100g', '200g'], imgKeyword: 'cuminseeds' },
{ n: 'Mustard Seeds', p: 30, v: ['100g'], imgKeyword: 'mustardseeds' },
{ n: 'Garam Masala', p: 80, v: ['100g'], imgKeyword: 'garammasala' },
]);
addItems('Snacks', [
{ n: 'Potato Chips', p: 20, v: ['50g', '100g'], imgKeyword: 'potatochips' },
{ n: 'Nachos', p: 40, v: ['100g'], imgKeyword: 'nachos' },
{ n: 'Roasted Peanuts', p: 50, v: ['200g'], imgKeyword: 'roastedpeanuts' },
{ n: 'Almonds', p: 250, v: ['250g', '500g'], imgKeyword: 'almonds' },
{ n: 'Cashews', p: 300, v: ['250g', '500g'], imgKeyword: 'cashews' },
{ n: 'Walnuts', p: 350, v: ['250g'], imgKeyword: 'walnuts' },
{ n: 'Raisins', p: 150, v: ['250g'], imgKeyword: 'raisins' },
{ n: 'Dates', p: 200, v: ['500g'], imgKeyword: 'dates,fruit' },
]);
addItems('Beverages', [
{ n: 'Tea Leaves', p: 120, v: ['250g', '500g'], imgKeyword: 'tealeaves' },
{ n: 'Green Tea Bags', p: 150, v: ['25pcs'], imgKeyword: 'greentea' },
{ n: 'Instant Coffee', p: 180, v: ['50g', '100g'], imgKeyword: 'instantcoffee' },
{ n: 'Filter Coffee Powder', p: 140, v: ['250g'], imgKeyword: 'filtercoffee' },
{ n: 'Apple Juice', p: 110, v: ['1L'], imgKeyword: 'applejuice' },
{ n: 'Orange Juice', p: 110, v: ['1L'], imgKeyword: 'orangejuice' },
{ n: 'Cola Soft Drink', p: 40, v: ['500ml', '2L'], imgKeyword: 'cola' },
{ n: 'Mineral Water', p: 20, v: ['1L', '5L'], imgKeyword: 'mineralwater' },
]);
addItems('Daily Essentials', [
{ n: 'Toothpaste', p: 80, v: ['100g', '200g'], imgKeyword: 'toothpaste' },
{ n: 'Bath Soap', p: 40, v: ['100g'], imgKeyword: 'soap' },
{ n: 'Shampoo', p: 150, v: ['200ml'], imgKeyword: 'shampoo' },
{ n: 'Dishwash Liquid', p: 60, v: ['250ml'], imgKeyword: 'dishwash' },
{ n: 'Detergent Powder', p: 120, v: ['1kg'], imgKeyword: 'detergent' },
{ n: 'Floor Cleaner', p: 90, v: ['500ml'], imgKeyword: 'floorcleaner' },
{ n: 'Toilet Paper', p: 150, v: ['4rolls'], imgKeyword: 'toiletpaper' },
{ n: 'Garbage Bags', p: 60, v: ['30pcs'], imgKeyword: 'garbagebags' },
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
        'https://loremflickr.com/500/500/${encodeURIComponent(item.imgKeyword)},grocery/all'
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
console.log('SQL generated!');
