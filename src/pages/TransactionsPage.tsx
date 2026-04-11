import { useState, useMemo } from 'react';
import { useTransactions } from '@/hooks/useTransactions';
import { useProducts } from '@/hooks/useProducts';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Plus, Search, ArrowUpDown, ArrowLeftRight } from 'lucide-react';

type SortKey = 'created_at' | 'quantity';

export default function TransactionsPage() {
  const { transactions, loading, createTransaction } = useTransactions();
  const { products } = useProducts();
  const [dialogOpen, setDialogOpen] = useState(false);
  const [productId, setProductId] = useState('');
  const [type, setType] = useState<'purchase' | 'sale'>('purchase');
  const [quantity, setQuantity] = useState(1);
  const [search, setSearch] = useState('');
  const [filterType, setFilterType] = useState<string>('all');
  const [sortKey, setSortKey] = useState<SortKey>('created_at');
  const [sortDir, setSortDir] = useState<'asc' | 'desc'>('desc');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const success = await createTransaction(productId, type, quantity);
    if (success) { setDialogOpen(false); setProductId(''); setQuantity(1); }
  };

  const toggleSort = (key: SortKey) => {
    if (sortKey === key) setSortDir(d => d === 'asc' ? 'desc' : 'asc');
    else { setSortKey(key); setSortDir('desc'); }
  };

  const filtered = useMemo(() => {
    let list = transactions.filter(tx =>
      (tx.products?.product_name || '').toLowerCase().includes(search.toLowerCase())
    );
    if (filterType !== 'all') list = list.filter(tx => tx.type === filterType);
    list.sort((a, b) => {
      const cmp = sortKey === 'created_at'
        ? new Date(a.created_at).getTime() - new Date(b.created_at).getTime()
        : a.quantity - b.quantity;
      return sortDir === 'asc' ? cmp : -cmp;
    });
    return list;
  }, [transactions, search, filterType, sortKey, sortDir]);

  const totalSales = transactions.filter(t => t.type === 'sale').reduce((s, t) => s + t.quantity, 0);
  const totalPurchases = transactions.filter(t => t.type === 'purchase').reduce((s, t) => s + t.quantity, 0);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Transactions</h1>
          <p className="text-sm text-muted-foreground mt-1">
            {totalPurchases} purchased · {totalSales} sold · {transactions.length} total
          </p>
        </div>
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogTrigger asChild>
            <Button className="gap-2 shadow-sm"><Plus className="h-4 w-4" />New Transaction</Button>
          </DialogTrigger>
          <DialogContent>
            <DialogHeader><DialogTitle>New Transaction</DialogTitle></DialogHeader>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label>Product</Label>
                <Select value={productId} onValueChange={setProductId}>
                  <SelectTrigger><SelectValue placeholder="Select product" /></SelectTrigger>
                  <SelectContent>
                    {products.map(p => (
                      <SelectItem key={p.id} value={p.id}>{p.product_name} (Stock: {p.quantity})</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>Type</Label>
                <Select value={type} onValueChange={v => setType(v as 'purchase' | 'sale')}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="purchase">Purchase (Add Stock)</SelectItem>
                    <SelectItem value="sale">Sale (Remove Stock)</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>Quantity</Label>
                <Input type="number" value={quantity} onChange={e => setQuantity(parseInt(e.target.value) || 0)} min={1} required />
              </div>
              <Button type="submit" className="w-full">Record Transaction</Button>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <div className="flex flex-wrap items-center gap-3">
        <div className="relative flex-1 min-w-[200px] max-w-sm">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input placeholder="Search by product..." value={search} onChange={e => setSearch(e.target.value)} className="pl-9" />
        </div>
        <Select value={filterType} onValueChange={setFilterType}>
          <SelectTrigger className="w-[150px]">
            <SelectValue placeholder="All types" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Types</SelectItem>
            <SelectItem value="purchase">Purchases</SelectItem>
            <SelectItem value="sale">Sales</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <Card className="glass-card overflow-hidden">
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow className="bg-muted/30">
                <TableHead>
                  <button onClick={() => toggleSort('created_at')} className="flex items-center gap-1 hover:text-foreground transition-colors">
                    Date <ArrowUpDown className={`h-3 w-3 ${sortKey === 'created_at' ? 'text-primary' : 'opacity-30'}`} />
                  </button>
                </TableHead>
                <TableHead>Product</TableHead>
                <TableHead>Type</TableHead>
                <TableHead className="text-right">
                  <button onClick={() => toggleSort('quantity')} className="flex items-center gap-1 ml-auto hover:text-foreground transition-colors">
                    Quantity <ArrowUpDown className={`h-3 w-3 ${sortKey === 'quantity' ? 'text-primary' : 'opacity-30'}`} />
                  </button>
                </TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow><TableCell colSpan={4} className="text-center py-12 text-muted-foreground">Loading...</TableCell></TableRow>
              ) : filtered.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={4} className="text-center py-12">
                    <ArrowLeftRight className="h-8 w-8 mx-auto text-muted-foreground/30 mb-2" />
                    <p className="text-muted-foreground">No transactions found</p>
                  </TableCell>
                </TableRow>
              ) : (
                filtered.map(tx => (
                  <TableRow key={tx.id} className="group hover:bg-muted/30 transition-colors duration-150">
                    <TableCell className="text-muted-foreground text-sm">
                      {new Date(tx.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
                      <span className="ml-2 text-xs opacity-60">
                        {new Date(tx.created_at).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' })}
                      </span>
                    </TableCell>
                    <TableCell className="font-medium">{tx.products?.product_name || 'Unknown'}</TableCell>
                    <TableCell>
                      <Badge variant={tx.type === 'purchase' ? 'default' : 'secondary'} className="text-xs capitalize">
                        {tx.type}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      <span className={`font-semibold tabular-nums ${tx.type === 'purchase' ? 'text-primary' : 'text-success'}`}>
                        {tx.type === 'purchase' ? '+' : '-'}{tx.quantity}
                      </span>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
