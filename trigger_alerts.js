import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, resolve } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

dotenv.config({ path: resolve(__dirname, '.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials in .env");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function main() {
  console.log("Authenticating as Admin...");
  const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
    email: 'admin@grozosphere.com',
    password: 'Admin@123',
  });

  if (authError) {
    console.error("Auth error:", authError.message);
    process.exit(1);
  }
  console.log("Authenticated successfully!");

  console.log("Fetching 10 products that currently have no active alerts and sufficient stock...");
  
  // We want products where quantity > reorder_level
  const { data: products, error: fetchError } = await supabase
    .from('products')
    .select('id, product_name, quantity, reorder_level')
    .gt('quantity', 10) // assuming reorder level is around 10
    .limit(10);

  if (fetchError) {
    console.error("Fetch error:", fetchError.message);
    process.exit(1);
  }

  if (!products || products.length === 0) {
    console.log("No products found to lower stock for.");
    return;
  }

  console.log(`Found ${products.length} products. Lowering their stock to trigger alerts...`);

  for (const product of products) {
    const newQuantity = (product.reorder_level || 10) - 1;
    console.log(`Updating ${product.product_name} from ${product.quantity} to ${newQuantity}...`);
    
    const { error: updateError } = await supabase
      .from('products')
      .update({ quantity: newQuantity })
      .eq('id', product.id);
      
    if (updateError) {
      console.error(`Failed to update ${product.product_name}:`, updateError.message);
    } else {
      console.log(`Successfully updated ${product.product_name}`);
    }
  }

  console.log("Done! You should now see alerts in the dashboard.");
}

main().catch(console.error);
