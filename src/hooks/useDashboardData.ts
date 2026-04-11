import { useMemo } from 'react';
import { useProducts } from './useProducts';
import { useTransactions } from './useTransactions';
import { useAlerts } from './useAlerts';

export function useDashboardData() {
  const { products, loading: productsLoading } = useProducts();
  const { transactions, loading: transactionsLoading } = useTransactions();
  const { alerts, loading: alertsLoading } = useAlerts();

  const stats = useMemo(() => {
    const totalProducts = products.length;
    const lowStockItems = products.filter(p => p.quantity <= p.reorder_level);
    const totalSales = transactions
      .filter(t => t.type === 'sale')
      .reduce((sum, t) => sum + t.quantity, 0);
    const totalPurchases = transactions
      .filter(t => t.type === 'purchase')
      .reduce((sum, t) => sum + t.quantity, 0);
    const activeAlerts = alerts.filter(a => a.status === 'active');
    const recentTransactions = transactions.slice(0, 10);

    // Smart reorder suggestions
    const reorderSuggestions = lowStockItems.map(product => {
      const salesForProduct = transactions.filter(
        t => t.product_id === product.id && t.type === 'sale'
      );
      const avgSale = salesForProduct.length > 0
        ? salesForProduct.reduce((sum, t) => sum + t.quantity, 0) / salesForProduct.length
        : 10;
      const suggestedQuantity = Math.max(Math.ceil(avgSale * 3), product.reorder_level * 2);
      return {
        product,
        suggestedQuantity,
        avgSale: Math.round(avgSale),
      };
    });

    return {
      totalProducts,
      lowStockItems,
      lowStockCount: lowStockItems.length,
      totalSales,
      totalPurchases,
      activeAlerts,
      activeAlertsCount: activeAlerts.length,
      recentTransactions,
      reorderSuggestions,
    };
  }, [products, transactions, alerts]);

  return {
    ...stats,
    loading: productsLoading || transactionsLoading || alertsLoading,
  };
}
