import { useEffect, useRef } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { toast } from 'sonner';

export default function SystemInitializer() {
  const initialized = useRef(false);

  useEffect(() => {
    if (initialized.current) return;
    initialized.current = true;

    const checkAndSeedDefaults = async () => {
      try {
        // Only run check if we can query profiles
        const { count, error } = await supabase
          .from('profiles')
          .select('*', { count: 'exact', head: true })
          .eq('role', 'admin');

        // If no admins exist, we assume it's the first run or an empty DB
        if (!error && count === 0) {
          console.log('🔄 First run detected. Seeding default Admin and Staff accounts...');
          
          const { error: rpcError } = await supabase.rpc('seed_default_users');
          
          if (rpcError) {
            console.error('❌ Failed to seed default users:', rpcError);
          } else {
            console.log('✅ Default accounts seeded successfully!');
            console.log('----------------------------------------');
            console.log('👑 Admin Credentials:');
            console.log('   Email: admin@grozosphere.com');
            console.log('   Password: Admin@123');
            console.log('----------------------------------------');
            console.log('🛠️ Staff Credentials:');
            console.log('   Email: staff@grozosphere.com');
            console.log('   Password: Staff@123');
            console.log('----------------------------------------');
            
            toast.success('System Initialized: Default accounts created. Check console for credentials.', {
              duration: 10000,
            });
          }
        }
      } catch (err) {
        console.error('System initialization error:', err);
      }
    };

    // Small delay to ensure client is ready
    setTimeout(checkAndSeedDefaults, 1000);
  }, []);

  return null; // This is a silent functional component
}
