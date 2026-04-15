import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import type { Tables, TablesInsert } from '@/integrations/supabase/types';
import { toast } from 'sonner';

type Product = Tables<'products'>;

export function useProducts() {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchProducts = useCallback(async () => {
    const { data, error } = await supabase
      .from('products')
      .select('*')
      .order('created_at', { ascending: false });
    if (error) {
      toast.error('Failed to load products');
    } else {
      setProducts(data ?? []);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    fetchProducts();

    let channel: ReturnType<typeof supabase.channel> | null = null;
    try {
      const channelName = `products-${Math.random().toString(36).slice(2)}`;
      channel = supabase
        .channel(channelName)
        .on('postgres_changes', { event: '*', schema: 'public', table: 'products' }, () => {
          fetchProducts();
        })
        .subscribe();
    } catch (err) {
      console.warn('Realtime subscription failed (products), falling back to polling:', err);
    }

    return () => {
      if (channel) {
        try { supabase.removeChannel(channel); } catch {}
      }
    };
  }, [fetchProducts]);

  const addProduct = async (product: TablesInsert<'products'>) => {
    const { error } = await supabase.from('products').insert(product);
    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Product added');
    return true;
  };

  const updateProduct = async (id: string, updates: Partial<Product>) => {
    const { error } = await supabase.from('products').update(updates).eq('id', id);
    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Product updated');
    return true;
  };

  const deleteProduct = async (id: string) => {
    const { error } = await supabase.from('products').delete().eq('id', id);
    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Product deleted');
    return true;
  };

  return { products, loading, addProduct, updateProduct, deleteProduct, refetch: fetchProducts };
}
