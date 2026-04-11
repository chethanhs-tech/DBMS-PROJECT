import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import type { Tables } from '@/integrations/supabase/types';
import { toast } from 'sonner';
import { useAuth } from '@/contexts/AuthContext';

type Transaction = Tables<'transactions'> & { products?: { product_name: string } | null };

export function useTransactions() {
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  const fetchTransactions = useCallback(async () => {
    const { data, error } = await supabase
      .from('transactions')
      .select('*, products(product_name)')
      .order('created_at', { ascending: false });
    if (error) {
      toast.error('Failed to load transactions');
    } else {
      setTransactions(data ?? []);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    fetchTransactions();

    const channel = supabase
      .channel('transactions-changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'transactions' }, () => {
        fetchTransactions();
      })
      .subscribe();

    return () => { supabase.removeChannel(channel); };
  }, [fetchTransactions]);

  const createTransaction = async (productId: string, type: 'purchase' | 'sale', quantity: number) => {
    if (!user) {
      toast.error('You must be logged in');
      return false;
    }

    // Get current product
    const { data: product } = await supabase
      .from('products')
      .select('quantity, product_name')
      .eq('id', productId)
      .single();

    if (!product) {
      toast.error('Product not found');
      return false;
    }

    const newQuantity = type === 'purchase'
      ? product.quantity + quantity
      : product.quantity - quantity;

    if (newQuantity < 0) {
      toast.error(`Cannot sell ${quantity} units. Only ${product.quantity} in stock.`);
      return false;
    }

    // Insert transaction
    const { error: txError } = await supabase.from('transactions').insert({
      product_id: productId,
      type,
      quantity,
      user_id: user.id,
    });

    if (txError) {
      toast.error(txError.message);
      return false;
    }

    // Update product quantity
    const { error: updateError } = await supabase
      .from('products')
      .update({ quantity: newQuantity })
      .eq('id', productId);

    if (updateError) {
      toast.error(updateError.message);
      return false;
    }

    toast.success(`${type === 'purchase' ? 'Purchase' : 'Sale'} recorded`);
    return true;
  };

  return { transactions, loading, createTransaction, refetch: fetchTransactions };
}
