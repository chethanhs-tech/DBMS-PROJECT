import { useState } from 'react';
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
import { Plus } from 'lucide-react';

export default function TransactionsPage() {
  const { transactions, loading, createTransaction } = useTransactions();
  const { products } = useProducts();
  const [dialogOpen, setDialogOpen] = useState(false);
  const [productId, setProductId] = useState('');
  const [type, setType] = useState<'purchase' | 'sale'>('purchase');
  const [quantity, setQuantity] = useState(1);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const success = await createTransaction(productId, type, quantity);
    if (success) {
      setDialogOpen(false);
      setProductId('');
      setQuantity(1);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Transactions</h1>
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogTrigger asChild>
            <Button><Plus className="h-4 w-4 mr-2" />New Transaction</Button>
          </DialogTrigger>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>New Transaction</DialogTitle>
            </DialogHeader>
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

      <Card>
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Date</TableHead>
                <TableHead>Product</TableHead>
                <TableHead>Type</TableHead>
                <TableHead className="text-right">Quantity</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow><TableCell colSpan={4} className="text-center py-8 text-muted-foreground">Loading...</TableCell></TableRow>
              ) : transactions.length === 0 ? (
                <TableRow><TableCell colSpan={4} className="text-center py-8 text-muted-foreground">No transactions yet</TableCell></TableRow>
              ) : (
                transactions.map(tx => (
                  <TableRow key={tx.id}>
                    <TableCell className="text-muted-foreground">{new Date(tx.created_at).toLocaleString()}</TableCell>
                    <TableCell className="font-medium">{tx.products?.product_name || 'Unknown'}</TableCell>
                    <TableCell>
                      <Badge variant={tx.type === 'purchase' ? 'default' : 'secondary'}>{tx.type}</Badge>
                    </TableCell>
                    <TableCell className="text-right font-medium">
                      {tx.type === 'purchase' ? '+' : '-'}{tx.quantity}
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
