import { useDashboardData } from '@/hooks/useDashboardData';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import {
  Package,
  AlertTriangle,
  TrendingUp,
  Activity,
  Sparkles,
  ArrowRight,
  Plus,
  Store,
  ArrowUpDown,
  Truck,
  RotateCcw,
  CheckCircle2,
  ChevronRight,
  Loader2
} from 'lucide-react';
import { useMemo, useState } from 'react';
import { useProducts } from '@/hooks/useProducts';
import { useCart } from '@/contexts/CartContext';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Link } from 'react-router-dom';
import { supabase } from '@/integrations/supabase/client';
import { toast } from 'sonner';

const CATEGORIES = [
  { label: 'Fruits', icon: '🍎' },
  { label: 'Vegetables', icon: '🥦' },
  { label: 'Dairy', icon: '🥛' },
  { label: 'Snacks', icon: '🛍️' },
  { label: 'Beverages', icon: '🥤' },
  { label: 'Bakery', icon: '🥐' },
];

function SafeNumber({ value }: { value: unknown }) {
  const n = typeof value === 'number' && Number.isFinite(value) ? value : 0;
  return <span>{n.toLocaleString('en-IN')}</span>;
}

export default function DashboardPage() {
  const rawDashboard = useDashboardData();
  const { products = [], loading: productsLoading = false, refetch: refetchProducts } = useProducts() || {};
  const { addToCart } = useCart() || {};
  const { isAdmin, isStaff, user } = useAuth();
  const [refillLoading, setRefillLoading] = useState<string | null>(null);

  // Merge fallback values defensively
  const dashboard = useMemo(() => {
    try {
      return {
        loading: false,
        totalProducts: 0,
        lowStockCount: 0,
        totalSales: 0,
        activeAlertsCount: 0,
        ...(rawDashboard || {}),
        recentTransactions: Array.isArray(rawDashboard?.recentTransactions) ? rawDashboard.recentTransactions : [],
        reorderSuggestions: Array.isArray(rawDashboard?.reorderSuggestions) ? rawDashboard.reorderSuggestions : [],
      };
    } catch (e) {
      console.error("Dashboard calculation error:", e);
      return {
        loading: false,
        totalProducts: 0,
        lowStockCount: 0,
        totalSales: 0,
        activeAlertsCount: 0,
        recentTransactions: [],
        reorderSuggestions: [],
      };
    }
  }, [rawDashboard]);

  const loading = dashboard.loading || productsLoading;

  const featuredProducts = useMemo(() => {
    return Array.isArray(products) ? products.slice(0, 4) : [];
  }, [products]);

  const refillItems = useMemo(() => {
    return products.filter(p => p.quantity <= p.reorder_level).slice(0, 5);
  }, [products]);

  const statCards = [
    { title: 'Total Products', value: dashboard?.totalProducts || 0, icon: Package, color: 'text-primary', bg: 'bg-primary/10' },
    { title: 'Low Stock Items', value: dashboard?.lowStockCount || 0, icon: AlertTriangle, color: 'text-orange-500', bg: 'bg-orange-500/10' },
    { title: 'Total Sales (Units)', value: dashboard?.totalSales || 0, icon: TrendingUp, color: 'text-green-500', bg: 'bg-green-500/10' },
    { title: 'Gross Revenue (₹)', value: (dashboard?.totalSales || 0) * 45, icon: Activity, color: 'text-primary', bg: 'bg-primary/10' },
  ];

  const handleQuickRefill = async (productId: string, currentQty: number) => {
    if (!user) return;
    setRefillLoading(productId);
    try {
      const addedQty = 50; // Standard refill pack
      const newQty = currentQty + addedQty;

      // 1. Update Product
      const { error: productError } = await supabase
        .from('products')
        .update({ quantity: newQty })
        .eq('id', productId);
      
      if (productError) throw productError;

      // 2. Log Transaction
      await supabase.from('transactions').insert({
        product_id: productId,
        type: 'purchase',
        quantity: addedQty,
        user_id: user.id
      });

      toast.success('Stock replenished successfully');
      if (refetchProducts) refetchProducts();
    } catch (err: any) {
      toast.error(err.message || 'Failed to refill stock');
    } finally {
      setRefillLoading(null);
    }
  };

  if (loading) {
    return (
      <div className="space-y-10 animate-pulse p-6">
        <div className="h-64 bg-muted rounded-[2.5rem]" />
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
          {[1,2,3,4].map(i => <div key={i} className="h-32 bg-muted rounded-3xl" />)}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-12 pb-20">
      {/* --- HERO SECTION --- */}
      <div className="relative overflow-hidden rounded-[3rem] bg-card p-8 md:p-14 border border-border/50 shadow-2xl">
        <div className="relative z-10 max-w-2xl">
          <div className="flex items-center gap-2 mb-6">
            <Badge className="bg-primary/10 text-primary border-none px-4 py-1.5 rounded-full text-xs font-black uppercase tracking-widest">
              <Sparkles className="mr-2 h-4 w-4" /> GrozoSphere Hub
            </Badge>
          </div>
          <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-[1.05]">
            Freshness <br />
            <span className="text-primary italic">Unlimited.</span>
          </h1>
          <p className="text-xl text-muted-foreground mb-10 max-w-lg font-medium leading-relaxed">
            From farm to your doorstep in 15 mins. Discover the smartest way to manage your groceries.
          </p>
          <div className="flex flex-wrap gap-5">
            <Button asChild size="lg" className="rounded-2xl h-16 font-black px-10 text-lg shadow-xl shadow-primary/20 group">
              <Link to="/shop" className="flex items-center gap-2">Start Shopping <ArrowRight className="h-5 w-5 group-hover:translate-x-1 transition-transform" /></Link>
            </Button>
            {(isAdmin || isStaff) && (
              <Button asChild variant="secondary" size="lg" className="rounded-2xl h-16 px-10 text-lg font-black group">
                <Link to="/products" className="flex items-center gap-2">Manage Stock <Package className="h-5 w-5 group-hover:scale-110 transition-transform" /></Link>
              </Button>
            )}
          </div>
        </div>
        
        {/* Decorative Elements */}
        <div className="absolute top-0 right-0 -mr-20 -mt-20 w-[500px] h-[500px] bg-primary/5 rounded-full blur-[100px] -z-10" />
        <div className="absolute bottom-0 right-20 hidden xl:block opacity-50 transform translate-y-10">
          <Store className="w-96 h-96 text-primary/5" />
        </div>
      </div>

      {/* --- CATEGORIES --- */}
      <section>
        <div className="flex justify-between items-end mb-8">
          <div>
            <h2 className="text-3xl font-black tracking-tight">Categories</h2>
            <p className="text-sm text-muted-foreground mt-1 font-medium italic">Handpicked for your daily needs</p>
          </div>
          <Button variant="ghost" className="text-primary font-black hover:bg-primary/5" asChild>
            <Link to="/shop" className="flex items-center gap-2">View All <ChevronRight className="h-4 w-4" /></Link>
          </Button>
        </div>
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6">
          {CATEGORIES.map((cat, i) => (
            <Link
              key={cat.label}
              to={`/shop?cat=${cat.label}`}
              className="flex flex-col items-center gap-4 p-6 rounded-[2rem] bg-card border border-border/50 shadow-sm hover:shadow-2xl hover:border-primary/30 hover:-translate-y-2 transition-all duration-500 group"
            >
              <div className="w-20 h-20 rounded-3xl bg-secondary/50 flex items-center justify-center text-4xl group-hover:scale-110 transition-transform duration-500 group-hover:rotate-6">
                {cat.icon}
              </div>
              <span className="text-xs font-black uppercase tracking-widest text-center opacity-80">{cat.label}</span>
            </Link>
          ))}
        </div>
      </section>

      {/* --- FEATURED PRODUCTS --- */}
      <section>
        <div className="flex justify-between items-end mb-8">
          <div>
            <h2 className="text-3xl font-black tracking-tight">Flash Deals</h2>
            <p className="text-sm text-muted-foreground mt-1 font-medium italic">Top trending items this week</p>
          </div>
          <Button variant="ghost" className="text-primary font-black hover:bg-primary/5" asChild>
            <Link to="/shop" className="flex items-center gap-2">Shop More <ChevronRight className="h-4 w-4" /></Link>
          </Button>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          {featuredProducts.map((product) => (
            <Card key={product.id} className="group glass-card border-border/50 hover:border-primary/30 shadow-sm hover:shadow-2xl hover:-translate-y-2 transition-all duration-500 rounded-[2.5rem] overflow-hidden">
              <div className="aspect-[4/3] bg-muted/20 relative overflow-hidden">
                {product.image_url ? (
                  <img src={product.image_url} alt={product.product_name} className="h-full w-full object-cover group-hover:scale-110 transition-transform duration-700" />
                ) : (
                  <div className="h-full w-full flex items-center justify-center">
                    <Package className="h-16 w-16 text-muted-foreground/10" />
                  </div>
                )}
                {(product.quantity || 0) <= (product.reorder_level || 0) && (
                  <Badge className="absolute top-4 left-4 bg-orange-500 text-white border-none shadow-lg text-[9px] uppercase font-black px-3 py-1 rounded-full">Low Stock</Badge>
                )}
              </div>
              <CardContent className="p-6">
                <p className="text-[10px] text-primary font-black uppercase tracking-[0.2em] mb-2">{product.category || 'Fresh'}</p>
                <h3 className="font-black text-xl truncate mb-3 group-hover:text-primary transition-colors leading-tight">{product.product_name}</h3>
                <div className="flex items-center justify-between mt-6">
                  <div>
                    <p className="text-2xl font-black tracking-tighter">₹{(product.price || 0).toLocaleString('en-IN')}</p>
                    <p className="text-[10px] text-muted-foreground font-bold">Qty: {product.quantity || 0}</p>
                  </div>
                  <Button
                    onClick={() => addToCart && addToCart(product)}
                    disabled={(product.quantity || 0) === 0}
                    size="icon"
                    className="h-12 w-12 rounded-2xl shadow-xl shadow-primary/20 group-hover:rotate-90 transition-transform duration-500"
                  >
                    <Plus className="h-6 w-6 stroke-[3]" />
                  </Button>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </section>

      {/* --- STAFF/ADMIN TOOLS --- */}
      {(isAdmin || isStaff) && (
        <section className="pt-16 border-t border-dashed border-border/50 animate-in fade-in slide-in-from-bottom-5 duration-700">
          <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12">
            <div>
              <h2 className="text-4xl font-black tracking-tight flex items-center gap-4">
                <Truck className="h-10 w-10 text-primary" /> Supply Chain Center
              </h2>
              <p className="text-muted-foreground mt-2 font-medium italic">Operations & Inventory Management Dashboard</p>
            </div>
            {(dashboard.activeAlertsCount || 0) > 0 && (
              <Badge variant="destructive" className="gap-2 px-6 py-2.5 rounded-full font-black animate-pulse shadow-xl shadow-destructive/20">
                <AlertTriangle className="h-4 w-4" />
                {dashboard.activeAlertsCount} CRITICAL ALERTS
              </Badge>
            )}
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
            {(statCards || []).map((stat, idx) => {
              const Icon = stat?.icon || Package;
              return (
                <Card key={stat?.title || idx} className="bg-card border-border/50 hover:shadow-2xl transition-all duration-500 group rounded-3xl overflow-hidden border-2">
                  <CardContent className="p-6">
                    <div className="flex items-center justify-between">
                      <div className="space-y-1">
                        <p className="text-[10px] text-muted-foreground font-black uppercase tracking-[0.2em]">{stat?.title}</p>
                        <p className="text-3xl font-black tabular-nums tracking-tighter">
                          <SafeNumber value={stat?.value} />
                        </p>
                      </div>
                      <div className={`p-4 rounded-2xl ${stat?.bg || ''} ${stat?.color || ''} group-hover:rotate-12 group-hover:scale-110 transition-all duration-500 shadow-inner`}>
                        <Icon className="h-6 w-6 stroke-[2.5]" />
                      </div>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-[1.5fr_1fr] gap-10">
            {/* Restock Required (Staff Feature) */}
            <Card className="glass-card rounded-[3rem] border-border/50 overflow-hidden shadow-sm border-2">
              <CardHeader className="bg-muted/30 border-b border-border/50 p-8 flex flex-row items-center justify-between">
                <div>
                  <CardTitle className="text-2xl font-black">Restock Required</CardTitle>
                  <CardDescription className="font-bold flex items-center gap-1 mt-1">Items below reorder level <Sparkles className="h-3 w-3 text-orange-400" /></CardDescription>
                </div>
                <Truck className="h-8 w-8 opacity-20" />
              </CardHeader>
              <CardContent className="p-4">
                {refillItems.length > 0 ? (
                  <div className="space-y-4">
                    {refillItems.map((item) => (
                      <div key={item.id} className="flex flex-col sm:flex-row items-center justify-between p-6 rounded-[2rem] bg-secondary/20 border border-border/20 group hover:border-primary/40 transition-all duration-300 gap-4">
                        <div className="flex items-center gap-5 w-full">
                           <div className="h-16 w-16 rounded-2xl bg-background flex items-center justify-center overflow-hidden shadow-inner border border-border/10 shrink-0">
                              {item.image_url ? <img src={item.image_url} alt={item.product_name} className="h-full w-full object-cover" /> : <Package className="h-8 w-8 opacity-20" />}
                           </div>
                           <div className="min-w-0">
                              <p className="text-[10px] font-black uppercase text-primary tracking-widest leading-none mb-1">{item.category}</p>
                              <p className="font-black text-lg truncate uppercase tracking-tighter">{item.product_name}</p>
                              <div className="flex items-center gap-4 mt-1">
                                <p className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
                                  CURRENT: <span className={`text-sm ${item.quantity <= 0 ? 'text-destructive' : 'text-orange-500'}`}>{item.quantity}</span>
                                </p>
                                <p className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
                                  LEVEL: <span className="text-secondary-foreground">{item.reorder_level}</span>
                                </p>
                              </div>
                           </div>
                        </div>
                        <Button 
                          onClick={() => handleQuickRefill(item.id, item.quantity)}
                          disabled={refillLoading === item.id}
                          className="w-full sm:w-auto rounded-2xl h-14 px-8 font-black gap-2 shadow-lg shadow-primary/10 relative overflow-hidden group/btn"
                        >
                          {refillLoading === item.id ? (
                            <Loader2 className="h-5 w-5 animate-spin" />
                          ) : (
                            <>
                              <Plus className="h-5 w-5 group-hover/btn:scale-125 transition-transform" /> 
                              Restock 50
                            </>
                          )}
                        </Button>
                      </div>
                    ))}
                    <div className="p-4">
                       <Button asChild variant="outline" className="w-full h-12 rounded-xl font-bold border-dashed border-2">
                          <Link to="/products">View All Inventory <ArrowRight className="ml-2 h-4 w-4" /></Link>
                       </Button>
                    </div>
                  </div>
                ) : (
                  <div className="py-24 text-center space-y-4">
                    <div className="h-20 w-20 bg-success/10 rounded-full flex items-center justify-center mx-auto">
                       <CheckCircle2 className="h-10 w-10 text-success" />
                    </div>
                    <p className="text-xl font-black text-muted-foreground italic">Full capacity. No restock needed.</p>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Movements Sidebar */}
            <Card className="glass-card rounded-[3rem] border-border/50 overflow-hidden shadow-sm border-2">
              <CardHeader className="bg-muted/30 border-b border-border/50 p-8">
                <CardTitle className="text-2xl font-black flex items-center justify-between">
                  Activity Feed <RotateCcw className="h-5 w-5 opacity-20" />
                </CardTitle>
                <CardDescription className="font-bold">Real-time stock movements</CardDescription>
              </CardHeader>
              <CardContent className="p-4">
                {Array.isArray(dashboard.recentTransactions) && dashboard.recentTransactions.length > 0 ? (
                  <div className="space-y-2">
                    {dashboard.recentTransactions.slice(0, 8).map((tx) => {
                      if (!tx || !tx.id) return null;
                      let timeStr = '';
                      try {
                        timeStr = tx.created_at ? new Date(tx.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : '';
                      } catch {
                        timeStr = '';
                      }
                      return (
                        <div key={tx.id} className="flex items-center justify-between p-4 rounded-2xl hover:bg-secondary/50 transition-colors border border-transparent hover:border-border/50 group/item">
                          <div className="flex items-center gap-4">
                            <div className={`w-3 h-3 rounded-full ${tx.type === 'purchase' ? 'bg-primary' : 'bg-green-500'} shadow-sm group-hover/item:scale-150 transition-transform duration-500`} />
                            <div>
                              <p className="text-sm font-black truncate max-w-[150px] uppercase tracking-tighter">
                                {tx.products?.product_name || 'Stock Update'}
                              </p>
                              <p className="text-[10px] text-muted-foreground font-bold">{timeStr} • {tx.type}</p>
                            </div>
                          </div>
                          <Badge variant={tx.type === 'purchase' ? 'default' : 'secondary'} className="rounded-lg h-7 px-3 font-black text-[10px] uppercase">
                            {tx.type === 'purchase' ? '+' : '-'}{tx.quantity || 0}
                          </Badge>
                        </div>
                      );
                    })}
                  </div>
                ) : (
                  <div className="py-20 text-center text-muted-foreground italic font-black opacity-20 uppercase tracking-widest h-full flex items-center justify-center">
                    Feed Inactive
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </section>
      )}
    </div>
  );
}
