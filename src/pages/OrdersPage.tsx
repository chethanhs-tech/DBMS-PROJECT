import { useState, useMemo } from 'react';
import { useOrders, type Order } from '@/hooks/useOrders';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Search, FileText, IndianRupee, ShoppingBag, ArrowUpDown } from 'lucide-react';
import { Skeleton } from '@/components/ui/skeleton';
import InvoiceView from '@/components/InvoiceView';

type SortKey = 'created_at' | 'total_price' | 'quantity';
type SortDir = 'asc' | 'desc';

export default function OrdersPage() {
  const { orders, loading } = useOrders();
  const [search, setSearch] = useState('');
  const [sortKey, setSortKey] = useState<SortKey>('created_at');
  const [sortDir, setSortDir] = useState<SortDir>('desc');
  const [invoiceOrder, setInvoiceOrder] = useState<Order | null>(null);

  const toggleSort = (key: SortKey) => {
    if (sortKey === key) setSortDir(d => d === 'asc' ? 'desc' : 'asc');
    else { setSortKey(key); setSortDir('desc'); }
  };

  const filtered = useMemo(() => {
    let list = orders.filter(o =>
      o.product_name.toLowerCase().includes(search.toLowerCase()) ||
      o.invoice_number.toLowerCase().includes(search.toLowerCase())
    );
    list.sort((a, b) => {
      const aVal = a[sortKey];
      const bVal = b[sortKey];
      let cmp: number;
      if (sortKey === 'created_at') cmp = new Date(aVal).getTime() - new Date(bVal).getTime();
      else cmp = (aVal as number) - (bVal as number);
      return sortDir === 'asc' ? cmp : -cmp;
    });
    return list;
  }, [orders, search, sortKey, sortDir]);

  const SortHeader = ({ label, field }: { label: string; field: SortKey }) => (
    <button onClick={() => toggleSort(field)} className="flex items-center gap-1 hover:text-foreground transition-colors">
      {label}
      <ArrowUpDown className={`h-3 w-3 ${sortKey === field ? 'text-primary' : 'opacity-30'}`} />
    </button>
  );

  if (loading) {
    return (
      <div className="space-y-6">
        <h1 className="text-2xl font-bold">Orders</h1>
        <Skeleton className="h-96 rounded-xl" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Orders</h1>
          <p className="text-sm text-muted-foreground mt-1">{orders.length} total orders</p>
        </div>
      </div>

      <div className="relative max-w-sm">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input placeholder="Search orders..." value={search} onChange={e => setSearch(e.target.value)} className="pl-9" />
      </div>

      <Card className="glass-card overflow-hidden">
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow className="bg-muted/30">
                <TableHead>Invoice</TableHead>
                <TableHead>Product</TableHead>
                <TableHead className="text-center"><SortHeader label="Qty" field="quantity" /></TableHead>
                <TableHead className="text-right"><SortHeader label="Total" field="total_price" /></TableHead>
                <TableHead>Payment</TableHead>
                <TableHead><SortHeader label="Date" field="created_at" /></TableHead>
                <TableHead>Status</TableHead>
                <TableHead className="text-right">Invoice</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={8} className="text-center py-12">
                    <ShoppingBag className="h-8 w-8 mx-auto text-muted-foreground/30 mb-2" />
                    <p className="text-muted-foreground">No orders found</p>
                  </TableCell>
                </TableRow>
              ) : (
                filtered.map(o => (
                  <TableRow key={o.id} className="group hover:bg-muted/30 transition-colors">
                    <TableCell>
                      <code className="text-xs bg-muted px-1.5 py-0.5 rounded font-mono">{o.invoice_number}</code>
                    </TableCell>
                    <TableCell className="font-medium">{o.product_name}</TableCell>
                    <TableCell className="text-center tabular-nums">{o.quantity}</TableCell>
                    <TableCell className="text-right font-medium tabular-nums">
                      <span className="flex items-center justify-end"><IndianRupee className="h-3 w-3" />{o.total_price.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
                    </TableCell>
                    <TableCell><Badge variant="secondary" className="text-xs capitalize">{o.payment_method}</Badge></TableCell>
                    <TableCell className="text-sm text-muted-foreground">
                      {new Date(o.created_at).toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })}
                    </TableCell>
                    <TableCell>
                      <Badge className="bg-success/10 text-success border-0 text-xs">Completed</Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      <Button variant="ghost" size="sm" className="gap-1.5 text-xs" onClick={() => setInvoiceOrder(o)}>
                        <FileText className="h-3.5 w-3.5" />
                        View
                      </Button>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>

      <InvoiceView order={invoiceOrder} open={!!invoiceOrder} onOpenChange={(open) => { if (!open) setInvoiceOrder(null); }} />
    </div>
  );
}
