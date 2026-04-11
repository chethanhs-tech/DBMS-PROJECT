import { useState, useMemo } from 'react';
import { useProducts } from '@/hooks/useProducts';
import { useSuppliers } from '@/hooks/useSuppliers';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Plus, Pencil, Trash2, Search, ArrowUpDown, Filter, Package } from 'lucide-react';

type SortKey = 'product_name' | 'quantity' | 'price' | 'category';
type SortDir = 'asc' | 'desc';

export default function ProductsPage() {
  const { products, loading, addProduct, updateProduct, deleteProduct } = useProducts();
  const { suppliers } = useSuppliers();
  const { isAdmin } = useAuth();
  const [search, setSearch] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingProduct, setEditingProduct] = useState<string | null>(null);
  const [sortKey, setSortKey] = useState<SortKey>('product_name');
  const [sortDir, setSortDir] = useState<SortDir>('asc');
  const [filterCategory, setFilterCategory] = useState<string>('all');

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
    const payload = { ...form, supplier_id: form.supplier_id || null };
    let success: boolean;
    if (editingProduct) {
      success = await updateProduct(editingProduct, payload);
    } else {
      success = await addProduct(payload);
    }
    if (success) { setDialogOpen(false); resetForm(); }
  };

  const handleEdit = (product: typeof products[0]) => {
    setForm({
      product_name: product.product_name, sku: product.sku, category: product.category || '',
      quantity: product.quantity, price: product.price, reorder_level: product.reorder_level,
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

  const toggleSort = (key: SortKey) => {
    if (sortKey === key) setSortDir(d => d === 'asc' ? 'desc' : 'asc');
    else { setSortKey(key); setSortDir('asc'); }
  };

  const categories = useMemo(() => {
    const cats = new Set(products.map(p => p.category).filter(Boolean));
    return Array.from(cats) as string[];
  }, [products]);

  const filtered = useMemo(() => {
    let list = products.filter(p =>
      p.product_name.toLowerCase().includes(search.toLowerCase()) ||
      p.sku.toLowerCase().includes(search.toLowerCase()) ||
      (p.category || '').toLowerCase().includes(search.toLowerCase())
    );
    if (filterCategory !== 'all') {
      list = list.filter(p => p.category === filterCategory);
    }
    list.sort((a, b) => {
      const aVal = a[sortKey] ?? '';
      const bVal = b[sortKey] ?? '';
      const cmp = typeof aVal === 'number' ? aVal - (bVal as number) : String(aVal).localeCompare(String(bVal));
      return sortDir === 'asc' ? cmp : -cmp;
    });
    return list;
  }, [products, search, sortKey, sortDir, filterCategory]);

  const SortHeader = ({ label, field }: { label: string; field: SortKey }) => (
    <button onClick={() => toggleSort(field)} className="flex items-center gap-1 hover:text-foreground transition-colors">
      {label}
      <ArrowUpDown className={`h-3 w-3 ${sortKey === field ? 'text-primary' : 'opacity-30'}`} />
    </button>
  );

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Products</h1>
          <p className="text-sm text-muted-foreground mt-1">{products.length} items in inventory</p>
        </div>
        {isAdmin && (
          <Dialog open={dialogOpen} onOpenChange={(o) => { setDialogOpen(o); if (!o) resetForm(); }}>
            <DialogTrigger asChild>
              <Button className="gap-2 shadow-sm"><Plus className="h-4 w-4" />Add Product</Button>
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

      {/* Filters */}
      <div className="flex flex-wrap items-center gap-3">
        <div className="relative flex-1 min-w-[200px] max-w-sm">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input placeholder="Search products..." value={search} onChange={e => setSearch(e.target.value)} className="pl-9" />
        </div>
        <Select value={filterCategory} onValueChange={setFilterCategory}>
          <SelectTrigger className="w-[180px]">
            <Filter className="h-3.5 w-3.5 mr-2 text-muted-foreground" />
            <SelectValue placeholder="All categories" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Categories</SelectItem>
            {categories.map(c => <SelectItem key={c} value={c}>{c}</SelectItem>)}
          </SelectContent>
        </Select>
      </div>

      <Card className="glass-card overflow-hidden">
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow className="bg-muted/30">
                <TableHead className="w-12" />
                <TableHead><SortHeader label="Product" field="product_name" /></TableHead>
                <TableHead>SKU</TableHead>
                <TableHead><SortHeader label="Category" field="category" /></TableHead>
                <TableHead className="text-right"><SortHeader label="Qty" field="quantity" /></TableHead>
                <TableHead className="text-right"><SortHeader label="Price" field="price" /></TableHead>
                <TableHead>Status</TableHead>
                {isAdmin && <TableHead className="text-right">Actions</TableHead>}
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow><TableCell colSpan={8} className="text-center py-12 text-muted-foreground">Loading...</TableCell></TableRow>
              ) : filtered.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={8} className="text-center py-12">
                    <Package className="h-8 w-8 mx-auto text-muted-foreground/30 mb-2" />
                    <p className="text-muted-foreground">No products found</p>
                  </TableCell>
                </TableRow>
              ) : (
                filtered.map(p => (
                  <TableRow key={p.id} className="group hover:bg-muted/30 transition-colors duration-150">
                    <TableCell className="w-12 pr-0">
                      {p.image_url ? (
                        <img src={p.image_url} alt={p.product_name} className="h-9 w-9 rounded-lg object-cover border border-border/50" />
                      ) : (
                        <div className="h-9 w-9 rounded-lg bg-muted flex items-center justify-center">
                          <Package className="h-4 w-4 text-muted-foreground" />
                        </div>
                      )}
                    </TableCell>
                    <TableCell className="font-medium">{p.product_name}</TableCell>
                    <TableCell><code className="text-xs bg-muted px-1.5 py-0.5 rounded text-muted-foreground">{p.sku}</code></TableCell>
                    <TableCell>
                      {p.category ? (
                        <Badge variant="secondary" className="font-normal text-xs">{p.category}</Badge>
                      ) : '—'}
                    </TableCell>
                    <TableCell className="text-right font-medium tabular-nums">{p.quantity}</TableCell>
                    <TableCell className="text-right font-medium tabular-nums">${p.price.toLocaleString('en-US', { minimumFractionDigits: 2 })}</TableCell>
                    <TableCell>
                      {p.quantity <= p.reorder_level ? (
                        <Badge variant="destructive" className="animate-pulse text-xs">Low Stock</Badge>
                      ) : (
                        <Badge variant="secondary" className="bg-success/10 text-success border-0 text-xs">In Stock</Badge>
                      )}
                    </TableCell>
                    {isAdmin && (
                      <TableCell className="text-right">
                        <div className="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity duration-200">
                          <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => handleEdit(p)}>
                            <Pencil className="h-3.5 w-3.5" />
                          </Button>
                          <Button variant="ghost" size="icon" className="h-8 w-8 text-destructive hover:text-destructive" onClick={() => handleDelete(p.id)}>
                            <Trash2 className="h-3.5 w-3.5" />
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
