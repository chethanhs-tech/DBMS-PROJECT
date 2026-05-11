import { useState, useMemo, useEffect } from 'react';
import { useProducts } from '@/hooks/useProducts';
import { useCart } from '@/contexts/CartContext';
import { useAddresses } from '@/hooks/useAddresses';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Skeleton } from '@/components/ui/skeleton';
import { 
  Search, 
  Plus, 
  IndianRupee, 
  Package, 
  Apple, 
  Milk, 
  Beef, 
  Cookie, 
  Wine, 
  Sparkles, 
  Wheat, 
  Egg, 
  ShoppingBag, 
  Filter, 
  Clock, 
  MapPin,
  ChevronRight,
  Zap
} from 'lucide-react';
import { useSearchParams } from 'react-router-dom';

const CATEGORY_ICONS: Record<string, React.ReactNode> = {
  'Fruits': <Apple className="h-5 w-5" />,
  'Vegetables': <Sparkles className="h-5 w-5" />,
  'Dairy': <Milk className="h-5 w-5" />,
  'Meat & Seafood': <Beef className="h-5 w-5" />,
  'Snacks': <Cookie className="h-5 w-5" />,
  'Beverages': <Wine className="h-5 w-5" />,
  'Grains & Cereals': <Wheat className="h-5 w-5" />,
  'Bakery': <Egg className="h-5 w-5" />,
  'Personal Care': <Zap className="h-5 w-5" />,
  'Home Essentials': <Package className="h-5 w-5" />,
};

const WEIGHT_OPTIONS = [
  { label: '250g', multiplier: 0.25 },
  { label: '500g', multiplier: 0.5 },
  { label: '1kg', multiplier: 1 },
];

export default function ShopPage() {
  const { products, loading } = useProducts();
  const { addToCart } = useCart();
  const { addresses } = useAddresses();
  const [search, setSearch] = useState('');
  const [searchParams, setSearchParams] = useSearchParams();
  
  const selectedCategory = searchParams.get('cat') || 'all';

  const defaultAddress = useMemo(() => 
    addresses.find(a => a.is_default) || addresses[0], 
  [addresses]);

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

  const setCategory = (cat: string) => {
    setSearchParams({ cat });
  };

  if (loading) {
    return (
      <div className="space-y-8 animate-pulse">
        <div className="h-32 bg-muted rounded-3xl" />
        <div className="flex gap-3 overflow-hidden">
          {[1,2,3,4,5].map(i => <div key={i} className="h-10 w-24 bg-muted rounded-full" />)}
        </div>
        <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-6">
          {Array.from({ length: 10 }).map((_, i) => <Skeleton key={i} className="h-72 rounded-2xl" />)}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-12 pb-24">
      {/* Header & Search */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-8 bg-card p-8 rounded-[3rem] border border-border/50 shadow-xl relative overflow-hidden">
        <div className="space-y-2 relative z-10">
          <Badge className="bg-primary/10 text-primary border-none px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-widest mb-2">
             <Zap className="h-3 w-3 mr-1 fill-primary" /> GrozoSphere Instant
          </Badge>
          <h1 className="text-4xl font-black tracking-tight flex items-center gap-3">
            GrozoSphere Shop
          </h1>
          {defaultAddress && (
             <p className="text-xs font-bold text-muted-foreground flex items-center gap-1.5">
               <MapPin className="h-3.5 w-3.5 text-primary" /> Delivering to <span className="text-foreground font-black uppercase tracking-tighter">{defaultAddress.city}</span> in <span className="text-primary font-black">15 mins</span>
             </p>
          )}
        </div>
        <div className="relative w-full max-w-lg relative z-10">
          <Search className="absolute left-5 top-1/2 -translate-y-1/2 h-5 w-5 text-muted-foreground/40" />
          <Input 
            placeholder="Search for bread, milk, eggs..." 
            value={search} 
            onChange={e => setSearch(e.target.value)} 
            className="pl-14 h-16 bg-secondary/50 border-none rounded-3xl focus-visible:ring-4 focus-visible:ring-primary/10 shadow-inner text-lg font-medium" 
          />
        </div>
        <div className="absolute top-0 right-0 w-64 h-64 bg-primary/5 rounded-full blur-3xl -z-0" />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-[280px_1fr] gap-12">
        {/* Sidebar Filter */}
        <aside className="space-y-10 hidden lg:block">
          <div>
            <h3 className="text-xl font-black mb-6 flex items-center gap-2 tracking-tight">
               Categories
            </h3>
            <div className="flex flex-col gap-2">
              <button
                onClick={() => setCategory('all')}
                className={`flex items-center gap-3 px-5 py-4 rounded-2xl text-sm font-black transition-all duration-300 ${
                  selectedCategory === 'all'
                    ? 'bg-primary text-primary-foreground shadow-2xl shadow-primary/20 translate-x-1'
                    : 'hover:bg-secondary text-muted-foreground hover:text-foreground'
                }`}
              >
                <div className={`p-2 rounded-xl transition-colors ${selectedCategory === 'all' ? 'bg-white/20' : 'bg-secondary'}`}>
                  <Package className="h-4 w-4" />
                </div>
                All Products
              </button>
              {categories.map(cat => (
                <button
                  key={cat}
                  onClick={() => setCategory(cat)}
                  className={`flex items-center gap-3 px-5 py-4 rounded-2xl text-sm font-black transition-all duration-300 ${
                    selectedCategory === cat
                      ? 'bg-primary text-primary-foreground shadow-2xl shadow-primary/20 translate-x-1'
                      : 'hover:bg-secondary text-muted-foreground hover:text-foreground'
                  }`}
                >
                  <div className={`p-2 rounded-xl transition-colors ${selectedCategory === cat ? 'bg-white/20' : 'bg-secondary'}`}>
                    {CATEGORY_ICONS[cat] || <Package className="h-4 w-4" />}
                  </div>
                  {cat}
                </button>
              ))}
            </div>
          </div>

          <Card className="rounded-[2rem] bg-gradient-to-br from-primary to-green-600 p-6 text-white border-none shadow-xl shadow-primary/20 group relative overflow-hidden">
            <p className="text-[10px] font-black uppercase tracking-[0.2em] mb-2 opacity-70">Flash Deal</p>
            <p className="text-lg font-black leading-tight mb-4 relative z-10">Free delivery on orders above ₹499</p>
            <Button size="sm" className="bg-white text-primary hover:bg-white/90 rounded-full font-black px-6 text-xs h-9 relative z-10">Use Code: FRESH20</Button>
            <Zap className="absolute -right-4 -bottom-4 w-24 h-24 opacity-10 group-hover:scale-125 transition-transform duration-700" />
          </Card>
        </aside>

        {/* Product Grid */}
        <div className="space-y-8">
          {/* Mobile categories Scroller */}
          <div className="lg:hidden flex gap-3 overflow-x-auto pb-6 scrollbar-hide px-1">
            <button
              onClick={() => setCategory('all')}
              className={`px-6 py-3 rounded-2xl text-sm font-black whitespace-nowrap transition-all ${
                selectedCategory === 'all' ? 'bg-primary text-primary-foreground shadow-xl' : 'bg-card border border-border/50 text-muted-foreground'
              }`}
            >
              All Items
            </button>
            {categories.map(cat => (
              <button
                key={cat}
                onClick={() => setCategory(cat)}
                className={`px-6 py-3 rounded-2xl text-sm font-black whitespace-nowrap transition-all border border-border/50 ${
                  selectedCategory === cat ? 'bg-primary text-primary-foreground shadow-xl' : 'bg-card text-muted-foreground'
                }`}
              >
                {cat}
              </button>
            ))}
          </div>

          {filtered.length === 0 ? (
            <div className="text-center py-32 bg-card rounded-[3rem] border-2 border-dashed border-border/50 space-y-6">
              <div className="w-24 h-24 bg-muted/50 rounded-[2rem] flex items-center justify-center mx-auto">
                 <Package className="h-10 w-10 text-muted-foreground/20" />
              </div>
              <div>
                <p className="text-2xl font-black text-foreground">No matches found</p>
                <p className="text-sm text-muted-foreground mt-1 font-medium italic">Try searching for something else or clear filters</p>
              </div>
              <Button variant="ghost" className="font-black text-primary hover:bg-primary/5 rounded-xl h-12" onClick={() => { setSearch(''); setCategory('all'); }}>Reset All Filters</Button>
            </div>
          ) : (
            <div className="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-8">
              {filtered.map(product => <ProductCard key={product.id} product={product} onAdd={addToCart} />)}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

function ProductCard({ product, onAdd }: { product: any, onAdd: any }) {
  const variants = product.product_variants || [];
  const [selectedVariantId, setSelectedVariantId] = useState<string | null>(variants[0]?.id || null);

  const selectedVariant = useMemo(() => {
    return variants.find((v: any) => v.id === selectedVariantId) || null;
  }, [selectedVariantId, variants]);

  const currentPrice = selectedVariant ? selectedVariant.price : product.price;
  const currentStock = selectedVariant ? selectedVariant.quantity : product.quantity;
  const currentLabel = selectedVariant ? selectedVariant.label : null;

  const handleAdd = () => {
    const displayName = currentLabel 
      ? `${product.product_name} (${currentLabel})`
      : product.product_name;
    
    onAdd({ 
      ...product, 
      price: currentPrice,
      quantity: currentStock, // Pass the specific stock to CartContext for validation
      display_name: displayName,
      variant_id: selectedVariantId
    });
  };

  return (
    <Card className="group relative bg-card border-border/50 hover:border-primary/20 shadow-sm hover:shadow-[0_20px_40px_-15px_rgba(0,0,0,0.1)] hover:-translate-y-2 transition-all duration-500 rounded-[2.5rem] overflow-hidden flex flex-col h-full">
      <div className="aspect-square bg-muted/20 relative overflow-hidden flex-shrink-0">
        <img 
          src={product.image_url || ''} 
          alt={product.product_name} 
          loading="lazy"
          className="h-full w-full object-cover group-hover:scale-110 transition-transform duration-1000"
          onError={(e) => {
            const target = e.target as HTMLImageElement;
            // Hide the broken image and show a gradient placeholder
            target.style.display = 'none';
          }}
        />
        {/* Gradient fallback shown when image fails */}
        <div className="absolute inset-0 bg-gradient-to-br from-primary/10 to-primary/5 flex items-center justify-center pointer-events-none">
          <span className="text-4xl opacity-30">🛒</span>
        </div>
        
        {/* Badges */}
        <div className="absolute top-4 left-4 flex flex-col gap-2">
          <Badge className="bg-success text-white border-none shadow-xl text-[9px] font-black uppercase tracking-tighter px-3 h-6 flex items-center gap-1.5 rounded-full">
            <Clock className="h-3 w-3" /> 15 MINS
          </Badge>
          {product.quantity <= product.reorder_level && product.quantity > 0 && (
            <Badge className="bg-orange-500 text-white border-none shadow-xl text-[9px] font-black uppercase tracking-tighter px-3 h-6 rounded-full">Low Stock</Badge>
          )}
        </div>

        {currentStock === 0 && (
          <div className="absolute inset-0 bg-background/90 backdrop-blur-md flex items-center justify-center z-10">
            <div className="bg-destructive/10 text-destructive border-2 border-destructive px-6 py-2 rounded-2xl text-[10px] font-black uppercase tracking-[0.2em] shadow-2xl rotate-12">
               Out of Stock
            </div>
          </div>
        )}
        
        {/* Quick View Button */}
        <div className="absolute inset-x-0 bottom-4 px-4 translate-y-20 group-hover:translate-y-0 transition-transform duration-500 z-10 hidden md:block">
           <Button className="w-full h-12 rounded-2xl bg-white text-black hover:bg-white/90 font-black shadow-2xl" onClick={handleAdd}>
             <Plus className="h-5 w-5 mr-1" /> Quick Add
           </Button>
        </div>
      </div>

      <CardContent className="p-5 flex flex-col flex-grow justify-between gap-4">
        <div className="space-y-3">
          <div className="space-y-1">
            <p className="text-[10px] font-black text-primary uppercase tracking-[0.2em] leading-none">{product.category || 'General'}</p>
            <h3 className="font-black text-base truncate group-hover:text-primary transition-colors leading-tight">{product.product_name}</h3>
          </div>

          {/* Variations Chips */}
          {variants.length > 0 && (
            <div className="flex flex-wrap gap-1.5 pt-1">
              {variants.map((v: any) => (
                <button
                  key={v.id}
                  onClick={() => setSelectedVariantId(v.id)}
                  className={`px-3 py-1.5 rounded-xl text-[10px] font-bold transition-all border ${
                    selectedVariantId === v.id 
                      ? 'bg-primary text-primary-foreground border-primary shadow-lg shadow-primary/20' 
                      : 'bg-secondary/50 text-muted-foreground border-transparent hover:border-primary/30'
                  }`}
                >
                  {v.label}
                </button>
              ))}
            </div>
          )}
        </div>

        <div className="flex items-center justify-between pt-2">
          <div className="space-y-0.5">
             <span className="text-2xl font-black text-foreground tracking-tighter">₹{currentPrice}</span>
             {currentLabel && variants.length > 1 && (
               <p className="text-[9px] text-muted-foreground font-bold uppercase tracking-tight">Per {currentLabel}</p>
             )}
          </div>
          
          <Button 
            onClick={handleAdd}
            disabled={currentStock === 0}
            size="icon"
            className="h-12 w-12 rounded-2xl shadow-xl shadow-primary/10 hover:rotate-90 transition-all duration-500 ring-2 ring-primary/5 ring-offset-2 ring-offset-card"
          >
            <Plus className="h-6 w-6 stroke-[3]" />
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}

