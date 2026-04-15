import { useState, useMemo } from 'react';
import { useProducts } from '@/hooks/useProducts';
import { useSuppliers } from '@/hooks/useSuppliers';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Plus, Pencil, Trash2, Search, ArrowUpDown, Filter, Package, ShoppingCart, RotateCcw, Loader2, ImagePlus, X } from 'lucide-react';
import BuyProductDialog from '@/components/BuyProductDialog';
import { supabase } from '@/integrations/supabase/client';
import { toast } from 'sonner';

type SortKey = 'product_name' | 'quantity' | 'price' | 'category';
type SortDir = 'asc' | 'desc';

export default function ProductsPage() {
  const { products, loading, addProduct, updateProduct, deleteProduct, refetch } = useProducts();
  const { suppliers } = useSuppliers();
  const { isAdmin, isStaff, user } = useAuth();
  const [search, setSearch] = useState('');
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingProduct, setEditingProduct] = useState<string | null>(null);
  const [sortKey, setSortKey] = useState<SortKey>('product_name');
  const [sortDir, setSortDir] = useState<SortDir>('asc');
  const [filterCategory, setFilterCategory] = useState<string>('all');
  const [buyProduct, setBuyProduct] = useState<typeof products[0] | null>(null);
  const [restockProduct, setRestockProduct] = useState<typeof products[0] | null>(null);
  const [restockQty, setRestockQty] = useState(50);
  const [restockLoading, setRestockLoading] = useState(false);

  const [form, setForm] = useState({
    product_name: '', sku: '', category: '', quantity: 0,
    price: 0, reorder_level: 10, supplier_id: '', image_url: '',
  });
  const [uploading, setUploading] = useState(false);
  const [targetBucket, setTargetBucket] = useState<'product-images' | 'grocery-images'>('product-images');

  const handleRestock = async () => {
    if (!restockProduct || !user || restockQty <= 0) return;
    setRestockLoading(true);
    try {
      const newQty = restockProduct.quantity + restockQty;

      // Update product quantity
      const { error: productError } = await supabase
        .from('products')
        .update({ quantity: newQty })
        .eq('id', restockProduct.id);

      if (productError) throw productError;

      // Log the purchase transaction for audit
      await supabase.from('transactions').insert({
        product_id: restockProduct.id,
        type: 'purchase',
        quantity: restockQty,
        user_id: user.id,
      });

      toast.success(`Restocked ${restockProduct.product_name} with +${restockQty} units`);
      setRestockProduct(null);
      setRestockQty(50);
      refetch();
    } catch (err: any) {
      toast.error(err.message || 'Failed to restock');
    } finally {
      setRestockLoading(false);
    }
  };

  const resetForm = () => {
    setForm({ product_name: '', sku: '', category: '', quantity: 0, price: 0, reorder_level: 10, supplier_id: '', image_url: '' });
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
      image_url: product.image_url || '',
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
                  
                  {/* Image Upload Row */}
                  <div className="col-span-2 space-y-2">
                    <Label>Product Image</Label>
                    <div className="flex items-center gap-4">
                      {form.image_url ? (
                        <div className="relative h-20 w-20 rounded-xl overflow-hidden border border-border shadow-sm group">
                          <img src={form.image_url} alt="Preview" className="h-full w-full object-cover" />
                          <button 
                            type="button" 
                            onClick={() => setForm(f => ({ ...f, image_url: '' }))}
                            className="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity"
                          >
                            <X className="h-5 w-5 text-white" />
                          </button>
                        </div>
                      ) : (
                        <div className="h-20 w-20 rounded-xl border-2 border-dashed border-muted-foreground/20 flex items-center justify-center bg-muted/30">
                          <ImagePlus className="h-6 w-6 text-muted-foreground/40" />
                        </div>
                      )}
                      <div className="flex-1 space-y-2">
                        <div className="flex items-center gap-2">
                           <Badge 
                             variant={targetBucket === 'product-images' ? 'default' : 'outline'}
                             className="cursor-pointer text-[9px] uppercase tracking-tighter"
                             onClick={() => setTargetBucket('product-images')}
                           >
                             Product Store
                           </Badge>
                           <Badge 
                             variant={targetBucket === 'grocery-images' ? 'default' : 'outline'}
                             className="cursor-pointer text-[9px] uppercase tracking-tighter"
                             onClick={() => setTargetBucket('grocery-images')}
                           >
                             Grocery Catalog
                           </Badge>
                        </div>
                        <Input 
                          type="file" 
                          accept="image/*"
                          className="text-xs h-9 cursor-pointer border-dashed"
                          onChange={async (e) => {
                            const file = e.target.files?.[0];
                            if (!file) return;
                            
                            setUploading(true);
                            try {
                              const fileExt = file.name.split('.').pop();
                              const fileName = `${Date.now()}-${Math.random().toString(36).substring(7)}.${fileExt}`;
                              const filePath = `${fileName}`;
                              
                              const { error: uploadError } = await supabase.storage
                                .from(targetBucket)
                                .upload(filePath, file);
                                
                              if (uploadError) throw uploadError;
                              
                              const { data: { publicUrl } } = supabase.storage
                                .from(targetBucket)
                                .getPublicUrl(filePath);
                                
                              setForm(f => ({ ...f, image_url: publicUrl }));
                              toast.success(`Image uploaded to ${targetBucket}`);
                            } catch (err: any) {
                              toast.error('Upload failed: ' + err.message);
                            } finally {
                              setUploading(false);
                            }
                          }}
                          disabled={uploading}
                        />
                        <p className="text-[10px] text-muted-foreground">Uploading to: <span className="font-bold text-primary">{targetBucket}</span></p>
                      </div>
                    </div>
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
                <Button type="submit" className="w-full" disabled={uploading}>
                  {uploading ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
                  {editingProduct ? 'Update' : 'Add'} Product
                </Button>
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
                <TableHead className="text-center">Buy</TableHead>
                {(isAdmin || isStaff) && <TableHead className="text-center">Restock</TableHead>}
                {isAdmin && <TableHead className="text-right">Actions</TableHead>}
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow><TableCell colSpan={9} className="text-center py-12 text-muted-foreground">Loading...</TableCell></TableRow>
              ) : filtered.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={9} className="text-center py-12">
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
                    <TableCell className="text-right font-medium tabular-nums">₹{p.price.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</TableCell>
                    <TableCell>
                      {p.quantity <= p.reorder_level ? (
                        <Badge variant="destructive" className={`${p.quantity === 0 ? 'animate-pulse' : ''} text-xs font-bold`}>
                          {p.quantity === 0 ? 'Out of Stock' : 'Low Stock'}
                        </Badge>
                      ) : (
                        <Badge variant="secondary" className="bg-success/10 text-success border-0 text-xs font-bold">In Stock</Badge>
                      )}
                    </TableCell>
                    <TableCell className="text-center">
                      <Button
                        variant="outline"
                        size="sm"
                        className="gap-1.5 text-xs"
                        onClick={() => setBuyProduct(p)}
                        disabled={p.quantity === 0}
                      >
                        <ShoppingCart className="h-3.5 w-3.5" />
                        Buy
                      </Button>
                    </TableCell>
                    {(isAdmin || isStaff) && (
                      <TableCell className="text-center">
                        <Button
                          variant={p.quantity <= p.reorder_level ? "default" : "outline"}
                          size="sm"
                          className={`gap-1.5 text-xs transition-all duration-300 ${p.quantity <= p.reorder_level ? 'shadow-lg shadow-primary/10 border-primary/50' : ''}`}
                          onClick={() => { setRestockProduct(p); setRestockQty(50); }}
                        >
                          <RotateCcw className={`h-3.5 w-3.5 ${p.quantity <= p.reorder_level ? 'animate-spin-slow' : ''}`} />
                          Restock
                        </Button>
                      </TableCell>
                    )}
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

      <BuyProductDialog
        product={buyProduct}
        open={!!buyProduct}
        onOpenChange={(open) => { if (!open) setBuyProduct(null); }}
      />

      {/* Restock Dialog */}
      <Dialog open={!!restockProduct} onOpenChange={(open) => { if (!open) { setRestockProduct(null); setRestockQty(50); } }}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <RotateCcw className="h-5 w-5 text-primary" />
              Restock Inventory
            </DialogTitle>
            <DialogDescription>
              Add stock for <strong>{restockProduct?.product_name}</strong>
            </DialogDescription>
          </DialogHeader>
          {restockProduct && (
            <div className="space-y-6 py-4">
              <div className="flex items-center gap-4 p-4 rounded-2xl bg-secondary/50 border border-border/50">
                {restockProduct.image_url ? (
                  <img src={restockProduct.image_url} alt={restockProduct.product_name} className="h-16 w-16 rounded-xl object-cover" />
                ) : (
                  <div className="h-16 w-16 rounded-xl bg-muted flex items-center justify-center">
                    <Package className="h-8 w-8 text-muted-foreground/30" />
                  </div>
                )}
                <div>
                  <p className="font-bold text-lg">{restockProduct.product_name}</p>
                  <p className="text-sm text-muted-foreground">Current Stock: <span className={restockProduct.quantity <= restockProduct.reorder_level ? 'text-destructive font-bold' : 'text-green-500 font-bold'}>{restockProduct.quantity}</span> / Reorder Level: {restockProduct.reorder_level}</p>
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="restock-qty" className="font-bold">Quantity to Add</Label>
                <div className="flex gap-2">
                  {[25, 50, 100, 200].map((qty) => (
                    <Button
                      key={qty}
                      type="button"
                      variant={restockQty === qty ? 'default' : 'outline'}
                      size="sm"
                      className="flex-1 font-bold"
                      onClick={() => setRestockQty(qty)}
                    >
                      +{qty}
                    </Button>
                  ))}
                </div>
                <Input
                  id="restock-qty"
                  type="number"
                  min={1}
                  value={restockQty}
                  onChange={(e) => setRestockQty(Math.max(1, parseInt(e.target.value) || 0))}
                  className="mt-2 text-center text-lg font-bold"
                />
                <p className="text-xs text-muted-foreground text-center">
                  New stock will be: <strong className="text-green-500">{restockProduct.quantity + restockQty}</strong> units
                </p>
              </div>
            </div>
          )}
          <DialogFooter>
            <Button variant="outline" onClick={() => setRestockProduct(null)}>Cancel</Button>
            <Button onClick={handleRestock} disabled={restockLoading || restockQty <= 0} className="gap-2 font-bold">
              {restockLoading ? <Loader2 className="h-4 w-4 animate-spin" /> : <RotateCcw className="h-4 w-4" />}
              Confirm Restock (+{restockQty})
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
