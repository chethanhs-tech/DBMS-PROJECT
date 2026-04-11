import { ReactNode } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { LayoutDashboard, Package, ArrowLeftRight, Users, Bell, LogOut, Truck } from 'lucide-react';
import ThemeToggle from '@/components/ThemeToggle';

const navItems = [
  { to: '/', icon: LayoutDashboard, label: 'Dashboard' },
  { to: '/products', icon: Package, label: 'Products' },
  { to: '/transactions', icon: ArrowLeftRight, label: 'Transactions' },
  { to: '/suppliers', icon: Truck, label: 'Suppliers' },
  { to: '/alerts', icon: Bell, label: 'Alerts' },
];

export default function AppLayout({ children }: { children: ReactNode }) {
  const { profile, isAdmin, signOut } = useAuth();
  const location = useLocation();

  return (
    <div className="flex h-screen">
      {/* Sidebar */}
      <aside className="w-64 bg-sidebar text-sidebar-foreground flex flex-col shrink-0 border-r border-sidebar-border">
        <div className="p-6">
          <h1 className="text-lg font-bold flex items-center gap-2">
            <div className="p-1.5 rounded-lg bg-sidebar-primary/20">
              <Package className="h-5 w-5 text-sidebar-primary" />
            </div>
            Smart Inventory
          </h1>
        </div>
        <nav className="flex-1 px-3 space-y-1">
          {navItems.map(item => {
            const active = location.pathname === item.to;
            return (
              <Link
                key={item.to}
                to={item.to}
                className={`flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm transition-all duration-200 group ${
                  active
                    ? 'bg-sidebar-accent text-sidebar-accent-foreground font-medium shadow-sm'
                    : 'hover:bg-sidebar-accent/50 text-sidebar-foreground/70 hover:text-sidebar-foreground'
                }`}
              >
                <item.icon className={`h-4 w-4 transition-transform duration-200 ${active ? '' : 'group-hover:scale-110'}`} />
                {item.label}
                {active && <div className="ml-auto w-1.5 h-1.5 rounded-full bg-sidebar-primary" />}
              </Link>
            );
          })}
        </nav>
        <div className="p-4 border-t border-sidebar-border">
          <div className="flex items-center gap-3 mb-3">
            <div className="h-9 w-9 rounded-full bg-gradient-to-br from-primary to-primary/60 flex items-center justify-center text-primary-foreground text-xs font-bold shadow-sm">
              {profile?.name?.charAt(0)?.toUpperCase() || 'U'}
            </div>
            <div className="min-w-0 flex-1">
              <p className="text-sm font-medium truncate">{profile?.name || 'User'}</p>
              <p className="text-xs text-sidebar-foreground/50 capitalize">{isAdmin ? 'Admin' : 'Staff'}</p>
            </div>
          </div>
          <Button variant="ghost" size="sm" onClick={signOut} className="w-full justify-start text-sidebar-foreground/70 hover:text-sidebar-foreground hover:bg-sidebar-accent transition-all duration-200">
            <LogOut className="h-4 w-4 mr-2" />
            Sign Out
          </Button>
        </div>
      </aside>

      {/* Main content */}
      <main className="flex-1 overflow-auto bg-background">
        <div className="sticky top-0 z-10 bg-background/80 backdrop-blur-xl border-b border-border/50 px-6 py-3 flex items-center justify-between">
          <div />
          <ThemeToggle />
        </div>
        <div className="p-6 max-w-7xl mx-auto animate-fade-in">
          {children}
        </div>
      </main>
    </div>
  );
}
