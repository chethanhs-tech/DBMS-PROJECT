import { useState, useMemo } from 'react';
import { useCart } from '@/contexts/CartContext';
import { useAuth } from '@/contexts/AuthContext';
import { useAddresses } from '@/hooks/useAddresses';
import { supabase } from '@/integrations/supabase/client';
import { toast } from 'sonner';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { 
  ShoppingCart, 
  Trash2, 
  Plus, 
  Minus, 
  IndianRupee, 
  CreditCard, 
  Smartphone, 
  Building2, 
  CheckCircle2, 
  Loader2, 
  Package, 
  ArrowRight, 
  ArrowLeft, 
  ShoppingBag,
  MapPin,
  Clock,
  ChevronRight,
  Wallet
} from 'lucide-react';
import { Link } from 'react-router-dom';

type PaymentMethod = 'upi_id' | 'phonepe' | 'gpay' | 'card' | 'netbanking';
type Step = 'cart' | 'address' | 'payment' | 'processing' | 'success';
const GST_RATE = 0.18;

export default function CartPage() {
  const { items, removeFromCart, updateQuantity, clearCart, totalPrice, discount, appliedCoupon, applyCoupon, removeCoupon } = useCart();
  const { user } = useAuth();
  const { addresses, loading: addressesLoading } = useAddresses();
  
  const [step, setStep] = useState<Step>('cart');
  const [paymentMethod, setPaymentMethod] = useState<PaymentMethod>('upi_id');
  const [upiId, setUpiId] = useState('');
  const [selectedAddressId, setSelectedAddressId] = useState<string | null>(null);
  const [couponCode, setCouponCode] = useState('');

  const subtotalAfterDiscount = Math.max(0, totalPrice - discount);
  const gst = subtotalAfterDiscount * GST_RATE;
  const grandTotal = subtotalAfterDiscount + gst;

  // Set default address when loaded
  useState(() => {
    if (addresses.length > 0) {
      const def = addresses.find(a => a.is_default) || addresses[0];
      setSelectedAddressId(def.id);
    }
  });

  const selectedAddress = useMemo(() => 
    addresses.find(a => a.id === selectedAddressId), 
  [addresses, selectedAddressId]);

  const deliveryTime = useMemo(() => {
    if (!selectedAddress) return "15-20 mins";
    const pincode = parseInt(selectedAddress.pincode);
    if (pincode % 2 === 0) return "10-15 mins";
    return "20-30 mins";
  }, [selectedAddress]);

  const handleCheckout = async () => {
    if (!user || items.length === 0) return;
    
    if (paymentMethod === 'upi_id' && (!upiId || upiId.length < 3)) {
      toast.error("Please enter a valid UPI ID");
      return;
    }

    setStep('processing');
    await new Promise(r => setTimeout(r, 2500)); // Simulate bank processing

    try {
      const invoiceNumber = `GS-${Date.now().toString(36).toUpperCase()}`;
      
      // Map payment UI values to database enum
      const pgPaymentMethod = ['phonepe', 'gpay', 'paytm', 'upi_id'].includes(paymentMethod) 
        ? 'upi' 
        : paymentMethod;
      
      for (const item of items) {
        const itemTotal = item.product.price * item.quantity;
        const itemGst = itemTotal * GST_RATE;

        // Build the order payload — strictly matched to Supabase schema
        const orderPayload: Record<string, any> = {
          user_id: user.id,
          product_id: item.product.id,
          product_name: item.product.display_name || item.product.product_name,
          quantity: item.quantity,
          unit_price: item.product.price,
          total_amount: itemTotal + itemGst, // 'total_amount' matches the SQL 
          gst_amount: itemGst,
          payment_method: pgPaymentMethod, // Safely mapped to 'upi', 'card', 'netbanking'
          invoice_number: invoiceNumber,
          status: 'completed', // 'completed' ensures backend Postgres Triggers automatically create Transactions and deduct stock!
        };

        // Optional columns 
        if (item.product.variant_id) orderPayload.variant_id = item.product.variant_id;
        if (upiId) orderPayload.upi_id = upiId;
        if (selectedAddressId) orderPayload.address_id = selectedAddressId;
        if (deliveryTime) orderPayload.estimated_delivery_time = deliveryTime;

        let { error: orderError } = await supabase.from('orders').insert(orderPayload as any);
        
        // Let the backend triggers safely handle transaction creation and stock updates
        // to bypass the frontend strictly enforcing RLS restrictions against customers.
        if (orderError) {
          throw orderError;
        }
      }

      // --- NEW: UPLOAD RECEIPT TO STORAGE ---
      try {
        const receiptHTML = `
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Receipt ${invoiceNumber}</title>
  <style>
    body { font-family: 'Courier New', Courier, monospace; background: #f8f9fa; color: #111; padding: 40px; display: flex; justify-content: center; }
    .receipt { background: #fff; padding: 30px; width: 400px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); border-top: 4px solid #10b981; }
    .header { text-align: center; margin-bottom: 20px; border-bottom: 2px dashed #ccc; padding-bottom: 20px; }
    .header h1 { margin: 0; color: #10b981; font-size: 24px; text-transform: uppercase; letter-spacing: 2px; }
    .header p { margin: 5px 0; font-size: 14px; color: #666; }
    .item-row { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 14px; }
    .item-name { flex: 1; padding-right: 15px; }
    .divider { border-bottom: 1px dashed #ccc; margin: 15px 0; }
    .total-row { display: flex; justify-content: space-between; font-weight: bold; font-size: 18px; margin-top: 20px; }
    .footer { text-align: center; margin-top: 30px; font-size: 12px; color: #888; }
  </style>
</head>
<body>
  <div class="receipt">
    <div class="header">
      <h1>GrozoSphere</h1>
      <p>Order Invoice: ${invoiceNumber}</p>
      <p>Customer: ${user.email}</p>
      <p>Date: ${new Date().toLocaleString()}</p>
    </div>
    
    <div class="items">
      ${items.map(i => `
        <div class="item-row">
          <span class="item-name">${i.quantity}x ${i.product.display_name || i.product.product_name}</span>
          <span>₹${(i.product.price * i.quantity).toLocaleString('en-IN')}</span>
        </div>
      `).join('')}
    </div>

    <div class="divider"></div>
    
    <div class="item-row">
      <span class="item-name">Subtotal</span>
      <span>₹${totalPrice.toLocaleString('en-IN')}</span>
    </div>
    <div class="item-row">
      <span class="item-name">GST (18%)</span>
      <span>₹${gst.toLocaleString('en-IN', { maximumFractionDigits: 0 })}</span>
    </div>
    
    <div class="total-row">
      <span>GRAND TOTAL</span>
      <span>₹${grandTotal.toLocaleString('en-IN', { maximumFractionDigits: 0 })}</span>
    </div>

    <div class="footer">
      <p>Thank you for shopping at GrozoSphere!</p>
      <p>Delivering fresh to your door.</p>
    </div>
  </div>
</body>
</html>
        `;

        const fileName = `${invoiceNumber}.html`;
        const { error: uploadError } = await supabase.storage
          .from('order-receipts')
          .upload(fileName, new Blob([receiptHTML], { type: 'text/html' }));

        if (uploadError) console.error("Receipt upload failed:", uploadError);
        else logSync(`Receipt archived successfully to order-receipts: ${fileName}`);
      } catch (err) {
        console.error("Receipt generation failed:", err);
      }

      setStep('success');
      clearCart();
    } catch (err: any) {
      console.error("Checkout Sync Error:", err);
      toast.error(err.message || 'Payment processing failed');
      setStep('cart');
    }
  };

  // Helper for logging if needed
  const logSync = (msg: string) => {
    console.log(`[Sync] ${msg}`);
  };


  if (step === 'processing') {
    return (
      <div className="flex flex-col items-center justify-center min-h-[60vh] text-center px-4">
        <div className="w-24 h-24 relative mb-8">
          <div className="absolute inset-0 rounded-full border-4 border-primary/20" />
          <div className="absolute inset-0 rounded-full border-4 border-primary border-t-transparent animate-spin" />
          <Loader2 className="absolute inset-0 m-auto h-8 w-8 text-primary animate-pulse" />
        </div>
        <h2 className="text-3xl font-black mb-2 tracking-tight">Securing your payment</h2>
        <p className="text-muted-foreground max-w-xs font-medium">Connecting to {paymentMethod.replace('_', ' ').toUpperCase()} gateway. Please do not refresh.</p>
      </div>
    );
  }

  if (step === 'success') {
    return (
      <div className="flex flex-col items-center justify-center min-h-[60vh] text-center px-4 animate-in fade-in slide-in-from-bottom-5 duration-700">
        <div className="w-28 h-28 rounded-full bg-success/10 flex items-center justify-center mb-10 shadow-inner relative">
          <CheckCircle2 className="h-14 w-14 text-success" />
          <div className="absolute -inset-4 rounded-full border border-success/20 animate-ping opacity-20" />
        </div>
        <h2 className="text-4xl font-black mb-3 tracking-tight">Order Placed! 🎉</h2>
        <p className="text-lg text-muted-foreground mb-10 max-w-sm font-medium">
          Freshness is on its way! Delivering to <span className="text-foreground font-black">{selectedAddress?.city}</span> in <span className="text-primary font-black">{deliveryTime}</span>.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 w-full max-w-md">
          <Button asChild size="lg" className="flex-1 rounded-2xl h-14 font-black text-lg shadow-xl shadow-primary/20">
            <Link to="/orders">Track My Order</Link>
          </Button>
          <Button variant="outline" size="lg" className="flex-1 rounded-2xl h-14 font-black text-lg border-2" asChild>
            <Link to="/shop">Shop More</Link>
          </Button>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-6xl mx-auto space-y-12 pb-24">
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
        <div>
          <h1 className="text-4xl font-black tracking-tight flex items-center gap-3">
            <ShoppingCart className="h-10 w-10 text-primary" /> Checkout
          </h1>
          <p className="text-muted-foreground mt-2 font-medium italic">Complete your grocery haul</p>
        </div>
        {/* Progress Tracker */}
        <div className="flex items-center gap-2">
          {['cart', 'address', 'payment'].map((s, i) => (
             <div key={s} className="flex items-center">
                <div className={`h-8 w-8 rounded-lg flex items-center justify-center text-xs font-black border-2 transition-all duration-500 ${
                  step === s ? 'bg-primary border-primary text-primary-foreground shadow-lg shadow-primary/20 scale-110' :
                  i < ['cart', 'address', 'payment'].indexOf(step) ? 'bg-success/20 border-success text-success' : 'border-border/50 text-muted-foreground opacity-50'
                }`}>
                  {i < ['cart', 'address', 'payment'].indexOf(step) ? <CheckCircle2 className="h-4 w-4" /> : i + 1}
                </div>
                {i < 2 && <div className={`w-8 h-1 transition-colors duration-500 ${i < ['cart', 'address', 'payment'].indexOf(step) ? 'bg-success' : 'bg-border/50'}`} />}
             </div>
          ))}
        </div>
      </div>

      {items.length === 0 ? (
        <Card className="glass-card border-dashed border-2 py-24 rounded-[3rem]">
          <CardContent className="text-center space-y-6">
            <div className="w-24 h-24 bg-muted/50 rounded-[2rem] flex items-center justify-center mx-auto mb-4">
              <ShoppingBag className="h-12 w-12 text-muted-foreground/30" />
            </div>
            <p className="text-2xl font-black text-muted-foreground">Your basket is resting...</p>
            <Button asChild className="rounded-full px-12 h-14 font-black shadow-xl shadow-primary/20 text-lg">
              <Link to="/shop">Explore Fresh Items <ArrowRight className="ml-2 h-6 w-6" /></Link>
            </Button>
          </CardContent>
        </Card>
      ) : (
        <div className="grid grid-cols-1 lg:grid-cols-[1.6fr_1fr] gap-12 items-start">
          
          <div className="space-y-8 animate-in fade-in slide-in-from-left-4 duration-500">
            {/* --- STEP 1: CART ITEMS --- */}
            {step === 'cart' && (
              <div className="space-y-4">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-xl font-black flex items-center gap-2">Review Basket <Badge variant="secondary" className="rounded-full">{items.length}</Badge></h3>
                  <Button variant="ghost" size="sm" className="text-destructive font-black uppercase text-[10px] tracking-widest hover:bg-destructive/5" onClick={clearCart}>Clear All</Button>
                </div>
                {items.map(item => (
                  <Card key={item.product.id + (item.product.display_name || '')} className="glass-card border-border/50 hover:shadow-xl transition-all duration-500 rounded-3xl overflow-hidden group">
                    <CardContent className="p-5 flex items-center gap-5">
                      <div className="h-20 w-20 rounded-2xl bg-secondary flex items-center justify-center overflow-hidden relative shadow-inner">
                        {item.product.image_url ? (
                          <img src={item.product.image_url} alt={item.product.product_name} className="h-full w-full object-cover group-hover:scale-110 transition-transform duration-700" />
                        ) : (
                          <Package className="h-10 w-10 text-muted-foreground/20" />
                        )}
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className="text-[10px] font-black text-primary uppercase tracking-widest leading-none mb-1">{item.product.category || 'Fresh'}</p>
                        <h4 className="font-black text-lg truncate leading-tight">{item.product.display_name || item.product.product_name}</h4>
                        <p className="text-xl font-black mt-2 text-foreground/80">₹{item.product.price.toLocaleString('en-IN')}</p>
                      </div>
                      <div className="flex flex-col items-end gap-3">
                        <div className="flex items-center gap-1 bg-secondary/80 p-1 rounded-2xl border border-border/30 shadow-sm">
                          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-xl hover:bg-card" onClick={() => updateQuantity(item.product.id, item.quantity - 1, item.product.variant_id)}>
                            <Minus className="h-3 w-3" />
                          </Button>
                          <span className="w-10 text-center font-black text-sm">{item.quantity}</span>
                          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-xl hover:bg-card" onClick={() => updateQuantity(item.product.id, item.quantity + 1, item.product.variant_id)} disabled={item.quantity >= item.product.quantity}>
                            <Plus className="h-3 w-3" />
                          </Button>
                        </div>
                        <button className="text-destructive/60 hover:text-destructive font-black text-[10px] uppercase tracking-widest transition-colors mr-2" onClick={() => removeFromCart(item.product.id, item.product.variant_id)}>
                          Remove
                        </button>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            )}

            {/* --- STEP 2: ADDRESS SELECTION --- */}
            {step === 'address' && (
              <div className="space-y-6 animate-in slide-in-from-right-4 duration-500">
                <div className="flex items-center justify-between">
                   <h3 className="text-xl font-black flex items-center gap-2">Select Address <MapPin className="h-5 w-5 text-primary" /></h3>
                   <Link to="/profile" className="text-xs font-black text-primary hover:underline">+ Manage Addresses</Link>
                </div>
                
                {addressesLoading ? (
                  <div className="py-20 flex justify-center"><Loader2 className="h-8 w-8 text-primary animate-spin" /></div>
                ) : addresses.length === 0 ? (
                  <Card className="rounded-[2.5rem] border-border/50 border-dashed border-2 p-12 text-center space-y-4">
                     <MapPin className="h-10 w-10 text-muted-foreground/20 mx-auto" />
                     <p className="font-black text-muted-foreground">No address found. Plase add one.</p>
                     <Button asChild className="rounded-xl font-black"><Link to="/profile">Add Address</Link></Button>
                  </Card>
                ) : (
                  <div className="space-y-4">
                    {addresses.map((addr) => (
                      <button
                        key={addr.id}
                        onClick={() => setSelectedAddressId(addr.id)}
                        className={`w-full text-left p-6 rounded-[2rem] border-2 transition-all duration-300 relative group flex items-start gap-4 ${
                          selectedAddressId === addr.id ? 'border-primary bg-primary/5 shadow-xl shadow-primary/5 ring-4 ring-primary/5' : 'border-border/50 hover:border-primary/20'
                        }`}
                      >
                         <div className={`mt-1 p-3 rounded-2xl transition-colors ${selectedAddressId === addr.id ? 'bg-primary text-primary-foreground shadow-lg shadow-primary/30' : 'bg-muted text-muted-foreground'}`}>
                            <MapPin className="h-5 w-5" />
                         </div>
                         <div className="flex-1">
                            <div className="flex items-center gap-2 mb-1">
                               <p className="font-black text-lg">{addr.full_name}</p>
                               {addr.is_default && <Badge className="bg-success text-white text-[8px] h-4 rounded-full font-black border-none uppercase">Default</Badge>}
                            </div>
                            <p className="text-xs font-bold text-muted-foreground mb-3">{addr.phone_number}</p>
                            <p className="text-sm font-medium leading-relaxed text-foreground/80">
                               {addr.house_no}, {addr.street}, {addr.landmark && `${addr.landmark}, `}{addr.city} - {addr.pincode}
                            </p>
                         </div>
                         {selectedAddressId === addr.id && (
                           <div className="absolute top-6 right-6 h-6 w-6 rounded-full bg-primary flex items-center justify-center shadow-lg shadow-primary/20">
                              <CheckCircle2 className="h-4 w-4 text-white" />
                           </div>
                         )}
                      </button>
                    ))}
                    <div className="flex items-center gap-2 p-4 bg-success/10 border border-success/20 rounded-2xl text-success animate-in fade-in zoom-in">
                       <Clock className="h-4 w-4" />
                       <p className="text-xs font-black uppercase tracking-widest">Delivery estimated in {deliveryTime}</p>
                    </div>
                  </div>
                )}
              </div>
            )}

            {/* --- STEP 3: PAYMENT --- */}
            {step === 'payment' && (
              <div className="space-y-8 animate-in slide-in-from-right-4 duration-500">
                <h3 className="text-xl font-black flex items-center gap-2">Secure Payment <Wallet className="h-5 w-5 text-primary" /></h3>
                
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                   {[
                      { key: 'upi_id' as const, label: 'UPI Personal', icon: <Smartphone />, desc: 'Use any UPI app' },
                      { key: 'phonepe' as const, label: 'PhonePe', icon: <img src="https://img.icons8.com/color/48/phone-pe.png" className="w-8 h-8" />, desc: 'Instant app checkout' },
                      { key: 'gpay' as const, label: 'Google Pay', icon: <img src="https://img.icons8.com/color/48/google-pay.png" className="w-8 h-8" />, desc: 'Secure with GPay' },
                      { key: 'card' as const, label: 'Credit/Debit', icon: <CreditCard />, desc: 'Safe & SSL secured' }
                   ].map(m => (
                      <button
                        key={m.key}
                        onClick={() => setPaymentMethod(m.key)}
                        className={`p-6 rounded-[2rem] border-2 text-left transition-all duration-300 relative group flex flex-col gap-4 ${
                          paymentMethod === m.key ? 'border-primary bg-primary/5 ring-4 ring-primary/5' : 'border-border/50 hover:border-primary/10'
                        }`}
                      >
                         <div className={`w-14 h-14 rounded-2xl flex items-center justify-center shadow-inner ${paymentMethod === m.key ? 'bg-primary text-primary-foreground' : 'bg-muted text-muted-foreground'}`}>
                            {m.icon}
                         </div>
                         <div>
                            <p className="font-black text-lg leading-none mb-1">{m.label}</p>
                            <p className="text-xs font-medium text-muted-foreground">{m.desc}</p>
                         </div>
                         {paymentMethod === m.key && <CheckCircle2 className="absolute top-6 right-6 h-6 w-6 text-primary" />}
                      </button>
                   ))}
                </div>

                {paymentMethod === 'upi_id' && (
                  <Card className="rounded-[1.5rem] bg-secondary/30 border-border/50 overflow-hidden animate-in zoom-in-95 duration-300">
                    <CardContent className="p-6 space-y-4">
                       <Label className="font-black text-sm uppercase tracking-widest text-muted-foreground">Enter UPI ID</Label>
                       <div className="relative">
                          <Input 
                            value={upiId}
                            onChange={(e) => setUpiId(e.target.value)}
                            placeholder="username@okaxis" 
                            className="h-14 rounded-2xl bg-background border-none shadow-sm focus-visible:ring-primary pl-12 font-bold" 
                          />
                          <Smartphone className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-primary opacity-50" />
                       </div>
                       <p className="text-[10px] text-muted-foreground font-medium px-2 italic">A payment request will be sent to your mobile app.</p>
                    </CardContent>
                  </Card>
                )}
              </div>
            )}
          </div>

          {/* --- SIDEBAR: ORDER SUMMARY --- */}
          <div className="sticky top-24 space-y-6">
            <Card className="glass-card shadow-2xl rounded-[3rem] border-border/50 overflow-hidden border-2">
              <CardHeader className="bg-muted/30 border-b border-border/50 px-8 py-6">
                <CardTitle className="text-2xl font-black">Checkout Summary</CardTitle>
              </CardHeader>
              <CardContent className="p-8 space-y-8">
                <div className="space-y-4">
                  <div className="flex justify-between items-center">
                    <span className="text-sm font-bold text-muted-foreground">Order Total ({items.length} items)</span>
                    <span className="text-lg font-black">₹{totalPrice.toLocaleString('en-IN')}</span>
                  </div>
                  
                  {discount > 0 && (
                    <div className="flex justify-between items-center animate-in slide-in-from-right duration-300">
                      <div className="flex flex-col gap-0.5">
                        <span className="text-sm font-bold text-success">Discount ({appliedCoupon})</span>
                        <button onClick={removeCoupon} className="text-[10px] font-black text-destructive uppercase tracking-widest text-left hover:underline">Remove</button>
                      </div>
                      <span className="text-lg font-black text-success">-₹{discount.toLocaleString('en-IN')}</span>
                    </div>
                  )}

                  <div className="flex justify-between items-center">
                    <span className="text-sm font-bold text-muted-foreground">GST (18%)</span>
                    <span className="text-lg font-black">₹{gst.toLocaleString('en-IN', { maximumFractionDigits: 0 })}</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-sm font-bold text-primary italic">Delivery Fee</span>
                    <Badge className="bg-success text-white border-none font-black text-[10px] rounded-full px-3 py-1">FREE</Badge>
                  </div>
                </div>

                {/* Coupon Input */}
                {!appliedCoupon && (
                  <div className="pt-2">
                    <div className="relative group">
                      <Input 
                        placeholder="Apply Coupon (e.g. GROZO20)" 
                        className="h-12 rounded-2xl pr-24 font-bold border-dashed border-2 bg-muted/20 focus-visible:ring-primary focus-visible:border-primary transition-all"
                        value={couponCode}
                        onChange={(e) => setCouponCode(e.target.value)}
                        onKeyPress={(e) => e.key === 'Enter' && applyCoupon(couponCode)}
                      />
                      <Button 
                        size="sm" 
                        className="absolute right-1 top-1 bottom-1 rounded-xl font-black px-4"
                        onClick={() => { applyCoupon(couponCode); setCouponCode(''); }}
                        disabled={!couponCode.trim()}
                      >
                        Apply
                      </Button>
                    </div>
                    <div className="flex gap-2 mt-2 px-1">
                      {['GROZO20', 'SAVE50'].map(code => (
                        <button 
                          key={code}
                          onClick={() => applyCoupon(code)}
                          className="text-[9px] font-black text-primary/60 hover:text-primary transition-colors border border-primary/20 rounded-full px-2 py-0.5 bg-primary/5"
                        >
                          {code}
                        </button>
                      ))}
                    </div>
                  </div>
                )}
                
                <div className="pt-6 border-t border-dashed border-border/50">
                  <span className="text-xs font-black uppercase tracking-widest text-muted-foreground opacity-60">To Pay Securely</span>
                  <div className="flex items-end justify-between mt-1">
                    <p className="text-4xl font-black text-primary tracking-tighter">₹{grandTotal.toLocaleString('en-IN', { maximumFractionDigits: 0 })}</p>
                    <p className="text-[10px] font-bold text-success flex items-center gap-1 mb-2"><CheckCircle2 className="h-3 w-3" /> All taxes included</p>
                  </div>
                </div>

                {/* Dynamic Actions based on Step */}
                {!user ? (
                  <Button asChild className="w-full h-16 rounded-[1.5rem] text-xl font-black shadow-2xl shadow-primary/20 gap-3 group bg-orange-500 hover:bg-orange-600">
                    <Link to="/auth">Login to Checkout <ArrowRight className="h-6 w-6" /></Link>
                  </Button>
                ) : step === 'cart' && (
                  <Button onClick={() => setStep('address')} className="w-full h-16 rounded-[1.5rem] text-xl font-black shadow-2xl shadow-primary/20 gap-3 group">
                    Next: Delivery <ChevronRight className="h-6 w-6 group-hover:translate-x-1 transition-transform" />
                  </Button>
                )}
                
                {step === 'address' && (
                  <div className="space-y-4">
                    <Button onClick={() => setStep('payment')} disabled={!selectedAddressId} className="w-full h-16 rounded-[1.5rem] text-xl font-black shadow-2xl shadow-primary/20 gap-3 group">
                      Proceed to Payment <ChevronRight className="h-6 w-6 group-hover:translate-x-1 transition-transform" />
                    </Button>
                    <Button variant="ghost" onClick={() => setStep('cart')} className="w-full font-bold text-muted-foreground hover:bg-transparent">
                      <ArrowLeft className="mr-2 h-4 w-4" /> Back to Basket
                    </Button>
                  </div>
                )}

                {step === 'payment' && (
                  <div className="space-y-4">
                    <Button onClick={handleCheckout} className="w-full h-16 rounded-[1.5rem] text-xl font-black shadow-2xl shadow-primary/20 gap-3 group relative overflow-hidden">
                       <span className="relative z-10 flex items-center gap-2">Make Payment <ArrowRight className="h-5 w-5" /></span>
                       <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent -translate-x-full group-hover:translate-x-full transition-transform duration-1000" />
                    </Button>
                    <Button variant="ghost" onClick={() => setStep('address')} className="w-full font-bold text-muted-foreground hover:bg-transparent">
                      <ArrowLeft className="mr-2 h-4 w-4" /> Change Address
                    </Button>
                  </div>
                )}
                
                <div className="flex flex-col items-center gap-2 pt-4 opacity-40 grayscale group hover:grayscale-0 hover:opacity-100 transition-all duration-500">
                  <p className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground mb-2">Verified Secure Checkout</p>
                  <div className="flex gap-4 items-center">
                     <img src="https://img.icons8.com/color/48/visa.png" className="h-6 opacity-70" alt="Visa" />
                     <img src="https://img.icons8.com/color/48/mastercard.png" className="h-6 opacity-70" alt="MC" />
                     <img src="https://img.icons8.com/color/48/upi.png" className="h-8 opacity-70" alt="UPI" />
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Selected Address Mini Summary (Only on payment step) */}
            {step === 'payment' && selectedAddress && (
              <div className="p-6 bg-secondary/30 rounded-[2rem] border border-border/50 flex flex-col gap-2 animate-in fade-in duration-500">
                 <p className="text-[10px] font-black text-muted-foreground uppercase tracking-wider">Delivering to</p>
                 <div className="flex items-start gap-3">
                    <MapPin className="h-4 w-4 text-primary mt-1" />
                    <div>
                       <p className="text-sm font-black">{selectedAddress.full_name}</p>
                       <p className="text-xs text-muted-foreground line-clamp-2 leading-tight">
                         {selectedAddress.house_no}, {selectedAddress.street}, {selectedAddress.city}
                       </p>
                    </div>
                 </div>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

