import { useEffect, useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { supabase } from '@/integrations/supabase/client';
import { Loader2 } from 'lucide-react';

export default function AuthCallback() {
  const navigate = useNavigate();
  const location = useLocation();
  const [error, setError] = useState('');

  useEffect(() => {


    // Listen for auth state changes
    const { data: authListener } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('Auth event in callback:', event);
      
      if (event === 'PASSWORD_RECOVERY') {
        navigate('/reset-password', { replace: true });
        return;
      }

      if (event === 'SIGNED_IN' && session) {
        // If we have a session, redirect appropriately
        const hashParams = new URLSearchParams(window.location.hash.substring(1));
        if (hashParams.get('type') === 'recovery') {
          navigate('/reset-password', { replace: true });
        } else {
          navigate('/', { replace: true });
        }
      }
    });

    // Also check immediately in case the session is already established
    const checkImmediate = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      
      const params = new URLSearchParams(location.search);
      const hashParams = new URLSearchParams(window.location.hash.substring(1));
      const isRecovery = params.get('type') === 'recovery' || hashParams.get('type') === 'recovery';
      
      console.log('Immediate check - Session:', !!session, 'Is Recovery:', isRecovery);

      if (session) {
        if (isRecovery) {
          navigate('/reset-password', { replace: true });
        } else {
          navigate('/', { replace: true });
        }
      } else {
        // If no session but it IS a recovery link, we might be waiting for the hash to be parsed
        if (isRecovery) {
          console.log('Recovery detected, waiting for session...');
          return; // Let the onAuthStateChange handle it
        }

        // Only if there's no session after a short wait do we handle errors or fallback
        setTimeout(() => {
          const errorDescription = params.get('error_description') || hashParams.get('error_description');
          if (errorDescription) {
            // Make the error user-friendly if it's the common expired link error
            if (errorDescription.includes('expired')) {
              setError("This reset link has expired or was already used. Please request a new one.");
            } else {
              setError(decodeURIComponent(errorDescription.replace(/\+/g, ' ')));
            }
          }
        }, 2000);
      }
    };

    checkImmediate();

    return () => {
      authListener.subscription.unsubscribe();
    };
  }, [navigate, location]);

  return (
    <div className="flex h-screen items-center justify-center bg-background">
      <div className="flex flex-col items-center gap-4 text-center p-6 max-w-sm">
        {error ? (
          <>
            <div className="p-4 rounded-xl bg-destructive/10 border border-destructive/20 text-destructive text-sm font-medium">
              {error}
            </div>
            <button 
              onClick={() => navigate('/auth', { replace: true })}
              className="text-primary font-bold hover:underline text-sm"
            >
              Return to Login
            </button>
          </>
        ) : (
          <>
            <div className="h-12 w-12 border-4 border-primary/30 border-t-primary rounded-full animate-spin" />
            <p className="text-sm font-bold text-muted-foreground">
              Authenticating...
            </p>
          </>
        )}
      </div>
    </div>
  );
}
