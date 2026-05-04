import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import type { Tables, TablesInsert } from '@/integrations/supabase/types';
import { toast } from 'sonner';

export type ProductVariant = Tables<'product_variants'>;
export type ProductWithVariants = Tables<'products'> & {
  product_variants: ProductVariant[];
};

export function useProducts() {
  const [products, setProducts] = useState<ProductWithVariants[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchProducts = useCallback(async () => {
    const { data, error } = await supabase
      .from('products')
      .select('*, product_variants(*), categories(name)')
      .order('created_at', { ascending: false });
    if (error) {
      toast.error('Failed to load products');
    } else {
      const mappedData = data?.map((p: any) => ({
        ...p,
        category: p.categories?.name || 'Uncategorized'
      }));
      setProducts((mappedData as any) ?? []);
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
