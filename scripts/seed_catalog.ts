import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
import { resolve } from 'path';

// Load .env
dotenv.config({ path: resolve(process.cwd(), '.env') });

const SUPABASE_URL = process.env.VITE_SUPABASE_URL;
const SUPABASE_KEY = process.env.VITE_SUPABASE_PUBLISHABLE_KEY; // Requires RLS bypass or Admin privileges if RLS is on

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('❌ Missing Supabase credentials in .env');
  process.exit(1);
}

// Since we are running outside the browser, we use the anon key. 
// However, Admin seeding requires either Service Role Key or logging in as Admin.
// We will authenticate as the default admin we seeded earlier!
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY, {
  auth: { persistSession: false }
});

const CATEGORIES = [
  'Fruits', 'Vegetables', 'Dairy', 'Grains & Rice', 'Pulses', 
  'Oils & Spices', 'Snacks', 'Beverages', 'Daily Essentials'
];

// Helper to generate a massive array of 120 items
const generateCatalog = () => {
  const catalog = [];
  
  const addItems = (cat: string, items: {n: string, p: number, v: string[], imgKeyword: string}[]) => {
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

  // 1. Fruits (15 items)
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
    { n: 'Kiwi', p: 120, v: ['3pcs'], imgKeyword: 'kiwi,fruit' },
    { n: 'Strawberries', p: 200, v: ['200g'], imgKeyword: 'strawberry,fruit' },
    { n: 'Blueberries', p: 250, v: ['125g'], imgKeyword: 'blueberry,fruit' },
    { n: 'Dragon Fruit', p: 100, v: ['1pc'], imgKeyword: 'dragonfruit' },
    { n: 'Avocado', p: 150, v: ['1pc'], imgKeyword: 'avocado,fruit' },
  ]);

  // 2. Vegetables (20 items)
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
    { n: 'Bottle Gourd', p: 30, v: ['1pc'], imgKeyword: 'bottlegourd,vegetable' },
    { n: 'Bitter Gourd', p: 45, v: ['500g'], imgKeyword: 'bittergourd,vegetable' },
    { n: 'Cucumber', p: 30, v: ['500g', '1kg'], imgKeyword: 'cucumber,vegetable' },
    { n: 'Green Peas', p: 80, v: ['500g'], imgKeyword: 'peas,vegetable' },
    { n: 'Garlic', p: 120, v: ['200g'], imgKeyword: 'garlic,vegetable' },
    { n: 'Ginger', p: 80, v: ['200g'], imgKeyword: 'ginger,vegetable' },
    { n: 'Green Chillies', p: 40, v: ['100g'], imgKeyword: 'greenchili,vegetable' },
    { n: 'Coriander Leaves', p: 15, v: ['1bunch'], imgKeyword: 'coriander,vegetable' },
    { n: 'Mint Leaves', p: 15, v: ['1bunch'], imgKeyword: 'mint,vegetable' },
    { n: 'Lemon', p: 50, v: ['250g'], imgKeyword: 'lemon,vegetable' },
  ]);

  // 3. Dairy (10 items)
  addItems('Dairy', [
    { n: 'Cow Milk', p: 50, v: ['500ml', '1L'], imgKeyword: 'milk,dairy' },
    { n: 'Buffalo Milk', p: 60, v: ['500ml', '1L'], imgKeyword: 'milk,glass' },
    { n: 'Curd/Yogurt', p: 30, v: ['200g', '400g'], imgKeyword: 'yogurt,dairy' },
    { n: 'Paneer', p: 80, v: ['200g', '500g'], imgKeyword: 'paneer,dairy' },
    { n: 'Cheese Slices', p: 120, v: ['200g'], imgKeyword: 'cheese,slice' },
    { n: 'Butter', p: 55, v: ['100g', '500g'], imgKeyword: 'butter,dairy' },
    { n: 'Ghee', p: 500, v: ['500ml', '1L'], imgKeyword: 'ghee,dairy' },
    { n: 'Fresh Cream', p: 60, v: ['200ml'], imgKeyword: 'cream,dairy' },
    { n: 'Flavored Milk', p: 35, v: ['200ml'], imgKeyword: 'flavoredmilk' },
    { n: 'Buttermilk', p: 15, v: ['200ml'], imgKeyword: 'buttermilk' },
  ]);

  // 4. Grains & Rice (10 items)
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

  // 5. Pulses (10 items)
  addItems('Pulses', [
    { n: 'Toor Dal', p: 160, v: ['500g', '1kg'], imgKeyword: 'toordal,pulse' },
    { n: 'Moong Dal', p: 110, v: ['500g', '1kg'], imgKeyword: 'moongdal' },
    { n: 'Chana Dal', p: 90, v: ['500g', '1kg'], imgKeyword: 'chanadal' },
    { n: 'Urad Dal', p: 140, v: ['500g', '1kg'], imgKeyword: 'uraddal' },
    { n: 'Masoor Dal', p: 100, v: ['500g', '1kg'], imgKeyword: 'masoordal' },
    { n: 'Kabuli Chana', p: 130, v: ['500g', '1kg'], imgKeyword: 'chickpeas' },
    { n: 'Rajma', p: 140, v: ['500g', '1kg'], imgKeyword: 'rajma,beans' },
    { n: 'Black Chana', p: 90, v: ['500g', '1kg'], imgKeyword: 'blackchana' },
    { n: 'Lobia', p: 110, v: ['500g'], imgKeyword: 'blackeyedpeas' },
    { n: 'Green Moong', p: 120, v: ['500g', '1kg'], imgKeyword: 'greenmoong' },
  ]);

  // 6. Oils & Spices (20 items)
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
    { n: 'Black Pepper', p: 120, v: ['100g'], imgKeyword: 'blackpepper' },
    { n: 'Cloves', p: 150, v: ['50g'], imgKeyword: 'cloves,spice' },
    { n: 'Cardamom', p: 300, v: ['50g'], imgKeyword: 'cardamom' },
    { n: 'Cinnamon', p: 60, v: ['50g'], imgKeyword: 'cinnamon' },
    { n: 'Bay Leaves', p: 20, v: ['50g'], imgKeyword: 'bayleaves' },
    { n: 'Salt', p: 25, v: ['1kg'], imgKeyword: 'salt' },
    { n: 'Rock Salt', p: 40, v: ['1kg'], imgKeyword: 'rocksalt' },
    { n: 'Sugar', p: 45, v: ['1kg', '5kg'], imgKeyword: 'sugar' },
    { n: 'Jaggery', p: 60, v: ['1kg'], imgKeyword: 'jaggery' },
    { n: 'Honey', p: 150, v: ['500g'], imgKeyword: 'honey' },
  ]);

  // 7. Snacks (15 items)
  addItems('Snacks', [
    { n: 'Potato Chips', p: 20, v: ['50g', '100g'], imgKeyword: 'potatochips' },
    { n: 'Nachos', p: 40, v: ['100g'], imgKeyword: 'nachos' },
    { n: 'Roasted Peanuts', p: 50, v: ['200g'], imgKeyword: 'roastedpeanuts' },
    { n: 'Almonds', p: 250, v: ['250g', '500g'], imgKeyword: 'almonds' },
    { n: 'Cashews', p: 300, v: ['250g', '500g'], imgKeyword: 'cashews' },
    { n: 'Walnuts', p: 350, v: ['250g'], imgKeyword: 'walnuts' },
    { n: 'Raisins', p: 150, v: ['250g'], imgKeyword: 'raisins' },
    { n: 'Dates', p: 200, v: ['500g'], imgKeyword: 'dates,fruit' },
    { n: 'Biscuits - Digestive', p: 30, v: ['200g'], imgKeyword: 'biscuits' },
    { n: 'Chocolate Chip Cookies', p: 50, v: ['150g'], imgKeyword: 'chocolatecookies' },
    { n: 'Namkeen Bhujia', p: 45, v: ['200g'], imgKeyword: 'namkeen' },
    { n: 'Popcorn Kernels', p: 60, v: ['250g'], imgKeyword: 'popcorn' },
    { n: 'Instant Noodles', p: 15, v: ['70g', '280g'], imgKeyword: 'instantnoodles' },
    { n: 'Pasta', p: 45, v: ['500g'], imgKeyword: 'pasta' },
    { n: 'Dark Chocolate', p: 100, v: ['100g'], imgKeyword: 'darkchocolate' },
  ]);

  // 8. Beverages (10 items)
  addItems('Beverages', [
    { n: 'Tea Leaves', p: 120, v: ['250g', '500g'], imgKeyword: 'tealeaves' },
    { n: 'Green Tea Bags', p: 150, v: ['25pcs'], imgKeyword: 'greentea' },
    { n: 'Instant Coffee', p: 180, v: ['50g', '100g'], imgKeyword: 'instantcoffee' },
    { n: 'Filter Coffee Powder', p: 140, v: ['250g'], imgKeyword: 'filtercoffee' },
    { n: 'Apple Juice', p: 110, v: ['1L'], imgKeyword: 'applejuice' },
    { n: 'Orange Juice', p: 110, v: ['1L'], imgKeyword: 'orangejuice' },
    { n: 'Cola Soft Drink', p: 40, v: ['500ml', '2L'], imgKeyword: 'cola' },
    { n: 'Mineral Water', p: 20, v: ['1L', '5L'], imgKeyword: 'mineralwater' },
    { n: 'Energy Drink', p: 110, v: ['250ml'], imgKeyword: 'energydrink' },
    { n: 'Soy Milk', p: 90, v: ['1L'], imgKeyword: 'soymilk' },
  ]);

  // 9. Daily Essentials (10 items)
  addItems('Daily Essentials', [
    { n: 'Toothpaste', p: 80, v: ['100g', '200g'], imgKeyword: 'toothpaste' },
    { n: 'Bath Soap', p: 40, v: ['100g'], imgKeyword: 'soap' },
    { n: 'Shampoo', p: 150, v: ['200ml'], imgKeyword: 'shampoo' },
    { n: 'Dishwash Liquid', p: 60, v: ['250ml'], imgKeyword: 'dishwash' },
    { n: 'Detergent Powder', p: 120, v: ['1kg'], imgKeyword: 'detergent' },
    { n: 'Floor Cleaner', p: 90, v: ['500ml'], imgKeyword: 'floorcleaner' },
    { n: 'Toilet Paper', p: 150, v: ['4rolls'], imgKeyword: 'toiletpaper' },
    { n: 'Garbage Bags', p: 60, v: ['30pcs'], imgKeyword: 'garbagebags' },
    { n: 'Hand Wash', p: 85, v: ['250ml'], imgKeyword: 'handwash' },
    { n: 'Matchboxes', p: 10, v: ['10pcs'], imgKeyword: 'matchbox' },
  ]);

  return catalog;
};

async function uploadImage(keyword: string, filename: string): Promise<string | null> {
  try {
    const url = `https://loremflickr.com/500/500/${encodeURIComponent(keyword)},grocery/all`;
    const response = await fetch(url);
    if (!response.ok) throw new Error(`Failed to fetch image for ${keyword}`);
    
    const arrayBuffer = await response.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    const { data, error } = await supabase.storage
      .from('product-images')
      .upload(`seed/${filename}.jpg`, buffer, {
        contentType: 'image/jpeg',
        upsert: true
      });

    if (error) {
      console.warn(`Storage upload failed for ${keyword}:`, error.message);
      return null;
    }

    const { data: publicData } = supabase.storage.from('product-images').getPublicUrl(`seed/${filename}.jpg`);
    return publicData.publicUrl;
  } catch (err) {
    console.warn(`Failed image logic for ${keyword}`);
    return null;
  }
}

async function run() {
  console.log('🚀 Starting Grocery Catalog Seeding...');

  // Authenticate as Admin to bypass RLS
  const { error: authError } = await supabase.auth.signInWithPassword({
    email: 'admin@grozosphere.com',
    password: 'Admin@123'
  });

  if (authError) {
    console.error('❌ Authentication failed! Ensure the database is built and Admin exists.');
    process.exit(1);
  }

  // 1. Check if products exist
  const { count } = await supabase.from('products').select('*', { count: 'exact', head: true });
  if (count && count > 0) {
    console.log(`⚠️ Seeding aborted: Found ${count} existing products. Database must be empty to seed.`);
    process.exit(0);
  }

  // 2. Insert Categories
  console.log('📦 Inserting 9 Categories...');
  const categoryMap = new Map();
  for (const cat of CATEGORIES) {
    const { data, error } = await supabase.from('categories').insert({ name: cat }).select('id').single();
    if (error) {
      console.error('Category insert failed:', error);
      continue;
    }
    categoryMap.set(cat, data.id);
  }

  // 3. Process Products
  const items = generateCatalog();
  console.log(`🛒 Generated ${items.length} products. Proceeding to image fetch & insertion...`);
  
  // Note: Uploading 120 images sequentially takes time. We will batch them in chunks of 10.
  const CHUNK_SIZE = 10;
  for (let i = 0; i < items.length; i += CHUNK_SIZE) {
    const chunk = items.slice(i, i + CHUNK_SIZE);
    console.log(`⏳ Processing batch ${Math.floor(i/CHUNK_SIZE)+1} of ${Math.ceil(items.length/CHUNK_SIZE)}...`);
    
    await Promise.all(chunk.map(async (item) => {
      const catId = categoryMap.get(item.category);
      if (!catId) return;

      const imgUrl = await uploadImage(item.imgKeyword, item.sku);

      // Insert product
      const { data: prodData, error: prodErr } = await supabase.from('products').insert({
        product_name: item.name,
        sku: item.sku,
        category_id: catId,
        price: item.price,
        quantity: 100, // Default stock
        image_url: imgUrl || `https://via.placeholder.com/500?text=${encodeURIComponent(item.name)}`
      }).select('id').single();

      if (prodErr) {
        console.error(`Error inserting product ${item.name}:`, prodErr.message);
        return;
      }

      // Insert variants
      const variantsToInsert = item.variants.map((v, idx) => ({
        product_id: prodData.id,
        sku: `${item.sku}-V${idx+1}`,
        label: v,
        price: item.price * (idx + 1), // Simplistic mock pricing scaling
        quantity: 50
      }));

      if (variantsToInsert.length > 0) {
        await supabase.from('product_variants').insert(variantsToInsert);
      }
    }));
  }

  console.log('✅ Golden Seeding Complete! 120+ Products, Categories, and Variants injected with Supabase Storage images!');
}

run();
