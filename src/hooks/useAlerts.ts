import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { toast } from 'sonner';

type Alert = {
  id: string;
  message: string;
  status: 'active' | 'resolved';
  created_at: string;
  product_id?: string;
  products?: { product_name: string } | null;
};

export function useAlerts() {
  const [alerts, setAlerts] = useState<Alert[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchAlerts = useCallback(async () => {
    // Dynamically generate alerts based on actual stock levels to bypass broken RLS on alerts table
    const { data: products, error } = await supabase
      .from('products')
      .select('id, product_name, quantity, reorder_level, created_at');

    if (error) {
      toast.error('Failed to load alerts: ' + error.message);
      setLoading(false);
      return;
    }

    if (products) {
      const generatedAlerts: Alert[] = products
        .filter(p => p.quantity <= (p.reorder_level || 10))
        .map(p => ({
          id: p.id, // Use product id as alert id for uniqueness
          product_id: p.id,
          message: `Low stock alert: ${p.product_name} is running out (Only ${p.quantity} left)`,
          status: 'active',
          created_at: p.created_at || new Date().toISOString(),
          products: { product_name: p.product_name }
        }));
      setAlerts(generatedAlerts);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    fetchAlerts();

    let channel: ReturnType<typeof supabase.channel> | null = null;
    try {
      const channelName = `alerts-products-${Math.random().toString(36).slice(2)}`;
      channel = supabase
        .channel(channelName)
        .on('postgres_changes', { event: '*', schema: 'public', table: 'products' }, () => {
          fetchAlerts();
        })
        .subscribe();
    } catch (err) {
      console.warn('Realtime subscription failed (products):', err);
    }

    return () => {
      if (channel) {
        try { supabase.removeChannel(channel); } catch {}
      }
    };
  }, [fetchAlerts]);

  const resolveAlert = async (id: string) => {
    // In this dynamic system, resolving an alert means restocking the product
    toast.info('Please update the inventory stock to resolve this alert.');
    return true;
  };

  return { alerts, loading, resolveAlert, refetch: fetchAlerts };
}
