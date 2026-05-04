import { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import { supabase } from '@/integrations/supabase/client';
import type { User } from '@supabase/supabase-js';
import type { Tables } from '@/integrations/supabase/types';

type Profile = Tables<'profiles'>;
type AppRole = 'admin' | 'staff' | 'customer';

interface AuthContextType {
  user: User | null;
  profile: Profile | null;
  isAdmin: boolean;
  isStaff: boolean;
  isCustomer: boolean;
  loading: boolean;
  signUp: (email: string, password: string, name: string, role?: AppRole) => Promise<{ error: string | null }>;
  signIn: (email: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
  updatePassword: (password: string) => Promise<{ error: string | null }>;
  resetPasswordForEmail: (email: string) => Promise<{ error: string | null }>;
  deleteAccount: () => Promise<{ error: string | null }>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [isAdmin, setIsAdmin] = useState(false);
  const [isStaff, setIsStaff] = useState(false);
  const [isCustomer, setIsCustomer] = useState(false);
  const [loading, setLoading] = useState(true);

  const fetchProfile = async (userId: string) => {
    // 1. Fetch Profile Data
    const { data: profileData, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', userId)
      .single();
    
    if (profileError) {
      console.error('Error fetching profile:', profileError);
      return;
    }

    setProfile(profileData);

    // 2. Fetch Roles from user_roles table
    const { data: userRoles } = await supabase
      .from('user_roles')
      .select('role')
      .eq('user_id', userId);
    
    const roles = userRoles?.map(r => r.role) || [];
    
    // Set boolean flags based on presence of roles in the database
    const hasAdmin = roles.includes('admin');
    const hasStaff = roles.includes('staff');
    const hasCustomer = roles.includes('customer') || (!hasAdmin && !hasStaff);

    setIsAdmin(hasAdmin);
    setIsStaff(hasStaff);
    setIsCustomer(hasCustomer);
    
    console.log('Role detection synced with database:', { userId, roles, hasAdmin, hasStaff, hasCustomer });
  };

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, session) => {
        setUser(session?.user ?? null);
        if (session?.user) {
          // Small delay to let the trigger create the profile first
          setTimeout(() => fetchProfile(session.user.id), 500);
        } else {
          setProfile(null);
          setIsAdmin(false);
          setIsStaff(false);
          setIsCustomer(false);
        }
        setLoading(false);
      }
    );

    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
      if (session?.user) {
        fetchProfile(session.user.id);
      } else {
        setLoading(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const signUp = async (email: string, password: string, name: string, role: AppRole = 'customer') => {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: { name, full_name: name, role },
        emailRedirectTo: window.location.origin,
      },
    });

    if (error) return { error: error.message };

    // If email confirmation is required, data.session will be null.
    // The postgres trigger handles initial profile creation securely.
    // We only force-update roles if they are logged in immediately.
    if (data.user && data.session) {
      await new Promise(resolve => setTimeout(resolve, 1500)); // Wait for trigger to create profile

      await supabase
        .from('profiles')
        .update({ role: role as any })
        .eq('id', data.user.id);

      // Belt-and-suspenders: also update user_roles
      if (role !== 'customer') {
        await supabase
          .from('user_roles')
          .upsert({ user_id: data.user.id, role: role as any }, { onConflict: 'user_id,role' });
      }

      await fetchProfile(data.user.id);
    }

    return { error: null };
  };

  const signIn = async (email: string, password: string) => {
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    return { error: error?.message ?? null };
  };

  const signOut = async () => {
    await supabase.auth.signOut();
    setUser(null);
    setProfile(null);
    setIsAdmin(false);
    setIsStaff(false);
    setIsCustomer(false);
  };

  const updatePassword = async (newPassword: string) => {
    const { error } = await supabase.auth.updateUser({ password: newPassword });
    return { error: error?.message ?? null };
  };

  const resetPasswordForEmail = async (email: string) => {
    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/auth`,
    });
    return { error: error?.message ?? null };
  };

  const deleteAccount = async () => {
    if (!user) return { error: 'No user logged in' };
    
    // Call the RPC defined in the SQL fix
    const { error } = await supabase.rpc('delete_own_user' as any);
    if (!error) {
      await signOut();
    }
    return { error: error?.message ?? null };
  };

  return (
    <AuthContext.Provider value={{ 
      user, profile, isAdmin, isStaff, isCustomer, loading, 
      signUp, signIn, signOut, updatePassword, resetPasswordForEmail, deleteAccount 
    }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used within AuthProvider');
  return context;
}
