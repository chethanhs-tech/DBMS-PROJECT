import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import type { Tables } from '@/integrations/supabase/types';
import { toast } from 'sonner';

type Alert = Tables<'alerts'> & { products?: { product_name: string } | null };

export function useAlerts() {
  const [alerts, setAlerts] = useState<Alert[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchAlerts = useCallback(async () => {
    const { data, error } = await supabase
      .from('alerts')
      .select('*, products(product_name)')
      .order('created_at', { ascending: false });
    if (error) {
      toast.error('Failed to load alerts');
    } else {
      setAlerts(data ?? []);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    fetchAlerts();

    const channel = supabase
      .channel('alerts-changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'alerts' }, () => {
        fetchAlerts();
      })
      .subscribe();

    return () => { supabase.removeChannel(channel); };
  }, [fetchAlerts]);

  const resolveAlert = async (id: string) => {
    const { error } = await supabase.from('alerts').update({ status: 'resolved' }).eq('id', id);
    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Alert resolved');
    return true;
  };

  return { alerts, loading, resolveAlert, refetch: fetchAlerts };
}
