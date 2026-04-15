import { useState, useCallback, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/contexts/AuthContext';
import { toast } from 'sonner';

// Define address type locally so it works even without Supabase table
export interface Address {
  id: string;
  user_id: string;
  full_name: string;
  phone_number: string;
  house_no: string;
  street: string;
  city: string;
  pincode: string;
  landmark: string | null;
  is_default: boolean | null;
  created_at: string;
}

type NewAddress = Omit<Address, 'id' | 'user_id' | 'created_at'>;

// Helper to get/set from localStorage as fallback
const LOCAL_KEY = 'grozosphere_addresses';
function getLocalAddresses(userId: string): Address[] {
  try {
    const all = JSON.parse(localStorage.getItem(LOCAL_KEY) || '{}');
    return all[userId] || [];
  } catch { return []; }
}
function setLocalAddresses(userId: string, addresses: Address[]) {
  try {
    const all = JSON.parse(localStorage.getItem(LOCAL_KEY) || '{}');
    all[userId] = addresses;
    localStorage.setItem(LOCAL_KEY, JSON.stringify(all));
  } catch {}
}

export function useAddresses() {
  const { user } = useAuth();
  const [addresses, setAddresses] = useState<Address[]>([]);
  const [loading, setLoading] = useState(true);
  const [useLocal, setUseLocal] = useState(false);

  const fetchAddresses = useCallback(async () => {
    if (!user) { setLoading(false); return; }
    setLoading(true);

    // Try Supabase first
    const { data, error } = await supabase
      .from('addresses')
      .select('*')
      .eq('user_id', user.id)
      .order('is_default', { ascending: false })
      .order('created_at', { ascending: false });

    if (error) {
      // Table doesn't exist — fall back to localStorage
      console.warn('Addresses table not available, using local storage:', error.message);
      setUseLocal(true);
      setAddresses(getLocalAddresses(user.id));
    } else {
      setUseLocal(false);
      setAddresses(data || []);
    }
    setLoading(false);
  }, [user]);

  useEffect(() => {
    fetchAddresses();
  }, [fetchAddresses]);

  const addAddress = async (address: Omit<NewAddress, 'user_id'>) => {
    if (!user) return null;

    if (useLocal) {
      // localStorage fallback
      const newAddr: Address = {
        ...address,
        id: crypto.randomUUID(),
        user_id: user.id,
        created_at: new Date().toISOString(),
      };
      const updated = [...getLocalAddresses(user.id), newAddr];
      setLocalAddresses(user.id, updated);
      setAddresses(updated);
      toast.success('Address added (saved locally)');
      return newAddr;
    }

    const { data, error } = await supabase
      .from('addresses')
      .insert({ ...address, user_id: user.id } as any)
      .select()
      .single();

    if (error) {
      toast.error(error.message);
      return null;
    }
    toast.success('Address added');
    fetchAddresses();
    return data;
  };

  const updateAddress = async (id: string, updates: Partial<Address>) => {
    if (!user) return false;

    if (useLocal) {
      const all = getLocalAddresses(user.id);
      const idx = all.findIndex(a => a.id === id);
      if (idx >= 0) {
        all[idx] = { ...all[idx], ...updates };
        setLocalAddresses(user.id, all);
        setAddresses([...all]);
        toast.success('Address updated');
        return true;
      }
      return false;
    }

    const { error } = await supabase
      .from('addresses')
      .update(updates as any)
      .eq('id', id);

    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Address updated');
    fetchAddresses();
    return true;
  };

  const deleteAddress = async (id: string) => {
    if (!user) return false;

    if (useLocal) {
      const all = getLocalAddresses(user.id).filter(a => a.id !== id);
      setLocalAddresses(user.id, all);
      setAddresses(all);
      toast.success('Address removed');
      return true;
    }

    const { error } = await supabase
      .from('addresses')
      .delete()
      .eq('id', id);

    if (error) {
      toast.error(error.message);
      return false;
    }
    toast.success('Address removed');
    fetchAddresses();
    return true;
  };

  const setDefaultAddress = async (id: string) => {
    if (!user) return false;

    if (useLocal) {
      const all = getLocalAddresses(user.id).map(a => ({
        ...a,
        is_default: a.id === id,
      }));
      setLocalAddresses(user.id, all);
      setAddresses(all);
      toast.success('Default address set');
      return true;
    }

    // First unset all defaults, then set the new one
    await supabase
      .from('addresses')
      .update({ is_default: false } as any)
      .eq('user_id', user.id);

    const { error } = await supabase
      .from('addresses')
      .update({ is_default: true } as any)
      .eq('id', id);

    if (error) {
      toast.error(error.message);
      return false;
    }
    fetchAddresses();
    return true;
  };

  return {
    addresses,
    loading,
    addAddress,
    updateAddress,
    deleteAddress,
    setDefaultAddress,
    refetch: fetchAddresses,
  };
}
