import { useDashboardData } from '@/hooks/useDashboardData';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Package, AlertTriangle, TrendingUp, TrendingDown, ShoppingCart, ArrowUpDown, Activity } from 'lucide-react';
import { Skeleton } from '@/components/ui/skeleton';
import AnimatedCounter from '@/components/AnimatedCounter';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, PieChart, Pie, Cell } from 'recharts';
import { useMemo } from 'react';

const CHART_COLORS = [
  'hsl(221, 83%, 53%)',
  'hsl(142, 76%, 36%)',
  'hsl(38, 92%, 50%)',
  'hsl(0, 84%, 60%)',
  'hsl(270, 76%, 53%)',
  'hsl(180, 70%, 45%)',
];

export default function DashboardPage() {
  const {
    totalProducts, lowStockCount, totalSales, totalPurchases,
    activeAlertsCount, recentTransactions, reorderSuggestions, loading,
    lowStockItems,
  } = useDashboardData();

  // Build chart data from transactions
  const { salesByDay, categoryData } = useMemo(() => {
    const days: Record<string, { sales: number; purchases: number }> = {};
    const cats: Record<string, number> = {};

    recentTransactions.forEach(tx => {
      const day = new Date(tx.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
      if (!days[day]) days[day] = { sales: 0, purchases: 0 };
      if (tx.type === 'sale') days[day].sales += tx.quantity;
      else days[day].purchases += tx.quantity;
    });

    // Use lowStockItems for category breakdown (from all products via dashboard data)
    return {
      salesByDay: Object.entries(days).map(([name, v]) => ({ name, ...v })).slice(-7),
      categoryData: Object.entries(cats).map(([name, value]) => ({ name, value })),
    };
  }, [recentTransactions, lowStockItems]);

  if (loading) {
    return (
      <div className="space-y-6">
        <h1 className="text-2xl font-bold">Dashboard</h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {[1,2,3,4].map(i => <Skeleton key={i} className="h-32 rounded-xl" />)}
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Skeleton className="h-80 rounded-xl" />
          <Skeleton className="h-80 rounded-xl" />
        </div>
      </div>
    );
  }

  const statCards = [
    { title: 'Total Products', value: totalProducts, icon: Package, color: 'text-primary', bg: 'bg-primary/10' },
    { title: 'Low Stock Items', value: lowStockCount, icon: AlertTriangle, color: 'text-warning', bg: 'bg-warning/10' },
    { title: 'Total Sales', value: totalSales, icon: TrendingUp, color: 'text-success', bg: 'bg-success/10' },
    { title: 'Total Purchases', value: totalPurchases, icon: ShoppingCart, color: 'text-primary', bg: 'bg-primary/10' },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Dashboard</h1>
          <p className="text-sm text-muted-foreground mt-1">Overview of your inventory metrics</p>
        </div>
        {activeAlertsCount > 0 && (
          <Badge variant="destructive" className="gap-1 animate-pulse">
            <AlertTriangle className="h-3 w-3" />
            {activeAlertsCount} Active Alert{activeAlertsCount > 1 ? 's' : ''}
          </Badge>
        )}
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {statCards.map((stat, i) => (
          <Card key={stat.title} className="glass-card stat-card-gradient hover:shadow-md transition-all duration-300 hover:-translate-y-0.5" style={{ animationDelay: `${i * 100}ms` }}>
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground font-medium">{stat.title}</p>
                  <p className="text-3xl font-bold mt-1 animate-count">
                    <AnimatedCounter value={stat.value} />
                  </p>
                </div>
                <div className={`p-3 rounded-xl ${stat.bg} ${stat.color} transition-transform duration-300 hover:scale-110`}>
                  <stat.icon className="h-5 w-5" />
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Charts Row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Sales & Purchases Trend */}
        <Card className="glass-card">
          <CardHeader>
            <CardTitle className="text-lg flex items-center gap-2">
              <Activity className="h-4 w-4 text-primary" />
              Transaction Trends
            </CardTitle>
            <CardDescription>Sales vs purchases over recent transactions</CardDescription>
          </CardHeader>
          <CardContent>
            {salesByDay.length === 0 ? (
              <div className="h-52 flex items-center justify-center text-muted-foreground text-sm">
                No transaction data to display
              </div>
            ) : (
              <ResponsiveContainer width="100%" height={220}>
                <AreaChart data={salesByDay}>
                  <defs>
                    <linearGradient id="salesGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="hsl(142, 76%, 36%)" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="hsl(142, 76%, 36%)" stopOpacity={0} />
                    </linearGradient>
                    <linearGradient id="purchGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="hsl(221, 83%, 53%)" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="hsl(221, 83%, 53%)" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" className="stroke-border" />
                  <XAxis dataKey="name" className="text-xs" tick={{ fill: 'hsl(215, 16%, 47%)' }} />
                  <YAxis className="text-xs" tick={{ fill: 'hsl(215, 16%, 47%)' }} />
                  <Tooltip
                    contentStyle={{
                      backgroundColor: 'hsl(var(--card))',
                      border: '1px solid hsl(var(--border))',
                      borderRadius: '0.5rem',
                      fontSize: '0.875rem',
                    }}
                  />
                  <Area type="monotone" dataKey="sales" stroke="hsl(142, 76%, 36%)" fill="url(#salesGrad)" strokeWidth={2} />
                  <Area type="monotone" dataKey="purchases" stroke="hsl(221, 83%, 53%)" fill="url(#purchGrad)" strokeWidth={2} />
                </AreaChart>
              </ResponsiveContainer>
            )}
          </CardContent>
        </Card>

        {/* Recent Transactions */}
        <Card className="glass-card">
          <CardHeader>
            <CardTitle className="text-lg flex items-center gap-2">
              <ArrowUpDown className="h-4 w-4 text-primary" />
              Recent Transactions
            </CardTitle>
            <CardDescription>Latest inventory movements</CardDescription>
          </CardHeader>
          <CardContent>
            {recentTransactions.length === 0 ? (
              <p className="text-sm text-muted-foreground">No transactions yet</p>
            ) : (
              <div className="space-y-2 max-h-56 overflow-y-auto pr-1">
                {recentTransactions.slice(0, 8).map((tx, i) => (
                  <div
                    key={tx.id}
                    className="flex items-center justify-between py-2.5 px-3 rounded-lg hover:bg-muted/50 transition-all duration-200 border border-transparent hover:border-border/50"
                    style={{ animationDelay: `${i * 50}ms` }}
                  >
                    <div className="flex items-center gap-3">
                      <div className={`w-2 h-2 rounded-full ${tx.type === 'purchase' ? 'bg-primary' : 'bg-success'}`} />
                      <div>
                        <p className="text-sm font-medium">{tx.products?.product_name || 'Unknown'}</p>
                        <p className="text-xs text-muted-foreground">
                          {new Date(tx.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })}
                        </p>
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge variant={tx.type === 'purchase' ? 'default' : 'secondary'} className="text-xs">
                        {tx.type}
                      </Badge>
                      <span className={`text-sm font-semibold ${tx.type === 'purchase' ? 'text-primary' : 'text-success'}`}>
                        {tx.type === 'purchase' ? '+' : '-'}{tx.quantity}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Bottom Row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Low Stock Items */}
        <Card className="glass-card">
          <CardHeader>
            <CardTitle className="text-lg flex items-center gap-2">
              <AlertTriangle className="h-4 w-4 text-destructive" />
              Low Stock Items
            </CardTitle>
            <CardDescription>Products below reorder threshold</CardDescription>
          </CardHeader>
          <CardContent>
            {lowStockItems.length === 0 ? (
              <div className="text-center py-6 text-muted-foreground">
                <Package className="h-8 w-8 mx-auto mb-2 opacity-30" />
                <p className="text-sm">All products are well stocked!</p>
              </div>
            ) : (
              <div className="space-y-2">
                {lowStockItems.slice(0, 5).map(item => {
                  const pct = Math.round((item.quantity / item.reorder_level) * 100);
                  return (
                    <div key={item.id} className="flex items-center gap-3 p-3 rounded-lg bg-destructive/5 border border-destructive/10 hover:border-destructive/20 transition-all duration-200">
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium truncate">{item.product_name}</p>
                        <div className="flex items-center gap-2 mt-1">
                          <div className="flex-1 h-1.5 rounded-full bg-muted overflow-hidden">
                            <div
                              className="h-full rounded-full bg-destructive transition-all duration-500"
                              style={{ width: `${Math.min(pct, 100)}%` }}
                            />
                          </div>
                          <span className="text-xs text-destructive font-medium whitespace-nowrap">{item.quantity}/{item.reorder_level}</span>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Smart Reorder Suggestions */}
        <Card className="glass-card">
          <CardHeader>
            <CardTitle className="text-lg flex items-center gap-2">
              <TrendingDown className="h-4 w-4 text-warning" />
              Reorder Suggestions
            </CardTitle>
            <CardDescription>AI-powered restocking recommendations</CardDescription>
          </CardHeader>
          <CardContent>
            {reorderSuggestions.length === 0 ? (
              <div className="text-center py-6 text-muted-foreground">
                <TrendingUp className="h-8 w-8 mx-auto mb-2 opacity-30" />
                <p className="text-sm">All products are well stocked!</p>
              </div>
            ) : (
              <div className="space-y-2">
                {reorderSuggestions.map(item => (
                  <div key={item.product.id} className="p-3 rounded-lg bg-muted/50 border border-border/50 hover:border-primary/20 hover:shadow-sm transition-all duration-200">
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="text-sm font-medium">{item.product.product_name}</p>
                        <p className="text-xs text-muted-foreground mt-0.5">
                          Current: <span className="text-destructive font-medium">{item.product.quantity}</span> · Reorder at: {item.product.reorder_level}
                        </p>
                      </div>
                      <div className="text-right">
                        <p className="text-sm font-bold text-primary">Order {item.suggestedQuantity}</p>
                        <p className="text-xs text-muted-foreground">Avg {item.avgSale}/tx</p>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
