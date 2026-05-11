import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import { Store, Loader2, Sparkles, ArrowLeft } from 'lucide-react';
import { Link, useLocation } from 'react-router-dom';
import { toast } from 'sonner';

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);
  const { resetPasswordForEmail } = useAuth();
  const location = useLocation();

  useEffect(() => {
    // Check for errors returned from Supabase in the URL
    const params = new URLSearchParams(location.search);
    const errorDescription = params.get('error_description') || params.get('error');
    if (errorDescription) {
      setError(errorDescription);
      toast.error('Auth Error', { description: errorDescription });
    }
  }, [location]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email) {
      setError('Please enter your email');
      return;
    }
    setError('');
    setLoading(true);
    const { error } = await resetPasswordForEmail(email);
    if (error) {
      setError(error);
      toast.error('Failed to send reset link', { description: error });
    } else {
      setSent(true);
      toast.success('Reset link sent to ' + email);
    }
    setLoading(false);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background p-4 relative overflow-hidden">
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-1/2 -right-1/2 w-full h-full bg-gradient-to-bl from-primary/5 via-transparent to-transparent rounded-full" />
        <div className="absolute -bottom-1/2 -left-1/2 w-full h-full bg-gradient-to-tr from-primary/3 via-transparent to-transparent rounded-full" />
        <div className="absolute top-20 left-20 w-72 h-72 bg-blue-500/5 rounded-full blur-[100px]" />
      </div>

      <div className="w-full max-w-md relative z-10 space-y-6">
        <div className="text-center space-y-3">
          <div className="flex justify-center">
            <div className="p-4 rounded-[1.5rem] bg-gradient-to-br from-primary/20 to-primary/5 shadow-xl shadow-primary/10">
              <Store className="h-10 w-10 text-primary" />
            </div>
          </div>
          <h1 className="text-3xl font-black tracking-tight">GrozoSphere</h1>
        </div>

        <Card className="glass-card border-border/50 shadow-2xl overflow-hidden">
          <div className="h-1.5 bg-gradient-to-r from-blue-500 to-indigo-600" />
          <CardHeader className="pb-4 pt-6">
            <CardTitle className="text-xl font-black">Reset Password</CardTitle>
            <CardDescription className="text-xs mt-1">
              Enter your email address and we'll send you a link to reset your password.
            </CardDescription>
          </CardHeader>
          <CardContent className="pb-6">
            {sent ? (
              <div className="space-y-4 animate-in fade-in slide-in-from-bottom-2 text-center">
                <div className="p-4 rounded-xl bg-green-500/10 border border-green-500/20">
                  <p className="text-sm text-green-600 font-bold flex items-center justify-center gap-2">
                    <Sparkles className="h-4 w-4" /> Reset link sent!
                  </p>
                  <p className="text-xs text-muted-foreground mt-2">
                    Please check your inbox at {email}.
                  </p>
                </div>
                <Link to="/auth">
                  <Button variant="outline" className="w-full h-11 font-bold rounded-xl">
                    Return to Login
                  </Button>
                </Link>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="email" className="font-bold text-xs">Email Address</Label>
                  <Input 
                    id="email" 
                    type="email" 
                    value={email} 
                    onChange={e => setEmail(e.target.value)} 
                    placeholder="you@email.com" 
                    required 
                    className="h-11 rounded-xl" 
                  />
                </div>

                {error && (
                  <div className="p-3 rounded-xl bg-destructive/10 border border-destructive/20 animate-in fade-in slide-in-from-top-1">
                    <p className="text-sm text-destructive font-medium">{error}</p>
                  </div>
                )}

                <Button 
                  type="submit" 
                  className="w-full h-11 font-black rounded-xl shadow-lg bg-gradient-to-r from-blue-500 to-indigo-600 hover:opacity-90 transition-opacity gap-2" 
                  disabled={loading}
                >
                  {loading ? <><Loader2 className="h-4 w-4 animate-spin" /> Sending...</> : 'Send Reset Link'}
                </Button>
                
                <div className="pt-4 border-t border-border/30">
                  <div className="p-3 rounded-xl bg-primary/5 border border-primary/10 text-[10px] text-muted-foreground leading-relaxed">
                    <p className="font-bold text-primary mb-1 uppercase tracking-wider">Pro-Tip for Developers:</p>
                    If the email is not sending, ensure <code className="text-foreground bg-primary/10 px-1 rounded">{window.location.origin}/auth/callback</code> is added to your <span className="font-bold">Supabase Auth → Redirect URLs</span>.
                  </div>
                </div>

                <div className="pt-2 text-center">
                  <Link to="/auth" className="text-sm text-muted-foreground hover:text-primary transition-colors flex items-center justify-center gap-1 font-medium">
                    <ArrowLeft className="h-4 w-4" /> Back to Login
                  </Link>
                </div>
              </form>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
