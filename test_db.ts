import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
import { resolve } from 'path';

dotenv.config({ path: resolve(process.cwd(), '.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkData() {
  console.log("Checking Orders...");
  const { data: orders, error: ordersError } = await supabase.from('orders').select('*').order('created_at', { ascending: false }).limit(1);
  if (ordersError) console.error("Orders Error:", ordersError);
  else console.log("Latest Order:", orders);

  console.log("Checking Transactions...");
  const { data: tx, error: txError } = await supabase.from('transactions').select('*').order('created_at', { ascending: false }).limit(1);
  if (txError) console.error("Transactions Error:", txError);
  else console.log("Latest Transaction:", tx);
}

checkData();
