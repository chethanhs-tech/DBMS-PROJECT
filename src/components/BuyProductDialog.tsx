import { useState } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Badge } from '@/components/ui/badge';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/contexts/AuthContext';
import { toast } from 'sonner';
import { ShoppingCart, CreditCard, Smartphone, Building2, CheckCircle2, Loader2, IndianRupee, Package } from 'lucide-react';

interface Product {
  id: string;
  product_name: string;
  price: number;
  quantity: number;
  image_url: string | null;
  category: string | null;
  sku: string;
  product_variants?: any[];
}

interface BuyProductDialogProps {
  product: Product | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

type PaymentMethod = 'upi' | 'card' | 'netbanking';
type Step = 'details' | 'payment' | 'processing' | 'success';

const GST_RATE = 0.18;

export default function BuyProductDialog({ product, open, onOpenChange }: BuyProductDialogProps) {
  const { user } = useAuth();
  const [qty, setQty] = useState(1);
  const [selectedVariantId, setSelectedVariantId] = useState<string | null>(null);
  const [paymentMethod, setPaymentMethod] = useState<PaymentMethod>('upi');
  const [step, setStep] = useState<Step>('details');

  // Sync variant selection when product changes
  useState(() => {
    if (product?.product_variants?.length) {
      setSelectedVariantId(product.product_variants[0].id);
    }
  });

  if (!product) return null;

  const variants = product.product_variants || [];
  const selectedVariant = variants.find(v => v.id === selectedVariantId);
  
  const currentPrice = selectedVariant ? selectedVariant.price : product.price;
  const currentStock = selectedVariant ? selectedVariant.quantity : product.quantity;
  const currentLabel = selectedVariant ? selectedVariant.label : null;

  const subtotal = currentPrice * qty;
  const gst = subtotal * GST_RATE;
  const total = subtotal + gst;

  const handlePay = async () => {
    if (qty > currentStock) {
      toast.error('Not enough stock available');
      return;
    }
    if (!user) {
      toast.error('You must be logged in');
      return;
    }

    setStep('processing');
    await new Promise(r => setTimeout(r, 2000));

    const invoiceNumber = `INV-${Date.now().toString(36).toUpperCase()}`;

    try {
      // Create order with variant_id
      const { error: orderError } = await supabase.from('orders').insert({
        user_id: user.id,
        product_id: product.id,
        variant_id: selectedVariantId,
        product_name: currentLabel ? `${product.product_name} (${currentLabel})` : product.product_name,
        quantity: qty,
        unit_price: currentPrice,
        total_amount: total,
        gst_amount: gst,
        payment_method: paymentMethod,
        status: 'completed',
        invoice_number: invoiceNumber,
      } as any);

      if (orderError) throw orderError;

      // Note: Backend Postgres triggers (sync_order_to_transaction & update_stock_on_transaction)
      // will now automatically handle transaction logging and stock deduction!

      setStep('success');
    } catch (err: any) {
      toast.error(err.message || 'Payment failed');
      setStep('payment');
    }
  };

  const handleClose = () => {
    onOpenChange(false);
    setTimeout(() => {
      setStep('details');
      setQty(1);
      setPaymentMethod('upi');
    }, 300);
  };

  const paymentMethods: { key: PaymentMethod; label: string; icon: React.ReactNode; desc: string }[] = [
    { key: 'upi', label: 'UPI', icon: <Smartphone className="h-5 w-5" />, desc: 'Google Pay, PhonePe, Paytm' },
    { key: 'card', label: 'Card', icon: <CreditCard className="h-5 w-5" />, desc: 'Credit / Debit Card' },
    { key: 'netbanking', label: 'Net Banking', icon: <Building2 className="h-5 w-5" />, desc: 'All major banks' },
  ];

  return (
    <Dialog open={open} onOpenChange={handleClose}>
      <DialogContent className="sm:max-w-md">
        {step === 'details' && (
          <>
            <DialogHeader>
              <DialogTitle className="flex items-center gap-2">
                <ShoppingCart className="h-5 w-5 text-primary" />
                Buy Product
              </DialogTitle>
            </DialogHeader>
            <div className="space-y-4">
              <div className="flex items-center gap-4 p-4 rounded-xl bg-muted/50 border border-border/50">
                <div className="h-14 w-14 rounded-xl bg-primary/10 flex items-center justify-center shrink-0">
                  <Package className="h-7 w-7 text-primary" />
                </div>
                <div className="min-w-0">
                  <p className="font-semibold truncate">{product.product_name}</p>
                  <div className="flex items-center gap-2 mt-1">
                    <code className="text-xs bg-muted px-1.5 py-0.5 rounded">{product.sku}</code>
                    {product.category && <Badge variant="secondary" className="text-xs">{product.category}</Badge>}
                  </div>
                  <p className="text-sm text-muted-foreground mt-1">
                    Total Base Stock: {product.quantity}
                  </p>
                </div>
              </div>

              {variants.length > 0 && (
                <div className="space-y-2">
                  <Label className="text-xs font-bold uppercase tracking-wider text-muted-foreground">Select Quantity / Option</Label>
                  <div className="flex flex-wrap gap-2">
                    {variants.map((v: any) => (
                      <button
                        key={v.id}
                        onClick={() => { setSelectedVariantId(v.id); setQty(1); }}
                        className={`px-4 py-2 rounded-xl text-xs font-bold transition-all border ${
                          selectedVariantId === v.id 
                            ? 'bg-primary text-primary-foreground border-primary shadow-lg shadow-primary/20 scale-105' 
                            : 'bg-card text-muted-foreground border-border hover:border-primary/30'
                        }`}
                      >
                        {v.label} - ₹{v.price} ({v.quantity} left)
                      </button>
                    ))}
                  </div>
                </div>
              )}

              <div className="space-y-2">
                <Label>Order Quantity</Label>
                <Input
                  type="number"
                  min={1}
                  max={currentStock}
                  value={qty}
                  onChange={e => setQty(Math.max(1, Math.min(currentStock || 1, parseInt(e.target.value) || 1)))}
                />
              </div>

              <div className="rounded-xl border border-border/50 p-4 space-y-2 bg-muted/30">
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Subtotal</span>
                  <span className="flex items-center"><IndianRupee className="h-3 w-3" />{subtotal.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">GST (18%)</span>
                  <span className="flex items-center"><IndianRupee className="h-3 w-3" />{gst.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
                </div>
                <div className="border-t border-border/50 pt-2 flex justify-between font-bold">
                  <span>Total</span>
                  <span className="flex items-center text-primary text-lg"><IndianRupee className="h-4 w-4" />{total.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
                </div>
              </div>

              <Button className="w-full gap-2" onClick={() => setStep('payment')}>
                Proceed to Payment
              </Button>
            </div>
          </>
        )}

        {step === 'payment' && (
          <>
            <DialogHeader>
              <DialogTitle>Choose Payment Method</DialogTitle>
            </DialogHeader>
            <div className="space-y-3">
              {paymentMethods.map(m => (
                <button
                  key={m.key}
                  onClick={() => setPaymentMethod(m.key)}
                  className={`w-full flex items-center gap-4 p-4 rounded-xl border-2 transition-all duration-200 text-left ${
                    paymentMethod === m.key
                      ? 'border-primary bg-primary/5 shadow-sm'
                      : 'border-border/50 hover:border-primary/30 hover:bg-muted/30'
                  }`}
                >
                  <div className={`p-2.5 rounded-lg ${paymentMethod === m.key ? 'bg-primary/10 text-primary' : 'bg-muted text-muted-foreground'}`}>
                    {m.icon}
                  </div>
                  <div>
                    <p className="font-medium text-sm">{m.label}</p>
                    <p className="text-xs text-muted-foreground">{m.desc}</p>
                  </div>
                  {paymentMethod === m.key && (
                    <div className="ml-auto">
                      <div className="h-5 w-5 rounded-full bg-primary flex items-center justify-center">
                        <CheckCircle2 className="h-3 w-3 text-primary-foreground" />
                      </div>
                    </div>
                  )}
                </button>
              ))}

              <div className="pt-2 flex justify-between items-center">
                <span className="text-sm text-muted-foreground">Total:</span>
                <span className="font-bold text-lg flex items-center text-primary"><IndianRupee className="h-4 w-4" />{total.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
              </div>

              <div className="flex gap-2">
                <Button variant="outline" onClick={() => setStep('details')} className="flex-1">Back</Button>
                <Button onClick={handlePay} className="flex-1 gap-2">
                  <CreditCard className="h-4 w-4" />
                  Pay Now
                </Button>
              </div>
            </div>
          </>
        )}

        {step === 'processing' && (
          <div className="py-12 text-center space-y-4">
            <div className="relative mx-auto w-16 h-16">
              <div className="absolute inset-0 rounded-full border-4 border-primary/20" />
              <div className="absolute inset-0 rounded-full border-4 border-primary border-t-transparent animate-spin" />
              <Loader2 className="absolute inset-0 m-auto h-6 w-6 text-primary animate-pulse" />
            </div>
            <div>
              <p className="font-semibold text-lg">Processing Payment...</p>
              <p className="text-sm text-muted-foreground mt-1">Please wait while we confirm your payment</p>
            </div>
          </div>
        )}

        {step === 'success' && (
          <div className="py-10 text-center space-y-4">
            <div className="mx-auto w-16 h-16 rounded-full bg-success/10 flex items-center justify-center animate-scale-in">
              <CheckCircle2 className="h-8 w-8 text-success" />
            </div>
            <div>
              <p className="font-bold text-xl">Payment Successful!</p>
              <p className="text-sm text-muted-foreground mt-1">Your order has been placed successfully</p>
            </div>
            <div className="rounded-xl border border-border/50 p-4 text-left space-y-1.5 bg-muted/30">
              <div className="flex justify-between text-sm">
                <span className="text-muted-foreground">Product</span>
                <span className="font-medium">{product.product_name}</span>
              </div>
              <div className="flex justify-between text-sm">
                <span className="text-muted-foreground">Qty</span>
                <span>{qty}</span>
              </div>
              <div className="flex justify-between text-sm">
                <span className="text-muted-foreground">Amount Paid</span>
                <span className="font-bold flex items-center text-primary"><IndianRupee className="h-3 w-3" />{total.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
              </div>
              <div className="flex justify-between text-sm">
                <span className="text-muted-foreground">Method</span>
                <span className="capitalize">{paymentMethod}</span>
              </div>
            </div>
            <Button onClick={handleClose} className="w-full">Done</Button>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
}
