import { useState } from 'react';
import { useCart } from '@/contexts/CartContext';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { toast } from 'sonner';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { ShoppingCart, Trash2, Plus, Minus, IndianRupee, CreditCard, Smartphone, Building2, CheckCircle2, Loader2, Package } from 'lucide-react';

type PaymentMethod = 'upi' | 'card' | 'netbanking';
type Step = 'cart' | 'payment' | 'processing' | 'success';
const GST_RATE = 0.18;

export default function CartPage() {
  const { items, removeFromCart, updateQuantity, clearCart, totalPrice } = useCart();
  const { user } = useAuth();
  const [step, setStep] = useState<Step>('cart');
  const [paymentMethod, setPaymentMethod] = useState<PaymentMethod>('upi');

  const gst = totalPrice * GST_RATE;
  const grandTotal = totalPrice + gst;

  const handleCheckout = async () => {
    if (!user || items.length === 0) return;
    setStep('processing');
    await new Promise(r => setTimeout(r, 2000));

    try {
      for (const item of items) {
        const invoiceNumber = `INV-${Date.now().toString(36).toUpperCase()}-${Math.random().toString(36).slice(2, 5).toUpperCase()}`;
        const itemTotal = item.product.price * item.quantity;
        const itemGst = itemTotal * GST_RATE;

        const { error: orderError } = await supabase.from('orders').insert({
          user_id: user.id,
          product_id: item.product.id,
          product_name: item.product.product_name,
          quantity: item.quantity,
          unit_price: item.product.price,
          total_price: itemTotal + itemGst,
          gst_amount: itemGst,
          payment_method: paymentMethod,
          status: 'completed',
          invoice_number: invoiceNumber,
        } as any);
        if (orderError) throw orderError;

        const { error: txError } = await supabase.from('transactions').insert({
          product_id: item.product.id,
          type: 'sale',
          quantity: item.quantity,
          user_id: user.id,
        });
        if (txError) throw txError;

        const { error: stockError } = await supabase
          .from('products')
          .update({ quantity: item.product.quantity - item.quantity })
          .eq('id', item.product.id);
        if (stockError) throw stockError;
      }
      setStep('success');
      clearCart();
    } catch (err: any) {
      toast.error(err.message || 'Checkout failed');
      setStep('cart');
    }
  };

  const paymentMethods: { key: PaymentMethod; label: string; icon: React.ReactNode; desc: string }[] = [
    { key: 'upi', label: 'UPI', icon: <Smartphone className="h-5 w-5" />, desc: 'Google Pay, PhonePe, Paytm' },
    { key: 'card', label: 'Card', icon: <CreditCard className="h-5 w-5" />, desc: 'Credit / Debit Card' },
    { key: 'netbanking', label: 'Net Banking', icon: <Building2 className="h-5 w-5" />, desc: 'All major banks' },
  ];

  if (step === 'processing') {
    return (
      <div className="flex flex-col items-center justify-center py-24 space-y-4">
        <div className="relative w-16 h-16">
          <div className="absolute inset-0 rounded-full border-4 border-primary/20" />
          <div className="absolute inset-0 rounded-full border-4 border-primary border-t-transparent animate-spin" />
          <Loader2 className="absolute inset-0 m-auto h-6 w-6 text-primary animate-pulse" />
        </div>
        <p className="font-semibold text-lg">Processing Payment...</p>
        <p className="text-sm text-muted-foreground">Please wait while we confirm your order</p>
      </div>
    );
  }

  if (step === 'success') {
    return (
      <div className="flex flex-col items-center justify-center py-24 space-y-4">
        <div className="w-16 h-16 rounded-full bg-success/10 flex items-center justify-center animate-scale-in">
          <CheckCircle2 className="h-8 w-8 text-success" />
        </div>
        <p className="font-bold text-xl">Order Placed Successfully!</p>
        <p className="text-sm text-muted-foreground">Your grocery order has been confirmed</p>
        <Button onClick={() => setStep('cart')}>Continue Shopping</Button>
      </div>
    );
  }

  if (step === 'payment') {
    return (
      <div className="max-w-md mx-auto space-y-6">
        <h1 className="text-2xl font-bold">Payment</h1>
        <div className="space-y-3">
          {paymentMethods.map(m => (
            <button
              key={m.key}
              onClick={() => setPaymentMethod(m.key)}
              className={`w-full flex items-center gap-4 p-4 rounded-xl border-2 transition-all duration-200 text-left ${
                paymentMethod === m.key ? 'border-primary bg-primary/5 shadow-sm' : 'border-border/50 hover:border-primary/30'
              }`}
            >
              <div className={`p-2.5 rounded-lg ${paymentMethod === m.key ? 'bg-primary/10 text-primary' : 'bg-muted text-muted-foreground'}`}>
                {m.icon}
              </div>
              <div className="flex-1">
                <p className="font-medium text-sm">{m.label}</p>
                <p className="text-xs text-muted-foreground">{m.desc}</p>
              </div>
              {paymentMethod === m.key && (
                <div className="h-5 w-5 rounded-full bg-primary flex items-center justify-center">
                  <CheckCircle2 className="h-3 w-3 text-primary-foreground" />
                </div>
              )}
            </button>
          ))}
        </div>
        <Card className="glass-card">
          <CardContent className="p-4 space-y-2">
            <div className="flex justify-between text-sm"><span className="text-muted-foreground">Subtotal</span><span className="flex items-center"><IndianRupee className="h-3 w-3" />{totalPrice.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
            <div className="flex justify-between text-sm"><span className="text-muted-foreground">GST (18%)</span><span className="flex items-center"><IndianRupee className="h-3 w-3" />{gst.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
            <div className="border-t pt-2 flex justify-between font-bold text-lg"><span>Total</span><span className="flex items-center text-primary"><IndianRupee className="h-4 w-4" />{grandTotal.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
          </CardContent>
        </Card>
        <div className="flex gap-2">
          <Button variant="outline" onClick={() => setStep('cart')} className="flex-1">Back</Button>
          <Button onClick={handleCheckout} className="flex-1 gap-2"><CreditCard className="h-4 w-4" />Pay Now</Button>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold flex items-center gap-2">
        <ShoppingCart className="h-6 w-6 text-primary" />
        Your Cart
      </h1>

      {items.length === 0 ? (
        <Card className="glass-card">
          <CardContent className="p-12 text-center">
            <Package className="h-12 w-12 mx-auto text-muted-foreground/20 mb-4" />
            <p className="text-lg font-medium text-muted-foreground">Your cart is empty</p>
            <p className="text-sm text-muted-foreground/70 mt-1">Add some groceries to get started</p>
          </CardContent>
        </Card>
      ) : (
        <>
          <div className="space-y-3">
            {items.map(item => (
              <Card key={item.product.id} className="glass-card hover:shadow-md transition-all duration-200">
                <CardContent className="p-4 flex items-center gap-4">
                  <div className="h-16 w-16 rounded-xl bg-muted flex items-center justify-center shrink-0 overflow-hidden">
                    {item.product.image_url ? (
                      <img src={item.product.image_url} alt={item.product.product_name} className="h-full w-full object-cover" />
                    ) : (
                      <Package className="h-6 w-6 text-muted-foreground" />
                    )}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="font-semibold truncate">{item.product.product_name}</p>
                    {item.product.category && <Badge variant="secondary" className="text-xs mt-1">{item.product.category}</Badge>}
                    <p className="text-sm text-primary font-bold mt-1 flex items-center"><IndianRupee className="h-3 w-3" />{item.product.price.toLocaleString('en-IN')}</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Button variant="outline" size="icon" className="h-8 w-8" onClick={() => updateQuantity(item.product.id, item.quantity - 1)}>
                      <Minus className="h-3 w-3" />
                    </Button>
                    <span className="w-8 text-center font-semibold tabular-nums">{item.quantity}</span>
                    <Button variant="outline" size="icon" className="h-8 w-8" onClick={() => updateQuantity(item.product.id, item.quantity + 1)} disabled={item.quantity >= item.product.quantity}>
                      <Plus className="h-3 w-3" />
                    </Button>
                  </div>
                  <p className="font-bold w-24 text-right flex items-center justify-end"><IndianRupee className="h-3 w-3" />{(item.product.price * item.quantity).toLocaleString('en-IN')}</p>
                  <Button variant="ghost" size="icon" className="h-8 w-8 text-destructive" onClick={() => removeFromCart(item.product.id)}>
                    <Trash2 className="h-4 w-4" />
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>

          <Card className="glass-card">
            <CardContent className="p-4 space-y-2">
              <div className="flex justify-between text-sm"><span className="text-muted-foreground">Subtotal ({items.reduce((s, i) => s + i.quantity, 0)} items)</span><span className="flex items-center font-medium"><IndianRupee className="h-3 w-3" />{totalPrice.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
              <div className="flex justify-between text-sm"><span className="text-muted-foreground">GST (18%)</span><span className="flex items-center"><IndianRupee className="h-3 w-3" />{gst.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
              <div className="border-t pt-2 flex justify-between font-bold text-lg"><span>Total</span><span className="flex items-center text-primary"><IndianRupee className="h-4 w-4" />{grandTotal.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
            </CardContent>
          </Card>

          <Button onClick={() => setStep('payment')} className="w-full gap-2 h-12 text-base" disabled={items.length === 0}>
            Proceed to Checkout
          </Button>
        </>
      )}
    </div>
  );
}
