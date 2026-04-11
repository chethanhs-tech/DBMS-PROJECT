import { useAlerts } from '@/hooks/useAlerts';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Bell, CheckCircle, AlertTriangle, ShieldAlert } from 'lucide-react';

export default function AlertsPage() {
  const { alerts, loading, resolveAlert } = useAlerts();
  const { isAdmin } = useAuth();

  const activeAlerts = alerts.filter(a => a.status === 'active');
  const resolvedAlerts = alerts.filter(a => a.status === 'resolved');

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Alerts</h1>
        <p className="text-sm text-muted-foreground mt-1">
          {activeAlerts.length} active · {resolvedAlerts.length} resolved
        </p>
      </div>

      {loading ? (
        <p className="text-muted-foreground">Loading...</p>
      ) : alerts.length === 0 ? (
        <Card className="glass-card">
          <CardContent className="p-12 text-center">
            <Bell className="h-12 w-12 mx-auto text-muted-foreground/20 mb-4" />
            <p className="text-lg font-medium text-muted-foreground">No alerts</p>
            <p className="text-sm text-muted-foreground/70 mt-1">All products are well stocked</p>
          </CardContent>
        </Card>
      ) : (
        <>
          {activeAlerts.length > 0 && (
            <div className="space-y-3">
              <div className="flex items-center gap-2">
                <ShieldAlert className="h-4 w-4 text-destructive" />
                <h2 className="text-lg font-semibold">Active Alerts ({activeAlerts.length})</h2>
              </div>
              {activeAlerts.map((alert, i) => (
                <Card
                  key={alert.id}
                  className="glass-card border-destructive/20 hover:border-destructive/40 transition-all duration-300 hover:shadow-sm"
                  style={{ animationDelay: `${i * 50}ms` }}
                >
                  <CardContent className="p-4 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2 rounded-lg bg-destructive/10 animate-pulse">
                        <AlertTriangle className="h-4 w-4 text-destructive" />
                      </div>
                      <div>
                        <p className="text-sm font-medium">{alert.message}</p>
                        <p className="text-xs text-muted-foreground mt-0.5">
                          {new Date(alert.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit' })}
                        </p>
                      </div>
                    </div>
                    {isAdmin && (
                      <Button variant="outline" size="sm" onClick={() => resolveAlert(alert.id)} className="shrink-0 gap-1.5 hover:bg-success/10 hover:text-success hover:border-success/30 transition-all duration-200">
                        <CheckCircle className="h-3.5 w-3.5" />
                        Resolve
                      </Button>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}

          {resolvedAlerts.length > 0 && (
            <div className="space-y-3">
              <h2 className="text-lg font-semibold text-muted-foreground">Resolved ({resolvedAlerts.length})</h2>
              {resolvedAlerts.map(alert => (
                <Card key={alert.id} className="glass-card opacity-60 hover:opacity-80 transition-opacity duration-200">
                  <CardContent className="p-4 flex items-center gap-3">
                    <div className="p-2 rounded-lg bg-muted">
                      <CheckCircle className="h-4 w-4 text-success" />
                    </div>
                    <div className="flex-1">
                      <p className="text-sm">{alert.message}</p>
                      <p className="text-xs text-muted-foreground mt-0.5">
                        {new Date(alert.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
                      </p>
                    </div>
                    <Badge variant="secondary" className="bg-success/10 text-success border-0 text-xs">Resolved</Badge>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}
