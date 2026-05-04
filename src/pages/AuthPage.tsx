import { useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import { Badge } from '@/components/ui/badge';
import { Store, ShieldCheck, UserCog, ShoppingBag, ArrowRight, Eye, EyeOff, Loader2, Lock, Sparkles, Copy, Check } from 'lucide-react';

type RoleTab = 'customer' | 'staff' | 'admin';

const ROLE_CONFIG = {
  customer: {
    label: 'Customer',
    icon: ShoppingBag,
    color: 'from-green-500 to-emerald-600',
    bg: 'bg-green-500/10',
    text: 'text-green-600',
    border: 'border-green-500/30',
    desc: 'Browse, shop & track orders',
    canSignUp: true,
  },
  staff: {
    label: 'Staff',
    icon: UserCog,
    color: 'from-blue-500 to-indigo-600',
    bg: 'bg-blue-500/10',
    text: 'text-blue-600',
    border: 'border-blue-500/30',
    desc: 'Manage inventory & restock',
    canSignUp: false,
  },
  admin: {
    label: 'Admin',
    icon: ShieldCheck,
    color: 'from-purple-500 to-violet-600',
    bg: 'bg-purple-500/10',
    text: 'text-purple-600',
    border: 'border-purple-500/30',
    desc: 'Full system control & users',
    canSignUp: false,
  },
};

export default function AuthPage() {
  const { signIn, signUp } = useAuth();
  const [isLogin, setIsLogin] = useState(true);
  const [selectedRole, setSelectedRole] = useState<RoleTab>('customer');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [resetSent, setResetSent] = useState(false);
  const [resetLoading, setResetLoading] = useState(false);
  const [verificationSent, setVerificationSent] = useState(false);
  const { resetPasswordForEmail } = useAuth();

  const config = ROLE_CONFIG[selectedRole];

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    
    const handleAuthError = (err: string) => {
      if (err.includes('Failed to fetch')) {
        setError('❌ Backend Unreachable: Cannot connect to Supabase. Please ensure your VITE_SUPABASE_URL in .env is correct and active.');
      } else {
        setError(err);
      }
    };

    if (isLogin) {
      const result = await signIn(email, password);
      if (result.error) handleAuthError(result.error);
    } else {
      const result = await signUp(email, password, name, 'customer');
      if (result.error) {
        handleAuthError(result.error);
      } else {
        // Show email verification notice
        setVerificationSent(true);
      }
    }
    setLoading(false);
  };

  const handleForgotPassword = async () => {
    if (!email) {
      setError('Please enter your email to reset password');
      return;
    }
    setError('');
    setResetLoading(true);
    const { error } = await resetPasswordForEmail(email);
    if (error) {
      setError(error);
    } else {
      setResetSent(true);
      setTimeout(() => setResetSent(false), 5000);
    }
    setResetLoading(false);
  };

  const handleRoleSelect = (role: RoleTab) => {
    setSelectedRole(role);
    setError('');
    setEmail('');
    setPassword('');
    setIsLogin(true); // Always default to login mode when switching tabs
    setVerificationSent(false); // Reset verification state
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background p-4 relative overflow-hidden">
      <div className="absolute inset-0 overflow-hidden">
        <div className="absolute -top-1/2 -right-1/2 w-full h-full bg-gradient-to-bl from-primary/5 via-transparent to-transparent rounded-full" />
        <div className="absolute -bottom-1/2 -left-1/2 w-full h-full bg-gradient-to-tr from-primary/3 via-transparent to-transparent rounded-full" />
        <div className="absolute top-20 left-20 w-72 h-72 bg-green-500/5 rounded-full blur-[100px]" />
        <div className="absolute bottom-20 right-20 w-96 h-96 bg-purple-500/5 rounded-full blur-[120px]" />
      </div>

      <div className="w-full max-w-lg relative z-10 space-y-6">
        {/* Header */}
        <div className="text-center space-y-3">
          <div className="flex justify-center">
            <div className="p-4 rounded-[1.5rem] bg-gradient-to-br from-primary/20 to-primary/5 shadow-xl shadow-primary/10">
              <Store className="h-10 w-10 text-primary" />
            </div>
          </div>
          <h1 className="text-3xl font-black tracking-tight">GrozoSphere</h1>
          <p className="text-sm text-muted-foreground font-medium">Smart Groceries. Smarter Inventory.</p>
        </div>

        {/* Role Selector Tabs */}
        <div className="flex gap-2 p-1.5 bg-secondary/50 rounded-2xl border border-border/50">
          {(Object.keys(ROLE_CONFIG) as RoleTab[]).map((role) => {
            const cfg = ROLE_CONFIG[role];
            const active = selectedRole === role;
            return (
              <button
                key={role}
                onClick={() => handleRoleSelect(role)}
                className={`flex-1 flex flex-col items-center gap-1.5 py-3 px-2 rounded-xl text-xs font-bold transition-all duration-300 ${
                  active
                    ? `bg-gradient-to-br ${cfg.color} text-white shadow-lg scale-105`
                    : 'text-muted-foreground hover:bg-secondary'
                }`}
              >
                <cfg.icon className="h-5 w-5" />
                <span className="font-black uppercase tracking-wider text-[10px]">{cfg.label}</span>
              </button>
            );
          })}
        </div>

        {/* Login Card */}
        <Card className="glass-card border-border/50 shadow-2xl overflow-hidden">
          <div className={`h-1.5 bg-gradient-to-r ${config.color}`} />
          <CardHeader className="pb-2 pt-6">
            <div className="flex items-center gap-3">
              <div className={`p-2 rounded-xl ${config.bg}`}>
                <config.icon className={`h-5 w-5 ${config.text}`} />
              </div>
              <div>
                <CardTitle className="text-xl font-black">
                  {isLogin ? `${config.label} Sign In` : 'Create Customer Account'}
                </CardTitle>
                <CardDescription className="text-xs mt-0.5">
                  {config.desc}
                </CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-5 pb-6">

            {verificationSent ? (
              <div className="py-8 text-center space-y-4 animate-in fade-in slide-in-from-bottom-2">
                <div className="h-16 w-16 bg-green-500/10 rounded-full flex items-center justify-center mx-auto mb-2">
                  <Check className="h-8 w-8 text-green-500" />
                </div>
                <h3 className="text-xl font-black text-foreground">Registration Successful!</h3>
                <p className="text-sm text-muted-foreground font-medium max-w-xs mx-auto">
                  We've sent a verification link to <span className="text-foreground font-bold">{email}</span>. 
                  Please check your inbox (and spam folder) to verify your account before logging in.
                </p>
                <Button 
                  variant="outline" 
                  className="mt-4 font-bold" 
                  onClick={() => { setVerificationSent(false); setIsLogin(true); setEmail(''); setPassword(''); }}
                >
                  Return to Sign In
                </Button>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-4">
              {!isLogin && (
                <div className="space-y-2">
                  <Label htmlFor="name" className="font-bold text-xs">Full Name</Label>
                  <Input id="name" value={name} onChange={e => setName(e.target.value)} placeholder="John Doe" required className="h-11 rounded-xl" />
                </div>
              )}
              <div className="space-y-2">
                <Label htmlFor="email" className="font-bold text-xs">Email</Label>
                <Input id="email" type="email" value={email} onChange={e => setEmail(e.target.value)} placeholder="you@email.com" required className="h-11 rounded-xl" />
              </div>
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <Label htmlFor="password" className="font-bold text-xs">Password</Label>
                  {isLogin && (
                    <button 
                      type="button" 
                      onClick={handleForgotPassword}
                      disabled={resetLoading}
                      className="text-[10px] font-bold text-primary hover:underline flex items-center gap-1 disabled:opacity-50"
                    >
                      {resetLoading && <Loader2 className="h-2 w-2 animate-spin" />}
                      Forgot password?
                    </button>
                  )}
                </div>
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

              {error && (
                <div className="p-3 rounded-xl bg-destructive/10 border border-destructive/20 animate-in fade-in slide-in-from-top-1">
                  <p className="text-sm text-destructive font-medium">{error}</p>
                </div>
              )}

              {resetSent && (
                <div className="p-3 rounded-xl bg-green-500/10 border border-green-500/20 animate-in fade-in slide-in-from-top-1">
                  <p className="text-sm text-green-600 font-bold flex items-center gap-2">
                    <Sparkles className="h-4 w-4" /> Reset link sent! Check your inbox.
                  </p>
                </div>
              )}
              <Button type="submit" className={`w-full h-11 font-black rounded-xl shadow-lg bg-gradient-to-r ${config.color} hover:opacity-90 transition-opacity gap-2`} disabled={loading}>
                {loading ? <><Loader2 className="h-4 w-4 animate-spin" /> Please wait...</> : <>{isLogin ? 'Sign In' : 'Sign Up'} <ArrowRight className="h-4 w-4" /></>}
              </Button>
            </form>
            )}

            {/* Default Credentials Display for Admin/Staff */}
            {(!config.canSignUp && isLogin && !verificationSent) && (
              <div className="mt-6 p-4 rounded-xl bg-secondary/50 border border-border/50 space-y-2">
                <p className="text-[10px] uppercase font-black tracking-widest text-muted-foreground flex items-center gap-1">
                  <Lock className="h-3 w-3" /> Default {config.label} Credentials
                </p>
                <div className="text-xs font-mono bg-background p-2 rounded border border-border/50 text-foreground flex justify-between items-center group cursor-pointer" onClick={() => {setEmail(selectedRole === 'admin' ? 'admin@grozosphere.com' : 'staff@grozosphere.com'); setPassword(selectedRole === 'admin' ? 'Admin@123' : 'Staff@123');}}>
                  <div>
                    <span className="text-muted-foreground">Email:</span> {selectedRole === 'admin' ? 'admin@grozosphere.com' : 'staff@grozosphere.com'}<br/>
                    <span className="text-muted-foreground">Pass:</span> {selectedRole === 'admin' ? 'Admin@123' : 'Staff@123'}
                  </div>
                  <Badge variant="secondary" className="opacity-0 group-hover:opacity-100 transition-opacity">Auto-fill</Badge>
                </div>
              </div>
            )}

            {/* Customer: Sign Up toggle */}
            {(config.canSignUp && !verificationSent) && (
              <div className="text-center text-sm text-muted-foreground pt-2">
                {isLogin ? "Don't have an account?" : 'Already have an account?'}{' '}
                <button onClick={() => { setIsLogin(!isLogin); setError(''); }} className="text-primary font-bold hover:underline transition-colors">
                  {isLogin ? 'Sign Up' : 'Sign In'}
                </button>
              </div>
            )}
            
            {(!config.canSignUp && !verificationSent) && (
              <p className="text-[10px] text-center text-muted-foreground mt-4">
                Notice: Staff/Admin accounts cannot be self-created.
              </p>
            )}
          </CardContent>
        </Card>

        {/* Role Info Footer */}
        <div className="text-center">
          <div className="flex justify-center gap-3 flex-wrap">
            <Badge variant="outline" className="rounded-lg text-[9px] font-bold gap-1 border-green-500/30"><ShoppingBag className="h-3 w-3" /> Customer: Self Sign Up</Badge>
            <Badge variant="outline" className="rounded-lg text-[9px] font-bold gap-1 border-blue-500/30"><UserCog className="h-3 w-3" /> Staff: Pre-assigned</Badge>
            <Badge variant="outline" className="rounded-lg text-[9px] font-bold gap-1 border-purple-500/30"><ShieldCheck className="h-3 w-3" /> Admin: Pre-assigned</Badge>
          </div>
        </div>
      </div>
    </div>
  );
}
