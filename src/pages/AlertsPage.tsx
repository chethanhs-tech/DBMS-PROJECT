import { useAlerts } from '@/hooks/useAlerts';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Bell, CheckCircle } from 'lucide-react';

export default function AlertsPage() {
  const { alerts, loading, resolveAlert } = useAlerts();
  const { isAdmin } = useAuth();

  const activeAlerts = alerts.filter(a => a.status === 'active');
  const resolvedAlerts = alerts.filter(a => a.status === 'resolved');

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">Alerts</h1>

      {loading ? (
        <p className="text-muted-foreground">Loading...</p>
      ) : alerts.length === 0 ? (
        <Card>
          <CardContent className="p-12 text-center">
            <Bell className="h-12 w-12 mx-auto text-muted-foreground/30 mb-4" />
            <p className="text-muted-foreground">No alerts</p>
          </CardContent>
        </Card>
      ) : (
        <>
          {activeAlerts.length > 0 && (
            <div className="space-y-3">
              <h2 className="text-lg font-semibold text-destructive">Active Alerts ({activeAlerts.length})</h2>
              {activeAlerts.map(alert => (
                <Card key={alert.id} className="border-destructive/30">
                  <CardContent className="p-4 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2 rounded-lg bg-destructive/10">
                        <Bell className="h-4 w-4 text-destructive" />
                      </div>
                      <div>
                        <p className="text-sm font-medium">{alert.message}</p>
                        <p className="text-xs text-muted-foreground">{new Date(alert.created_at).toLocaleString()}</p>
                      </div>
                    </div>
                    {isAdmin && (
                      <Button variant="outline" size="sm" onClick={() => resolveAlert(alert.id)}>
                        <CheckCircle className="h-4 w-4 mr-1" />
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
                <Card key={alert.id} className="opacity-60">
                  <CardContent className="p-4 flex items-center gap-3">
                    <div className="p-2 rounded-lg bg-muted">
                      <CheckCircle className="h-4 w-4 text-muted-foreground" />
                    </div>
                    <div>
                      <p className="text-sm">{alert.message}</p>
                      <p className="text-xs text-muted-foreground">{new Date(alert.created_at).toLocaleString()}</p>
                    </div>
                    <Badge variant="secondary" className="ml-auto">Resolved</Badge>
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
