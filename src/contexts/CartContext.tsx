import { createContext, useContext, useState, ReactNode, useCallback, useEffect } from 'react';
import type { Tables } from '@/integrations/supabase/types';
import { toast } from 'sonner';

type Product = Tables<'products'>;

export interface CartItem {
  product: Product & { 
    display_name?: string;
    variant_id?: string | null;
  };
  quantity: number;
}

interface CartContextType {
  items: CartItem[];
  addToCart: (product: Product & { display_name?: string, variant_id?: string | null }, qty?: number) => void;
  removeFromCart: (productId: string, variantId?: string | null) => void;
  updateQuantity: (productId: string, qty: number, variantId?: string | null) => void;
  clearCart: () => void;
  applyCoupon: (code: string) => void;
  removeCoupon: () => void;
  totalItems: number;
  totalPrice: number;
  discount: number;
  appliedCoupon: string | null;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

const SAVED_COUPONS = {
  'GROZO20': { type: 'percent', value: 20 },
  'SAVE50': { type: 'flat', value: 50 },
  'FIRSTORDER': { type: 'percent', value: 10 },
} as const;

export function CartProvider({ children }: { children: ReactNode }) {
  const [items, setItems] = useState<CartItem[]>([]);
  const [appliedCoupon, setAppliedCoupon] = useState<string | null>(null);
  const [discount, setDiscount] = useState(0);

  const getItemKey = (p: Product & { variant_id?: string | null }) => `${p.id}-${p.variant_id || 'base'}`;

  const totalPrice = items.reduce((s, i) => s + i.product.price * i.quantity, 0);

  const calculateDiscount = useCallback((code: string, subtotal: number) => {
    const coupon = SAVED_COUPONS[code as keyof typeof SAVED_COUPONS];
    if (!coupon) return 0;
    if (coupon.type === 'percent') return (subtotal * coupon.value) / 100;
    return Math.min(coupon.value, subtotal);
  }, []);

  const applyCoupon = useCallback((code: string) => {
    const ucCode = code.toUpperCase();
    if (SAVED_COUPONS[ucCode as keyof typeof SAVED_COUPONS]) {
      setAppliedCoupon(ucCode);
      const d = calculateDiscount(ucCode, totalPrice);
      setDiscount(d);
      toast.success(`Coupon ${ucCode} applied! Saved ₹${d.toFixed(0)}`);
    } else {
      toast.error('Invalid coupon code');
    }
  }, [totalPrice, calculateDiscount]);

  const removeCoupon = useCallback(() => {
    setAppliedCoupon(null);
    setDiscount(0);
    toast.info('Coupon removed');
  }, []);

  const addToCart = useCallback((product: Product & { display_name?: string, variant_id?: string | null }, qty = 1) => {
    setItems(prev => {
      const key = getItemKey(product);
      const existing = prev.find(i => getItemKey(i.product) === key);
      if (existing) {
        const newQty = Math.min(existing.quantity + qty, product.quantity);
        return prev.map(i => getItemKey(i.product) === key ? { ...i, quantity: newQty } : i);
      }
      return [...prev, { product, quantity: Math.min(qty, product.quantity) }];
    });
    toast.success(`${product.display_name || product.product_name} added to cart`);
  }, []);

  const removeFromCart = useCallback((productId: string, variantId: string | null = null) => {
    const key = `${productId}-${variantId || 'base'}`;
    setItems(prev => prev.filter(i => getItemKey(i.product) !== key));
  }, []);

  const updateQuantity = useCallback((productId: string, qty: number, variantId: string | null = null) => {
    const key = `${productId}-${variantId || 'base'}`;
    if (qty <= 0) {
      setItems(prev => prev.filter(i => getItemKey(i.product) !== key));
      return;
    }
    setItems(prev => prev.map(i =>
      getItemKey(i.product) === key ? { ...i, quantity: Math.min(qty, i.product.quantity) } : i
    ));
  }, []);

  const clearCart = useCallback(() => {
    setItems([]);
    setAppliedCoupon(null);
    setDiscount(0);
  }, []);

  const totalItems = items.reduce((s, i) => s + i.quantity, 0);

  // Re-calculate discount if total price changes
  useEffect(() => {
    if (appliedCoupon) {
      setDiscount(calculateDiscount(appliedCoupon, totalPrice));
    }
  }, [totalPrice, appliedCoupon, calculateDiscount]);

  return (
    <CartContext.Provider value={{ 
      items, addToCart, removeFromCart, updateQuantity, clearCart, 
      applyCoupon, removeCoupon, totalItems, totalPrice, discount, appliedCoupon 
    }}>
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  const ctx = useContext(CartContext);
  if (!ctx) throw new Error('useCart must be used within CartProvider');
  return ctx;
}
