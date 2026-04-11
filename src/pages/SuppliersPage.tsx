import { useState } from 'react';
import { useSuppliers } from '@/hooks/useSuppliers';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent } from '@/components/ui/card';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Plus, Pencil, Trash2, Search, Truck, MapPin, Phone } from 'lucide-react';

export default function SuppliersPage() {
  const { suppliers, loading, addSupplier, updateSupplier, deleteSupplier } = useSuppliers();
  const { isAdmin } = useAuth();
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [form, setForm] = useState({ supplier_name: '', contact: '', address: '' });
  const [search, setSearch] = useState('');

  const resetForm = () => { setForm({ supplier_name: '', contact: '', address: '' }); setEditingId(null); };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const success = editingId
      ? await updateSupplier(editingId, form)
      : await addSupplier(form);
    if (success) { setDialogOpen(false); resetForm(); }
  };

  const handleEdit = (s: typeof suppliers[0]) => {
    setForm({ supplier_name: s.supplier_name, contact: s.contact || '', address: s.address || '' });
    setEditingId(s.id);
    setDialogOpen(true);
  };

  const filtered = suppliers.filter(s =>
    s.supplier_name.toLowerCase().includes(search.toLowerCase()) ||
    (s.contact || '').toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Suppliers</h1>
          <p className="text-sm text-muted-foreground mt-1">{suppliers.length} active suppliers</p>
        </div>
        {isAdmin && (
          <Dialog open={dialogOpen} onOpenChange={(o) => { setDialogOpen(o); if (!o) resetForm(); }}>
            <DialogTrigger asChild>
              <Button className="gap-2 shadow-sm"><Plus className="h-4 w-4" />Add Supplier</Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader><DialogTitle>{editingId ? 'Edit Supplier' : 'Add Supplier'}</DialogTitle></DialogHeader>
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label>Supplier Name</Label>
                  <Input value={form.supplier_name} onChange={e => setForm(f => ({ ...f, supplier_name: e.target.value }))} required />
                </div>
                <div className="space-y-2">
                  <Label>Contact</Label>
                  <Input value={form.contact} onChange={e => setForm(f => ({ ...f, contact: e.target.value }))} />
                </div>
                <div className="space-y-2">
                  <Label>Address</Label>
                  <Input value={form.address} onChange={e => setForm(f => ({ ...f, address: e.target.value }))} />
                </div>
                <Button type="submit" className="w-full">{editingId ? 'Update' : 'Add'} Supplier</Button>
              </form>
            </DialogContent>
          </Dialog>
        )}
      </div>

      <div className="relative max-w-sm">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input placeholder="Search suppliers..." value={search} onChange={e => setSearch(e.target.value)} className="pl-9" />
      </div>

      <Card className="glass-card overflow-hidden">
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow className="bg-muted/30">
                <TableHead>Supplier</TableHead>
                <TableHead>Contact</TableHead>
                <TableHead>Address</TableHead>
                {isAdmin && <TableHead className="text-right">Actions</TableHead>}
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow><TableCell colSpan={4} className="text-center py-12 text-muted-foreground">Loading...</TableCell></TableRow>
              ) : filtered.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={4} className="text-center py-12">
                    <Truck className="h-8 w-8 mx-auto text-muted-foreground/30 mb-2" />
                    <p className="text-muted-foreground">No suppliers found</p>
                  </TableCell>
                </TableRow>
              ) : (
                filtered.map(s => (
                  <TableRow key={s.id} className="group hover:bg-muted/30 transition-colors duration-150">
                    <TableCell>
                      <div className="flex items-center gap-3">
                        <div className="h-9 w-9 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                          <Truck className="h-4 w-4 text-primary" />
                        </div>
                        <span className="font-medium">{s.supplier_name}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      {s.contact ? (
                        <div className="flex items-center gap-1.5 text-muted-foreground">
                          <Phone className="h-3 w-3" />
                          <span className="text-sm">{s.contact}</span>
                        </div>
                      ) : '—'}
                    </TableCell>
                    <TableCell>
                      {s.address ? (
                        <div className="flex items-center gap-1.5 text-muted-foreground">
                          <MapPin className="h-3 w-3 shrink-0" />
                          <span className="text-sm truncate max-w-[250px]">{s.address}</span>
                        </div>
                      ) : '—'}
                    </TableCell>
                    {isAdmin && (
                      <TableCell className="text-right">
                        <div className="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity duration-200">
                          <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => handleEdit(s)}>
                            <Pencil className="h-3.5 w-3.5" />
                          </Button>
                          <Button variant="ghost" size="icon" className="h-8 w-8 text-destructive hover:text-destructive" onClick={() => { if (confirm('Delete this supplier?')) deleteSupplier(s.id); }}>
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
