import { useState, useMemo } from 'react';
import { useProducts } from '@/hooks/useProducts';
import { useCart } from '@/contexts/CartContext';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Skeleton } from '@/components/ui/skeleton';
import { Search, ShoppingCart, Plus, IndianRupee, Package, Apple, Milk, Beef, Cookie, Wine, Sparkles, Wheat, Egg } from 'lucide-react';

const CATEGORY_ICONS: Record<string, React.ReactNode> = {
  'Fruits': <Apple className="h-5 w-5" />,
  'Vegetables': <Sparkles className="h-5 w-5" />,
  'Dairy': <Milk className="h-5 w-5" />,
  'Meat & Seafood': <Beef className="h-5 w-5" />,
  'Snacks': <Cookie className="h-5 w-5" />,
  'Beverages': <Wine className="h-5 w-5" />,
  'Grains & Cereals': <Wheat className="h-5 w-5" />,
  'Bakery': <Egg className="h-5 w-5" />,
};

export default function ShopPage() {
  const { products, loading } = useProducts();
  const { addToCart } = useCart();
  const [search, setSearch] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string>('all');

  const categories = useMemo(() => {
    const cats = new Set(products.map(p => p.category).filter(Boolean));
    return Array.from(cats) as string[];
  }, [products]);

  const filtered = useMemo(() => {
    let list = products;
    if (search) {
      list = list.filter(p => p.product_name.toLowerCase().includes(search.toLowerCase()));
    }
    if (selectedCategory !== 'all') {
      list = list.filter(p => p.category === selectedCategory);
    }
    return list;
  }, [products, search, selectedCategory]);

  if (loading) {
    return (
      <div className="space-y-6">
        <Skeleton className="h-12 w-64" />
        <div className="flex gap-2"><Skeleton className="h-10 w-24" /><Skeleton className="h-10 w-24" /><Skeleton className="h-10 w-24" /></div>
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {Array.from({ length: 8 }).map((_, i) => <Skeleton key={i} className="h-64 rounded-xl" />)}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Hero */}
      <div className="rounded-2xl bg-gradient-to-br from-primary/10 via-primary/5 to-transparent p-6 border border-primary/10">
        <h1 className="text-2xl font-bold">Fresh Groceries, Delivered Fast 🛒</h1>
        <p className="text-sm text-muted-foreground mt-1">Smart Groceries. Smarter Inventory.</p>
      </div>

      {/* Search */}
      <div className="relative max-w-md">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input placeholder="Search groceries..." value={search} onChange={e => setSearch(e.target.value)} className="pl-9 h-11" />
      </div>

      {/* Category pills */}
      <div className="flex flex-wrap gap-2">
        <button
          onClick={() => setSelectedCategory('all')}
          className={`px-4 py-2 rounded-full text-sm font-medium transition-all duration-200 border ${
            selectedCategory === 'all'
              ? 'bg-primary text-primary-foreground border-primary shadow-sm'
              : 'bg-card border-border hover:border-primary/30 text-foreground'
          }`}
        >
          All Items
        </button>
        {categories.map(cat => (
          <button
            key={cat}
            onClick={() => setSelectedCategory(cat)}
            className={`px-4 py-2 rounded-full text-sm font-medium transition-all duration-200 border flex items-center gap-1.5 ${
              selectedCategory === cat
                ? 'bg-primary text-primary-foreground border-primary shadow-sm'
                : 'bg-card border-border hover:border-primary/30 text-foreground'
            }`}
          >
            {CATEGORY_ICONS[cat] || <Package className="h-4 w-4" />}
            {cat}
          </button>
        ))}
      </div>

      {/* Product Grid */}
      {filtered.length === 0 ? (
        <div className="text-center py-16">
          <Package className="h-12 w-12 mx-auto text-muted-foreground/20 mb-4" />
          <p className="text-lg font-medium text-muted-foreground">No products found</p>
        </div>
      ) : (
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {filtered.map(product => (
            <Card key={product.id} className="glass-card group hover:shadow-lg hover:-translate-y-1 transition-all duration-300 overflow-hidden">
              <div className="aspect-square bg-muted/50 flex items-center justify-center overflow-hidden relative">
                {product.image_url ? (
                  <img src={product.image_url} alt={product.product_name} className="h-full w-full object-cover group-hover:scale-105 transition-transform duration-300" />
                ) : (
                  <Package className="h-12 w-12 text-muted-foreground/30" />
                )}
                {product.quantity <= product.reorder_level && product.quantity > 0 && (
                  <Badge variant="destructive" className="absolute top-2 right-2 text-xs">Low Stock</Badge>
                )}
                {product.quantity === 0 && (
                  <div className="absolute inset-0 bg-background/60 flex items-center justify-center">
                    <Badge variant="destructive">Out of Stock</Badge>
                  </div>
                )}
              </div>
              <CardContent className="p-3 space-y-2">
                {product.category && (
                  <p className="text-xs text-muted-foreground font-medium uppercase tracking-wider">{product.category}</p>
                )}
                <p className="font-semibold text-sm truncate">{product.product_name}</p>
                <div className="flex items-center justify-between">
                  <p className="font-bold text-primary flex items-center text-lg">
                    <IndianRupee className="h-4 w-4" />{product.price.toLocaleString('en-IN')}
                  </p>
                  <Button
                    size="sm"
                    className="h-8 w-8 p-0 rounded-full shadow-sm"
                    onClick={() => addToCart(product)}
                    disabled={product.quantity === 0}
                  >
                    <Plus className="h-4 w-4" />
                  </Button>
                </div>
                <p className="text-xs text-muted-foreground">{product.quantity} in stock</p>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}
