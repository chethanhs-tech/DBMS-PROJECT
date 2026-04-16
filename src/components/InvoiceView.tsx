import { useRef } from 'react';
import type { Order } from '@/hooks/useOrders';
import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Badge } from '@/components/ui/badge';
import { Download, IndianRupee, FileText } from 'lucide-react';

interface InvoiceViewProps {
  order: Order | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export default function InvoiceView({ order, open, onOpenChange }: InvoiceViewProps) {
  const printRef = useRef<HTMLDivElement>(null);

  if (!order) return null;

  const subtotal = order.total_amount - order.gst_amount;

  const handleDownload = () => {
    const el = printRef.current;
    if (!el) return;
    const printWindow = window.open('', '_blank');
    if (!printWindow) return;
    printWindow.document.write(`
      <html><head><title>Invoice ${order.invoice_number}</title>
      <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; }
        body { padding: 40px; color: #1a1a1a; }
        .invoice { max-width: 600px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 32px; padding-bottom: 24px; border-bottom: 2px solid #e5e7eb; }
        .brand { font-size: 24px; font-weight: 700; color: #22c55e; }
        .brand-sub { font-size: 12px; color: #6b7280; margin-top: 4px; }
        .invoice-meta { text-align: right; font-size: 13px; }
        .invoice-meta strong { display: block; font-size: 16px; margin-bottom: 4px; }
        .section { margin-bottom: 24px; }
        .section-title { font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: #6b7280; margin-bottom: 8px; font-weight: 600; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 10px 12px; background: #f3f4f6; font-size: 12px; text-transform: uppercase; letter-spacing: 0.05em; color: #6b7280; }
        td { padding: 12px; border-bottom: 1px solid #f3f4f6; font-size: 14px; }
        .amount-col { text-align: right; }
        .totals { margin-top: 16px; }
        .total-row { display: flex; justify-content: space-between; padding: 6px 12px; font-size: 14px; }
        .total-row.final { font-size: 18px; font-weight: 700; color: #22c55e; border-top: 2px solid #e5e7eb; padding-top: 12px; margin-top: 8px; }
        .footer { margin-top: 40px; padding-top: 24px; border-top: 1px solid #e5e7eb; text-align: center; font-size: 12px; color: #9ca3af; }
        .badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; background: #dcfce7; color: #16a34a; }
        @media print { body { padding: 20px; } }
      </style>
      </head><body>
        <div class="invoice">
          <div class="header">
            <div>
              <div class="brand">GrozoSphere</div>
              <div class="brand-sub">Smart Groceries. Smarter Inventory.</div>
            </div>
            <div class="invoice-meta">
              <strong>${order.invoice_number}</strong>
              <div>${new Date(order.created_at).toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })}</div>
              <div style="margin-top:8px"><span class="badge">Paid</span></div>
            </div>
          </div>
          <div class="section">
            <div class="section-title">Order Details</div>
            <table>
              <thead><tr><th>Product</th><th>Qty</th><th class="amount-col">Unit Price</th><th class="amount-col">Amount</th></tr></thead>
              <tbody>
                <tr>
                  <td>${order.product_name}</td>
                  <td>${order.quantity}</td>
                  <td class="amount-col">₹${order.unit_price.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</td>
                  <td class="amount-col">₹${subtotal.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="totals">
            <div class="total-row"><span>Subtotal</span><span>₹${subtotal.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
            <div class="total-row"><span>GST (18%)</span><span>₹${order.gst_amount.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
            <div class="total-row final"><span>Total</span><span>₹${order.total_amount.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span></div>
          </div>
          <div class="section" style="margin-top:24px">
            <div class="section-title">Payment Info</div>
            <div class="total-row"><span>Method</span><span style="text-transform:capitalize">${order.payment_method}</span></div>
            <div class="total-row"><span>Status</span><span class="badge">Completed</span></div>
          </div>
          <div class="footer">
            <p>Thank you for shopping with GrozoSphere!</p>
            <p style="margin-top:4px">Smart Groceries. Smarter Inventory.</p>
          </div>
        </div>
        <script>window.print();window.onafterprint=()=>window.close();</script>
      </body></html>
    `);
    printWindow.document.close();
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <FileText className="h-5 w-5 text-primary" />
            Invoice {order.invoice_number}
          </DialogTitle>
        </DialogHeader>

        <div ref={printRef} className="space-y-4">
          <div className="flex justify-between items-start p-4 rounded-xl bg-primary/5 border border-primary/10">
            <div>
              <p className="font-bold text-lg text-primary">GrozoSphere</p>
              <p className="text-xs text-muted-foreground">Smart Groceries. Smarter Inventory.</p>
            </div>
            <div className="text-right">
              <p className="font-mono text-sm font-bold">{order.invoice_number}</p>
              <p className="text-xs text-muted-foreground mt-1">
                {new Date(order.created_at).toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })}
              </p>
            </div>
          </div>

          <div className="rounded-xl border border-border/50 overflow-hidden">
            <div className="grid grid-cols-4 bg-muted/50 px-4 py-2.5 text-xs font-semibold text-muted-foreground uppercase tracking-wider">
              <span className="col-span-1">Product</span>
              <span className="text-center">Qty</span>
              <span className="text-right">Unit Price</span>
              <span className="text-right">Amount</span>
            </div>
            <div className="grid grid-cols-4 px-4 py-3 text-sm">
              <span className="col-span-1 font-medium">{order.product_name}</span>
              <span className="text-center">{order.quantity}</span>
              <span className="text-right flex items-center justify-end"><IndianRupee className="h-3 w-3" />{order.unit_price.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
              <span className="text-right flex items-center justify-end"><IndianRupee className="h-3 w-3" />{subtotal.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
            </div>
          </div>

          <div className="rounded-xl border border-border/50 p-4 space-y-2">
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Subtotal</span>
              <span className="flex items-center"><IndianRupee className="h-3 w-3" />{subtotal.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">GST (18%)</span>
              <span className="flex items-center"><IndianRupee className="h-3 w-3" />{order.gst_amount.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
            </div>
            <div className="border-t pt-2 flex justify-between font-bold text-lg">
              <span>Total</span>
              <span className="flex items-center text-primary"><IndianRupee className="h-4 w-4" />{order.total_amount.toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
            </div>
          </div>

          <div className="flex justify-between text-sm px-1">
            <span className="text-muted-foreground">Payment: <span className="capitalize font-medium text-foreground">{order.payment_method}</span></span>
            <Badge className="bg-success/10 text-success border-0">Paid</Badge>
          </div>
        </div>

        <Button onClick={handleDownload} className="w-full gap-2 mt-2">
          <Download className="h-4 w-4" />
          Download / Print Invoice
        </Button>
      </DialogContent>
    </Dialog>
  );
}
