require("dotenv").config();
const { createClient } = require("@supabase/supabase-js");
const fs = require("fs");
const path = require("path");

const s = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_PUBLISHABLE_KEY);

const mappings = [
  { name: "Kabuli Chana (Chickpeas)", file: "kabuli_chana_product_1778505735746.png" },
  { name: "Chikoo (Sapota)", file: "chikoo_product_1778505749879.png" },
  { name: "Yam (Suran)", file: "yam_suran_product_1778505764344.png" },
  { name: "Processed Cheese Slices", file: "processed_cheese_product_1778505777648.png" },
  { name: "Red Rice", file: "red_rice_product_1778505792314.png" },
  { name: "Masoor Dal (Red)", file: "masoor_dal_product_1778505807867.png" },
  { name: "Semolina (Suji)", file: "semolina_suji_product_1778505823593.png" }
];

async function run() {
  await s.auth.signInWithPassword({ email: "admin@grozosphere.com", password: "Admin@123" });
  const artifactDir = "/Users/chethanhs/.gemini/antigravity/brain/74a6c7d5-cd99-4d39-bc0c-fb810e66e3a4";
  
  for (const m of mappings) {
    try {
      const filePath = path.join(artifactDir, m.file);
      const buffer = fs.readFileSync(filePath);
      
      const fileName = `manual-${Date.now()}-${m.file}`;
      await s.storage.from("product-images").upload(fileName, buffer, { contentType: "image/png", upsert: true });
      const { data: { publicUrl } } = s.storage.from("product-images").getPublicUrl(fileName);
      
      await s.from("products").update({ image_url: publicUrl }).eq("product_name", m.name);
      console.log(`✅ Uploaded & updated perfectly: ${m.name}`);
    } catch (e) {
      console.log(`❌ Failed: ${m.name} - ${e.message}`);
    }
  }
}
run();
