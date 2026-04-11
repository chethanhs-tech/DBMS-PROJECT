import { useState } from 'react';
import { useProducts } from '@/hooks/useProducts';
import { useSuppliers } from '@/hooks/useSuppliers';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Plus, Pencil, Trash2, Search } from 'lucide-react';
import { toast } from 'sonner';

export default function ProductsPage() {
  const { products, loading, addProduct, updateProduct, deleteProduct } = useProducts();
  const { suppliers } = useSuppliers();
  const { isAdmin } = useAuth();
  const [search, setSearch] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingProduct, setEditingProduct] = useState<string | null>(null);

  const [form, setForm] = useState({
    product_name: '', sku: '', category: '', quantity: 0,
    price: 0, reorder_level: 10, supplier_id: '',
  });

  const resetForm = () => {
    setForm({ product_name: '', sku: '', category: '', quantity: 0, price: 0, reorder_level: 10, supplier_id: '' });
    setEditingProduct(null);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const payload = {
      ...form,
      supplier_id: form.supplier_id || null,
    };

    let success: boolean;
    if (editingProduct) {
      success = await updateProduct(editingProduct, payload);
    } else {
      success = await addProduct(payload);
    }
    if (success) {
      setDialogOpen(false);
      resetForm();
    }
  };

  const handleEdit = (product: typeof products[0]) => {
    setForm({
      product_name: product.product_name,
      sku: product.sku,
      category: product.category || '',
      quantity: product.quantity,
      price: product.price,
      reorder_level: product.reorder_level,
      supplier_id: product.supplier_id || '',
    });
    setEditingProduct(product.id);
    setDialogOpen(true);
  };

  const handleDelete = async (id: string) => {
    if (confirm('Are you sure you want to delete this product?')) {
      await deleteProduct(id);
    }
  };

  const filtered = products.filter(p =>
    p.product_name.toLowerCase().includes(search.toLowerCase()) ||
    p.sku.toLowerCase().includes(search.toLowerCase()) ||
    (p.category || '').toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Products</h1>
        {isAdmin && (
          <Dialog open={dialogOpen} onOpenChange={(o) => { setDialogOpen(o); if (!o) resetForm(); }}>
            <DialogTrigger asChild>
              <Button><Plus className="h-4 w-4 mr-2" />Add Product</Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>{editingProduct ? 'Edit Product' : 'Add Product'}</DialogTitle>
              </DialogHeader>
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>Product Name</Label>
                    <Input value={form.product_name} onChange={e => setForm(f => ({ ...f, product_name: e.target.value }))} required />
                  </div>
                  <div className="space-y-2">
                    <Label>SKU</Label>
                    <Input value={form.sku} onChange={e => setForm(f => ({ ...f, sku: e.target.value }))} required />
                  </div>
                  <div className="space-y-2">
                    <Label>Category</Label>
                    <Input value={form.category} onChange={e => setForm(f => ({ ...f, category: e.target.value }))} />
                  </div>
                  <div className="space-y-2">
                    <Label>Quantity</Label>
                    <Input type="number" value={form.quantity} onChange={e => setForm(f => ({ ...f, quantity: parseInt(e.target.value) || 0 }))} min={0} />
                  </div>
                  <div className="space-y-2">
                    <Label>Price</Label>
                    <Input type="number" step="0.01" value={form.price} onChange={e => setForm(f => ({ ...f, price: parseFloat(e.target.value) || 0 }))} min={0} />
                  </div>
                  <div className="space-y-2">
                    <Label>Reorder Level</Label>
                    <Input type="number" value={form.reorder_level} onChange={e => setForm(f => ({ ...f, reorder_level: parseInt(e.target.value) || 0 }))} min={0} />
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>Supplier</Label>
                  <Select value={form.supplier_id} onValueChange={v => setForm(f => ({ ...f, supplier_id: v }))}>
                    <SelectTrigger><SelectValue placeholder="Select supplier" /></SelectTrigger>
                    <SelectContent>
                      {suppliers.map(s => (
                        <SelectItem key={s.id} value={s.id}>{s.supplier_name}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <Button type="submit" className="w-full">{editingProduct ? 'Update' : 'Add'} Product</Button>
              </form>
            </DialogContent>
          </Dialog>
        )}
      </div>

      <div className="relative max-w-sm">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input placeholder="Search products..." value={search} onChange={e => setSearch(e.target.value)} className="pl-9" />
      </div>

      <Card>
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Product</TableHead>
                <TableHead>SKU</TableHead>
                <TableHead>Category</TableHead>
                <TableHead className="text-right">Qty</TableHead>
                <TableHead className="text-right">Price</TableHead>
                <TableHead>Status</TableHead>
                {isAdmin && <TableHead className="text-right">Actions</TableHead>}
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow><TableCell colSpan={7} className="text-center py-8 text-muted-foreground">Loading...</TableCell></TableRow>
              ) : filtered.length === 0 ? (
                <TableRow><TableCell colSpan={7} className="text-center py-8 text-muted-foreground">No products found</TableCell></TableRow>
              ) : (
                filtered.map(p => (
                  <TableRow key={p.id}>
                    <TableCell className="font-medium">{p.product_name}</TableCell>
                    <TableCell className="text-muted-foreground">{p.sku}</TableCell>
                    <TableCell>{p.category || '—'}</TableCell>
                    <TableCell className="text-right">{p.quantity}</TableCell>
                    <TableCell className="text-right">${p.price}</TableCell>
                    <TableCell>
                      {p.quantity <= p.reorder_level ? (
                        <Badge variant="destructive">Low Stock</Badge>
                      ) : (
                        <Badge variant="secondary" className="bg-success/10 text-success border-0">In Stock</Badge>
                      )}
                    </TableCell>
                    {isAdmin && (
                      <TableCell className="text-right">
                        <div className="flex justify-end gap-1">
                          <Button variant="ghost" size="icon" onClick={() => handleEdit(p)}>
                            <Pencil className="h-4 w-4" />
                          </Button>
                          <Button variant="ghost" size="icon" onClick={() => handleDelete(p.id)} className="text-destructive">
                            <Trash2 className="h-4 w-4" />
                          </Button>
                        </div>
                      </TableCell>
                    )}
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
