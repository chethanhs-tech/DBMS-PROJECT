import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import { Store, Loader2, Eye, EyeOff, Lock, CheckCircle2 } from 'lucide-react';
import { toast } from 'sonner';
import { supabase } from '@/integrations/supabase/client';

export default function ResetPasswordPage() {
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [success, setSuccess] = useState(false);
  const [validating, setValidating] = useState(true);
  
  const { updatePassword } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    let isMounted = true;
    const hashParams = new URLSearchParams(window.location.hash.substring(1));
    const isRecoveryHash = hashParams.get('type') === 'recovery';

    const checkSession = async () => {
      const { data: { session }, error } = await supabase.auth.getSession();
      
      if (!isMounted) return;

      if (!session && !isRecoveryHash) {
        setError('Invalid or expired password reset link. Please try again.');
      }
      setValidating(false);
    };
    
    checkSession();
    
    const { data: authListener } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (!isMounted) return;
      if (event === 'PASSWORD_RECOVERY' || (event === 'SIGNED_IN' && session)) {
        setValidating(false);
        setError('');
      }
    });

    return () => {
      isMounted = false;
      authListener.subscription.unsubscribe();
    };
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (password.length < 6) {
      setError('Password must be at least 6 characters long');
      return;
    }
    
    if (password !== confirmPassword) {
      setError('Passwords do not match');
      return;
    }

    setError('');
    setLoading(true);
    
    const { error } = await updatePassword(password);
    
    if (error) {
      setError(error);
      toast.error('Failed to update password', { description: error });
    } else {
      setSuccess(true);
      toast.success('Password updated successfully');
      setTimeout(() => {
        navigate('/auth', { replace: true });
      }, 3000);
    }
    
    setLoading(false);
  };

  if (validating) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="flex flex-col items-center gap-3">
          <Loader2 className="h-8 w-8 text-primary animate-spin" />
          <p className="text-sm font-bold text-muted-foreground">Verifying reset link...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-background p-4 relative overflow-hidden">
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-1/2 -right-1/2 w-full h-full bg-gradient-to-bl from-primary/5 via-transparent to-transparent rounded-full" />
        <div className="absolute -bottom-1/2 -left-1/2 w-full h-full bg-gradient-to-tr from-primary/3 via-transparent to-transparent rounded-full" />
        <div className="absolute top-20 left-20 w-72 h-72 bg-purple-500/5 rounded-full blur-[100px]" />
      </div>

      <div className="w-full max-w-md relative z-10 space-y-6">
        <div className="text-center space-y-3">
          <div className="flex justify-center">
            <div className="p-4 rounded-[1.5rem] bg-gradient-to-br from-primary/20 to-primary/5 shadow-xl shadow-primary/10">
              <Lock className="h-10 w-10 text-primary" />
            </div>
          </div>
          <h1 className="text-3xl font-black tracking-tight">GrozoSphere</h1>
        </div>

        <Card className="glass-card border-border/50 shadow-2xl overflow-hidden">
          <div className="h-1.5 bg-gradient-to-r from-purple-500 to-indigo-600" />
          <CardHeader className="pb-4 pt-6">
            <CardTitle className="text-xl font-black">Create New Password</CardTitle>
            <CardDescription className="text-xs mt-1">
              Please enter your new password below.
            </CardDescription>
          </CardHeader>
          <CardContent className="pb-6">
            {success ? (
              <div className="space-y-4 animate-in fade-in slide-in-from-bottom-2 text-center">
                <div className="p-6 rounded-xl bg-green-500/10 border border-green-500/20 flex flex-col items-center gap-3">
                  <CheckCircle2 className="h-10 w-10 text-green-500" />
                  <div>
                    <h3 className="font-bold text-green-700 dark:text-green-400">Password Updated!</h3>
                    <p className="text-sm text-green-600/80 dark:text-green-500/80 mt-1">
                      Redirecting you to login...
                    </p>
                  </div>
                </div>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="password" className="font-bold text-xs">New Password</Label>
                  <div className="relative">
                    <Input
                      id="password"
                      type={showPassword ? 'text' : 'password'}
                      value={password}
                      onChange={e => setPassword(e.target.value)}
                      placeholder="••••••••"
                      required
                      minLength={6}
                      className="h-11 rounded-xl pr-10"
                    />
                    <button type="button" onClick={() => setShowPassword(!showPassword)} className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors">
                      {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                    </button>
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="confirmPassword" className="font-bold text-xs">Confirm New Password</Label>
                  <div className="relative">
                    <Input
                      id="confirmPassword"
                      type={showPassword ? 'text' : 'password'}
                      value={confirmPassword}
                      onChange={e => setConfirmPassword(e.target.value)}
                      placeholder="••••••••"
                      required
                      minLength={6}
                      className="h-11 rounded-xl pr-10"
                    />
                  </div>
                </div>

                {error && (
                  <div className="p-3 rounded-xl bg-destructive/10 border border-destructive/20 animate-in fade-in slide-in-from-top-1">
                    <p className="text-sm text-destructive font-medium">{error}</p>
                  </div>
                )}

                <Button 
                  type="submit" 
                  className="w-full h-11 font-black rounded-xl shadow-lg bg-gradient-to-r from-purple-500 to-indigo-600 hover:opacity-90 transition-opacity gap-2 mt-2" 
                  disabled={loading || (error ? error.includes('expired') : false)}
                >
                  {loading ? <><Loader2 className="h-4 w-4 animate-spin" /> Updating...</> : 'Update Password'}
                </Button>
              </form>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
