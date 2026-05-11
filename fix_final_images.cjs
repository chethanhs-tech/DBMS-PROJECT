require("dotenv").config();
const { createClient } = require("@supabase/supabase-js");

const s = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_PUBLISHABLE_KEY);
const delay = ms => new Promise(res => setTimeout(res, ms));

async function run() {
  await s.auth.signInWithPassword({ email: "admin@grozosphere.com", password: "Admin@123" });
  
  // Find products that have placeholders, blank images, or known mismatches
  const { data: products } = await s.from("products").select("id, product_name, image_url");
  
  const badMismatches = ["Kabuli Chana", "Semolina (Suji)"]; // From the screenshot
  const toFix = products.filter(p => 
    !p.image_url || 
    p.image_url.includes("placehold.co") || 
    p.image_url.includes("pollinations.ai") ||
    badMismatches.some(m => p.product_name.includes(m))
  );
  
  console.log(`Found ${toFix.length} products that need perfect AI images.`);
  
  for (let i = 0; i < toFix.length; i++) {
    const p = toFix[i];
    console.log(`[${i+1}/${toFix.length}] Generating perfect image for: ${p.product_name}...`);
    
    try {
      const prompt = `A highly realistic, professional studio photograph of a grocery product: ${p.product_name}. The product should be clearly visible in the center, isolated on a pure white background. Ultra-detailed, 4k resolution, photorealistic packaging.`;
      const aiUrl = `https://image.pollinations.ai/prompt/${encodeURIComponent(prompt)}?width=600&height=600&nologo=true&seed=${Math.floor(Math.random()*10000)}&model=flux`;
      
      const res = await fetch(aiUrl);
      if (!res.ok) throw new Error(`HTTP ${res.status}`);
      
      const arrayBuffer = await res.arrayBuffer();
      const buffer = Buffer.from(arrayBuffer);
      
      const fileName = `perfect-${Date.now()}-${p.id}.jpg`;
      const { error: uploadError } = await s.storage
        .from("product-images")
        .upload(fileName, buffer, { contentType: "image/jpeg", upsert: true });
        
      if (uploadError) throw uploadError;
      
      const { data: { publicUrl } } = s.storage.from("product-images").getPublicUrl(fileName);
      await s.from("products").update({ image_url: publicUrl }).eq("id", p.id);
      
      console.log(`✅ Success! Uploaded to Supabase.`);
      await delay(2000); // 2 second delay to prevent rate limits
    } catch (e) {
      console.log(`❌ Failed for ${p.product_name}: ${e.message}`);
      await delay(5000); // Backoff on failure
    }
  }
  console.log("All done!");
}
run();
