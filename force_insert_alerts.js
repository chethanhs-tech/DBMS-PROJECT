import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, resolve } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

dotenv.config({ path: resolve(__dirname, '.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY;

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

  console.log("Fetching 10 random products...");
  const { data: products, error: fetchError } = await supabase
    .from('products')
    .select('id, product_name, quantity, reorder_level')
    .limit(10);

  if (fetchError || !products) {
    console.error("Fetch error:", fetchError?.message);
    process.exit(1);
  }

  const alertsToInsert = products.map((p) => ({
    product_id: p.id,
    message: `Low stock alert: ${p.product_name} is running out`,
    status: 'active'
  }));

  console.log("Inserting alerts directly...");
  const { error: insertError } = await supabase.from('alerts').insert(alertsToInsert);
  
  if (insertError) {
    console.error("Insert error:", insertError.message);
  } else {
    console.log("Successfully inserted 10 alerts directly into the database.");
  }
}

main().catch(console.error);
