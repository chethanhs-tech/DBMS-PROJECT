import { ReactNode, useMemo } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { useCart } from '@/contexts/CartContext';
import { useAddresses } from '@/hooks/useAddresses';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { 
  LayoutDashboard, 
  Package, 
  ArrowLeftRight, 
  ShoppingBag, 
  ShoppingCart, 
  Store, 
  User, 
  ShieldCheck, 
  UserCog,
  MapPin, 
  Bell, 
  LogOut,
  ChevronRight,
  Truck
} from 'lucide-react';
import ThemeToggle from '@/components/ThemeToggle';

export default function AppLayout({ children }: { children: ReactNode }) {
  const { profile, isAdmin, isStaff, isManager, isCustomer, signOut } = useAuth();
  const { totalItems } = useCart();
  const { addresses } = useAddresses();
  const location = useLocation();

  const defaultAddress = useMemo(() => {
    if (!Array.isArray(addresses)) return null;
    return addresses.find(a => a.is_default) || addresses[0] || null;
  }, [addresses]);

  // Role badge config
  const roleBadge = useMemo(() => {
    if (isAdmin) return { label: 'Admin', color: 'bg-purple-500/10 text-purple-600 border-purple-500/20' };
    if (isManager) return { label: 'Manager', color: 'bg-blue-500/10 text-blue-600 border-blue-500/20' };
    if (isStaff) return { label: 'Staff', color: 'bg-indigo-500/10 text-indigo-600 border-indigo-500/20' };
    return { label: 'Customer', color: 'bg-green-500/10 text-green-600 border-green-500/20' };
  }, [isAdmin, isStaff, isManager]);

  // Build nav items based on role
  const navItems = useMemo(() => {
    // Common items for everyone
    const items = [
      { to: '/', icon: LayoutDashboard, label: 'Dashboard' },
      { to: '/shop', icon: Store, label: 'Shop' },
      { to: '/cart', icon: ShoppingCart, label: 'Cart' },
      { to: '/orders', icon: ShoppingBag, label: 'My Orders' },
      { to: '/profile', icon: User, label: 'Profile' },
    ];

    // Staff & Admin: Inventory management
    if (isAdmin || isStaff) {
      items.push(
        { to: '/products', icon: Package, label: 'Inventory' },
        { to: '/transactions', icon: ArrowLeftRight, label: 'Transactions' },
        { to: '/alerts', icon: Bell, label: 'Alerts' }
      );
    }

    // Admin only: User management
    if (isAdmin) {
      items.push({ to: '/admin/users', icon: ShieldCheck, label: 'User Admin' });
    }

    return items;
  }, [isAdmin, isStaff]);

  // Role-specific accent for sidebar header
  const sidebarAccent = useMemo(() => {
    if (isAdmin) return 'from-purple-500 to-violet-600';
    if (isStaff) return 'from-blue-500 to-indigo-600';
    return 'from-primary to-green-600';
  }, [isAdmin, isStaff]);

  return (
    <div className="flex h-screen bg-background">
      {/* Sidebar */}
      <aside className="w-72 bg-card text-card-foreground flex flex-col shrink-0 border-r border-border/50 shadow-2xl z-20">
        <div className="p-8">
          <Link to="/" className="flex items-center gap-3 group">
            <div className={`p-2.5 rounded-[1.2rem] bg-gradient-to-br ${sidebarAccent} shadow-lg group-hover:scale-110 transition-transform duration-500`}>
              <Store className="h-6 w-6 text-white" />
            </div>
            <div>
              <h1 className="text-xl font-black tracking-tighter leading-none">GrozoSphere</h1>
              <p className="text-[10px] text-muted-foreground font-black uppercase tracking-widest mt-1">
                {isAdmin ? 'Admin Panel' : isManager ? 'Manager Portal' : isStaff ? 'Staff Portal' : 'Smart Inventory'}
              </p>
            </div>
          </Link>
        </div>

        {/* Role indicator */}
        <div className="px-6 pb-4">
          <div className={`flex items-center gap-2 px-3 py-2 rounded-xl border text-xs font-bold ${roleBadge.color}`}>
            {isAdmin ? <ShieldCheck className="h-3.5 w-3.5" /> : (isManager || isStaff) ? <UserCog className="h-3.5 w-3.5" /> : <ShoppingBag className="h-3.5 w-3.5" />}
            {roleBadge.label} Access
          </div>
        </div>

        <nav className="flex-1 px-4 space-y-1 overflow-y-auto scrollbar-hide">
          {navItems.map(item => {
            const active = location.pathname === item.to;
            return (
              <Link
                key={item.to}
                to={item.to}
                className={`flex items-center gap-3 px-4 py-3.5 rounded-[1.2rem] text-sm transition-all duration-300 group relative ${active
                    ? 'bg-primary text-primary-foreground font-black shadow-xl shadow-primary/20 translate-x-1'
                    : 'hover:bg-secondary text-muted-foreground hover:text-foreground font-bold'
                  }`}
              >
                <item.icon className={`h-5 w-5 transition-transform duration-300 ${active ? '' : 'group-hover:scale-110'}`} />
                {item.label}
                {item.to === '/cart' && totalItems > 0 && (
                  <Badge className={`ml-auto h-5 min-w-5 flex items-center justify-center text-[10px] font-black border-none rounded-lg ${active ? 'bg-white text-primary' : 'bg-primary text-primary-foreground'}`}>
                    {totalItems}
                  </Badge>
                )}
                {active && <div className="absolute left-0 w-1.5 h-6 bg-white rounded-full -translate-x-1" />}
                {!active && <ChevronRight className="ml-auto h-4 w-4 opacity-0 group-hover:opacity-100 transition-opacity" />}
              </Link>
            );
          })}
        </nav>

        <div className="p-6 mt-auto">
          <div className="p-5 rounded-[2rem] bg-secondary/50 border border-border/50 space-y-4">
            <div className="flex items-center gap-3">
              <div className={`h-12 w-12 rounded-2xl bg-gradient-to-br ${sidebarAccent} flex items-center justify-center text-white font-black text-lg shadow-lg`}>
                {profile?.name?.charAt(0)?.toUpperCase() || 'U'}
              </div>
              <div className="min-w-0 flex-1">
                <p className="text-sm font-black truncate">{profile?.name || 'User'}</p>
                <Badge variant="outline" className={`h-5 px-2 text-[9px] font-black uppercase border-0 ${roleBadge.color}`}>
                  {roleBadge.label}
                </Badge>
              </div>
            </div>
            <Button 
              variant="ghost" 
              size="sm" 
              onClick={signOut} 
              className="w-full justify-start text-muted-foreground hover:text-destructive hover:bg-destructive/5 rounded-xl transition-all duration-300 font-bold"
            >
              <LogOut className="h-4 w-4 mr-3" />
              Sign Out
            </Button>
          </div>
        </div>
      </aside>

      {/* Main content */}
      <main className="flex-1 overflow-auto flex flex-col relative">
        <header className="sticky top-0 z-30 bg-background/80 backdrop-blur-2xl border-b border-border/50 px-8 py-4 flex items-center justify-between">
          <div className="flex items-center gap-4">
            {defaultAddress ? (
              <Link to="/profile" className="flex items-center gap-2 group cursor-pointer hover:opacity-80 transition-opacity">
                <div className="p-2 rounded-xl bg-success/10 text-success">
                  <MapPin className="h-4 w-4" />
                </div>
                <div>
                  <p className="text-[10px] font-black uppercase tracking-widest text-muted-foreground leading-none">Delivering to</p>
                  <p className="text-sm font-black flex items-center gap-1 mt-0.5">
                    {defaultAddress.city} <span className="text-primary">•</span> 15 mins
                  </p>
                </div>
              </Link>
            ) : (
              <Link to="/profile" className="flex items-center gap-2 text-muted-foreground hover:text-primary transition-colors">
                <MapPin className="h-4 w-4" />
                <span className="text-xs font-bold">Add delivery address</span>
              </Link>
            )}
          </div>
          
          <div className="flex items-center gap-5">
            <Link to="/cart" className="relative group p-2 rounded-xl hover:bg-secondary transition-all">
              <ShoppingCart className="h-5 w-5 text-muted-foreground group-hover:text-primary transition-colors" />
              {totalItems > 0 && (
                <span className="absolute -top-1 -right-1 h-5 min-w-5 flex items-center justify-center text-[10px] font-black bg-primary text-primary-foreground rounded-lg px-1 shadow-lg shadow-primary/20 animate-in zoom-in">
                  {totalItems}
                </span>
              )}
            </Link>
            <ThemeToggle />
          </div>
        </header>

        <div className="p-8 max-w-7xl mx-auto w-full animate-fade-in relative z-10">
          {children}
        </div>
        
        {/* Background glow effects */}
        <div className="fixed top-0 right-0 w-[500px] h-[500px] bg-primary/5 rounded-full blur-[120px] -z-10 pointer-events-none" />
        <div className="fixed bottom-0 left-0 w-[400px] h-[400px] bg-green-500/5 rounded-full blur-[100px] -z-10 pointer-events-none" />
      </main>
    </div>
  );
}
