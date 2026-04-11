import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import type { Tables, TablesInsert } from '@/integrations/supabase/types';
import { toast } from 'sonner';

type Supplier = Tables<'suppliers'>;

export function useSuppliers() {
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchSuppliers = useCallback(async () => {
    const { data, error } = await supabase
      .from('suppliers')
      .select('*')
      .order('created_at', { ascending: false });
    if (error) {
      toast.error('Failed to load suppliers');
    } else {
      setSuppliers(data ?? []);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    fetchSuppliers();
  }, [fetchSuppliers]);

  const addSupplier = async (supplier: TablesInsert<'suppliers'>) => {
    const { error } = await supabase.from('suppliers').insert(supplier);
    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Supplier added');
    await fetchSuppliers();
    return true;
  };

  const updateSupplier = async (id: string, updates: Partial<Supplier>) => {
    const { error } = await supabase.from('suppliers').update(updates).eq('id', id);
    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Supplier updated');
    await fetchSuppliers();
    return true;
  };

  const deleteSupplier = async (id: string) => {
    const { error } = await supabase.from('suppliers').delete().eq('id', id);
    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Supplier deleted');
    await fetchSuppliers();
    return true;
  };

  return { suppliers, loading, addSupplier, updateSupplier, deleteSupplier };
}
