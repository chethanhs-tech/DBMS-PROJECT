import { useDashboardData } from '@/hooks/useDashboardData';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Package, AlertTriangle, TrendingUp, TrendingDown, ShoppingCart, ArrowUpDown } from 'lucide-react';
import { Skeleton } from '@/components/ui/skeleton';

export default function DashboardPage() {
  const {
    totalProducts, lowStockCount, totalSales, totalPurchases,
    activeAlertsCount, recentTransactions, reorderSuggestions, loading,
  } = useDashboardData();

  if (loading) {
    return (
      <div className="space-y-6">
        <h1 className="text-2xl font-bold">Dashboard</h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {[1,2,3,4].map(i => <Skeleton key={i} className="h-32 rounded-xl" />)}
        </div>
      </div>
    );
  }

  const statCards = [
    { title: 'Total Products', value: totalProducts, icon: Package, color: 'text-primary' },
    { title: 'Low Stock Items', value: lowStockCount, icon: AlertTriangle, color: 'text-warning' },
    { title: 'Total Sales', value: totalSales, icon: TrendingUp, color: 'text-success' },
    { title: 'Total Purchases', value: totalPurchases, icon: ShoppingCart, color: 'text-primary' },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Dashboard</h1>
        {activeAlertsCount > 0 && (
          <Badge variant="destructive" className="gap-1">
            <AlertTriangle className="h-3 w-3" />
            {activeAlertsCount} Active Alert{activeAlertsCount > 1 ? 's' : ''}
          </Badge>
        )}
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {statCards.map(stat => (
          <Card key={stat.title}>
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground">{stat.title}</p>
                  <p className="text-3xl font-bold mt-1">{stat.value}</p>
                </div>
                <div className={`p-3 rounded-xl bg-muted ${stat.color}`}>
                  <stat.icon className="h-5 w-5" />
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Recent Transactions */}
        <Card>
          <CardHeader>
            <CardTitle className="text-lg flex items-center gap-2">
              <ArrowUpDown className="h-4 w-4" />
              Recent Transactions
            </CardTitle>
          </CardHeader>
          <CardContent>
            {recentTransactions.length === 0 ? (
              <p className="text-sm text-muted-foreground">No transactions yet</p>
            ) : (
              <div className="space-y-3">
                {recentTransactions.map(tx => (
                  <div key={tx.id} className="flex items-center justify-between py-2 border-b last:border-0">
                    <div>
                      <p className="text-sm font-medium">{tx.products?.product_name || 'Unknown'}</p>
                      <p className="text-xs text-muted-foreground">
                        {new Date(tx.created_at).toLocaleDateString()}
                      </p>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge variant={tx.type === 'purchase' ? 'default' : 'secondary'}>
                        {tx.type}
                      </Badge>
                      <span className="text-sm font-medium">
                        {tx.type === 'purchase' ? '+' : '-'}{tx.quantity}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Smart Reorder Suggestions */}
        <Card>
          <CardHeader>
            <CardTitle className="text-lg flex items-center gap-2">
              <TrendingDown className="h-4 w-4 text-warning" />
              Reorder Suggestions
            </CardTitle>
            <CardDescription>Based on sales history and stock levels</CardDescription>
          </CardHeader>
          <CardContent>
            {reorderSuggestions.length === 0 ? (
              <p className="text-sm text-muted-foreground">All products are well stocked!</p>
            ) : (
              <div className="space-y-3">
                {reorderSuggestions.map(item => (
                  <div key={item.product.id} className="p-3 rounded-lg bg-muted/50 border">
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="text-sm font-medium">{item.product.product_name}</p>
                        <p className="text-xs text-muted-foreground">
                          Current: {item.product.quantity} | Reorder level: {item.product.reorder_level}
                        </p>
                      </div>
                      <div className="text-right">
                        <p className="text-sm font-bold text-primary">Order {item.suggestedQuantity}</p>
                        <p className="text-xs text-muted-foreground">Avg sale: {item.avgSale}/tx</p>
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
