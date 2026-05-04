import { useState } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { toast } from 'sonner';

const CATEGORIES = [
  'Fruits', 'Vegetables', 'Dairy', 'Grains & Rice', 'Pulses', 
  'Oils & Spices', 'Snacks', 'Beverages', 'Daily Essentials'
];

const generateCatalog = () => {
  const catalog: any[] = [];
  
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

  // 1. Fruits
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

  // 2. Vegetables
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

  // 3. Dairy
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

  // 4. Grains & Rice
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

  // 5. Pulses
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

  // 6. Oils & Spices
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

  // 7. Snacks
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

  // 8. Beverages
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

  // 9. Daily Essentials
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

  return catalog;
};

export default function SeedCatalogPage() {
  const [logs, setLogs] = useState<string[]>([]);
  const [running, setRunning] = useState(false);
  const [progress, setProgress] = useState({ current: 0, total: 0 });

  const log = (msg: string) => setLogs(p => [...p, msg]);

  const uploadImage = async (keyword: string, filename: string) => {
    try {
      const url = `https://loremflickr.com/500/500/${encodeURIComponent(keyword)},grocery/all`;
      const response = await fetch(url);
      if (!response.ok) throw new Error('Fetch failed');
      
      const blob = await response.blob();
      
      const { data, error } = await supabase.storage
        .from('product-images')
        .upload(`seed/${filename}.jpg`, blob, {
          contentType: 'image/jpeg',
          upsert: true
        });

      if (error) return null;
      
      const { data: publicData } = supabase.storage.from('product-images').getPublicUrl(`seed/${filename}.jpg`);
      return publicData.publicUrl;
    } catch (err) {
      return null;
    }
  };

  const startSeeding = async () => {
    setRunning(true);
    setLogs([]);
    log('🚀 Starting Grocery Catalog Seeding...');

    const { data: authUser } = await supabase.auth.getUser();
    if (!authUser.user) {
      log('❌ Authentication failed! You must be logged in as Admin to seed.');
      setRunning(false);
      return;
    }

    const { count } = await supabase.from('products').select('*', { count: 'exact', head: true });
    if (count && count > 0) {
      log(`⚠️ Seeding aborted: Found ${count} existing products. Database must be empty.`);
      setRunning(false);
      return;
    }

    log('📦 Inserting 9 Categories...');
    const categoryMap = new Map();
    for (const cat of CATEGORIES) {
      const { data, error } = await supabase.from('categories').insert({ name: cat }).select('id').single();
      if (!error && data) {
        categoryMap.set(cat, data.id);
      }
    }

    const items = generateCatalog();
    log(`🛒 Generated ${items.length} products. Proceeding to image fetch & insertion...`);
    setProgress({ current: 0, total: items.length });

    for (let i = 0; i < items.length; i++) {
      const item = items[i];
      const catId = categoryMap.get(item.category);
      if (!catId) continue;

      const imgUrl = await uploadImage(item.imgKeyword, item.sku);

      const { data: prodData, error: prodErr } = await supabase.from('products').insert({
        product_name: item.name,
        sku: item.sku,
        category_id: catId,
        price: item.price,
        quantity: 100,
        image_url: imgUrl || `https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80&w=500`
      }).select('id').single();

      if (!prodErr && prodData) {
        const variantsToInsert = item.variants.map((v: string, idx: number) => ({
          product_id: prodData.id,
          sku: `${item.sku}-V${idx+1}`,
          label: v,
          price: item.price * (idx + 1),
          quantity: 50
        }));

        if (variantsToInsert.length > 0) {
          await supabase.from('product_variants').insert(variantsToInsert);
        }
      }
      
      setProgress({ current: i + 1, total: items.length });
      log(`✅ Seeded: ${item.name} (${i + 1}/${items.length})`);
    }

    log('🌟 Golden Seeding Complete! 90+ Products, Categories, and Variants injected with Supabase Storage images!');
    toast.success('Seeding Complete');
    setRunning(false);
  };

  return (
    <div className="min-h-screen bg-slate-950 text-emerald-400 p-8 font-mono">
      <div className="max-w-4xl mx-auto space-y-6">
        <h1 className="text-3xl font-bold text-white">SYSTEM AUDIT SIMULATOR (SEEDING ENGINE)</h1>
        
        <div className="flex gap-4">
          <button 
            onClick={startSeeding} 
            disabled={running}
            className="px-6 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-500 disabled:opacity-50"
          >
            {running ? `Seeding... ${progress.current}/${progress.total}` : '🚀 RUN MASSIVE SEEDER'}
          </button>
        </div>

        <div className="bg-slate-900 p-6 rounded-xl border border-slate-800 h-[600px] overflow-y-auto">
          {logs.map((l, i) => (
            <div key={i} className="mb-2">[{new Date().toLocaleTimeString()}] {l}</div>
          ))}
          {logs.length === 0 && <div className="text-slate-500">Awaiting execution command...</div>}
        </div>
      </div>
    </div>
  );
}
