import { useMemo } from 'react';
import { useProducts } from './useProducts';
import { useTransactions } from './useTransactions';
import { useAlerts } from './useAlerts';

export function useDashboardData() {
  const { products = [], loading: productsLoading = true } = useProducts() || {};
  const { transactions = [], loading: transactionsLoading = true } = useTransactions() || {};
  const { alerts = [], loading: alertsLoading = true } = useAlerts() || {};

  const stats = useMemo(() => {
    if (!products || productsLoading) return null;
    
    try {
      const safeProducts = Array.isArray(products) ? products.filter(Boolean) : [];
      const safeTransactions = Array.isArray(transactions) ? transactions.filter(Boolean) : [];
      const safeAlerts = Array.isArray(alerts) ? alerts.filter(Boolean) : [];

      const totalProducts = safeProducts.length;
      const lowStockItems = safeProducts.filter(p => p && p.quantity <= (p.reorder_level || 0));
      
      const salesTransactions = safeTransactions.filter(t => t && t.type === 'sale');
      const totalSales = salesTransactions.reduce((sum, t) => sum + (t.quantity || 0), 0);
      
      const purchaseTransactions = safeTransactions.filter(t => t && t.type === 'purchase');
      const totalPurchases = purchaseTransactions.reduce((sum, t) => sum + (t.quantity || 0), 0);
      
      const activeAlerts = safeAlerts.filter(a => a && a.status === 'active');
      const recentTransactions = safeTransactions.slice(0, 10);

      const reorderSuggestions = lowStockItems.map(product => {
        if (!product) return null;
        const salesForProduct = safeTransactions.filter(
          t => t && t.product_id === product.id && t.type === 'sale'
        );
        const avgSale = salesForProduct.length > 0
          ? salesForProduct.reduce((sum, t) => sum + (t.quantity || 0), 0) / salesForProduct.length
          : 5;
        const suggestedQuantity = Math.max(Math.ceil(avgSale * 3), (product.reorder_level || 5) * 2);
        return {
          product,
          suggestedQuantity,
          avgSale: Math.round(avgSale),
        };
      }).filter(Boolean);

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
    } catch (err) {
      console.error('Error calculating dashboard stats:', err);
      return {
        totalProducts: 0,
        lowStockItems: [],
        lowStockCount: 0,
        totalSales: 0,
        totalPurchases: 0,
        activeAlerts: [],
        activeAlertsCount: 0,
        recentTransactions: [],
        reorderSuggestions: [],
      };
    }
  }, [products, transactions, alerts]);

  return {
    ...stats,
    loading: productsLoading || transactionsLoading || alertsLoading,
  };
}
