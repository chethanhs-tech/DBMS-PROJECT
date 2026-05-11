import { useEffect } from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Route, Routes, Navigate, useLocation } from "react-router-dom";
import { toast } from "sonner";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import { AuthProvider, useAuth } from "@/contexts/AuthContext";
import { CartProvider } from "@/contexts/CartContext";
import AppLayout from "@/components/AppLayout";
import ErrorBoundary from "@/components/ErrorBoundary";
import AuthPage from "@/pages/AuthPage";
import DashboardPage from "@/pages/DashboardPage";
import ShopPage from "@/pages/ShopPage";
import CartPage from "@/pages/CartPage";
import ProductsPage from "@/pages/ProductsPage";
import OrdersPage from "@/pages/OrdersPage";
import TransactionsPage from "@/pages/TransactionsPage";
import AuditAuto from "@/pages/AuditAuto";
import SuppliersPage from "@/pages/SuppliersPage";
import AlertsPage from "@/pages/AlertsPage";
import ProfilePage from "@/pages/ProfilePage";
import AdminUsersPage from "@/pages/AdminUsersPage";
import NotFound from "./pages/NotFound.tsx";
import SystemInitializer from "@/components/SystemInitializer";
import SeedCatalogPage from "./pages/SeedCatalogPage";
import ForgotPasswordPage from "@/pages/ForgotPasswordPage";
import ResetPasswordPage from "@/pages/ResetPasswordPage";
import AuthCallback from "@/pages/AuthCallback";

const queryClient = new QueryClient();

/**
 * ProtectedRoute — wraps content in layout + error boundary.
 * `allowedRoles` specifies which roles can access this route.
 */
function ProtectedRoute({
  children,
  allowedRoles,
}: {
  children: React.ReactNode;
  allowedRoles?: ('admin' | 'staff' | 'customer')[];
}) {
  const { user, isAdmin, isStaff, isCustomer, loading } = useAuth();

  if (loading) {
    return (
      <div className="flex h-screen items-center justify-center text-muted-foreground">
        <div className="flex flex-col items-center gap-3">
          <div className="h-8 w-8 border-4 border-primary/30 border-t-primary rounded-full animate-spin" />
          <p className="text-sm font-bold">Loading GrozoSphere...</p>
        </div>
      </div>
    );
  }

  if (!user) return <Navigate to="/auth" replace state={{ sessionExpired: true }} />;

  // Role check
  if (allowedRoles) {
    const userRoles: string[] = [];
    if (isAdmin) userRoles.push('admin');
    if (isStaff) userRoles.push('staff');
    if (isCustomer) userRoles.push('customer');
    const hasAccess = allowedRoles.some(r => userRoles.includes(r));
    if (!hasAccess) return <Navigate to="/" replace />;
  }

  return (
    <ErrorBoundary>
      <AppLayout>
        <ErrorBoundary>{children}</ErrorBoundary>
      </AppLayout>
    </ErrorBoundary>
  );
}

function AuthRoute() {
  const { user, loading } = useAuth();
  const location = useLocation();

  useEffect(() => {
    if (location.state?.sessionExpired) {
      toast.error("Session expired. Please login again.");
      // Clear the state so it doesn't fire again on refresh
      window.history.replaceState({}, document.title);
    }
  }, [location]);

  if (loading) {
    return (
      <div className="flex h-screen items-center justify-center text-muted-foreground">
        <div className="flex flex-col items-center gap-3">
          <div className="h-8 w-8 border-4 border-primary/30 border-t-primary rounded-full animate-spin" />
          <p className="text-sm font-bold">Loading...</p>
        </div>
      </div>
    );
  }
  if (user) return <Navigate to="/" replace />;
  return <AuthPage />;
}

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <SystemInitializer />
      <Toaster />
      <Sonner />
      <BrowserRouter>
        <AuthProvider>
          <CartProvider>
            <Routes>
              {/* Public */}
              <Route path="/auth" element={<AuthRoute />} />
              <Route path="/forgot-password" element={<ForgotPasswordPage />} />
              <Route path="/reset-password" element={<ResetPasswordPage />} />
              <Route path="/auth/callback" element={<AuthCallback />} />

              {/* Everyone (all authenticated users) */}
              <Route path="/" element={<ProtectedRoute><DashboardPage /></ProtectedRoute>} />
              <Route path="/shop" element={<ProtectedRoute><ShopPage /></ProtectedRoute>} />
              <Route path="/cart" element={<ProtectedRoute><CartPage /></ProtectedRoute>} />
              <Route path="/profile" element={<ProtectedRoute><ProfilePage /></ProtectedRoute>} />
              <Route path="/orders" element={<ProtectedRoute><OrdersPage /></ProtectedRoute>} />
              <Route path="/internal-e2e-audit" element={<AuditAuto />} />

              {/* Staff + Admin only */}
              <Route path="/products" element={<ProtectedRoute allowedRoles={['admin', 'staff']}><ProductsPage /></ProtectedRoute>} />
              <Route path="/transactions" element={<ProtectedRoute allowedRoles={['admin', 'staff']}><TransactionsPage /></ProtectedRoute>} />
              <Route path="/suppliers" element={<ProtectedRoute allowedRoles={['admin', 'staff']}><SuppliersPage /></ProtectedRoute>} />
              <Route path="/alerts" element={<ProtectedRoute allowedRoles={['admin', 'staff']}><AlertsPage /></ProtectedRoute>} />

              {/* Admin only */}
              <Route path="/admin/users" element={<ProtectedRoute allowedRoles={['admin']}><AdminUsersPage /></ProtectedRoute>} />

          <Route
            path="/admin/seed-catalog"
            element={
              <ProtectedRoute allowedRoles={['admin', 'staff']}>
                <SeedCatalogPage />
              </ProtectedRoute>
            }
          />

          <Route path="*" element={<NotFound />} />
            </Routes>
          </CartProvider>
        </AuthProvider>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
