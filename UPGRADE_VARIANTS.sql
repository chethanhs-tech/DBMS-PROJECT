-- ================================================================
-- GROZOSPHERE: MULTI-VARIANT INVENTORY UPGRADE
-- Adds per-variant stock tracking and standardized quantity levels.
-- ================================================================

-- 1. Create Variants Table
CREATE TABLE IF NOT EXISTS public.product_variants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    sku TEXT UNIQUE NOT NULL,
    label TEXT NOT NULL, -- e.g. '500g', '1kg', '1L'
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    quantity INTEGER DEFAULT 0 CHECK (quantity >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 2. Enhance Dependent Tables with variant_id
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS variant_id UUID REFERENCES public.product_variants(id) ON DELETE SET NULL;
ALTER TABLE public.transactions ADD COLUMN IF NOT EXISTS variant_id UUID REFERENCES public.product_variants(id) ON DELETE SET NULL;
ALTER TABLE public.alerts ADD COLUMN IF NOT EXISTS variant_id UUID REFERENCES public.product_variants(id) ON DELETE CASCADE;

-- 3. Robust Stock Management Trigger (Hybrid Variant/Master)
CREATE OR REPLACE FUNCTION public.update_stock_on_transaction()
RETURNS trigger AS $$
BEGIN
    -- Priority 1: Update Specific Variant Stock
    IF NEW.variant_id IS NOT NULL THEN
        IF NEW.transaction_type = 'purchase' THEN
            UPDATE public.product_variants SET quantity = quantity + NEW.quantity WHERE id = NEW.variant_id;
        ELSIF NEW.transaction_type = 'sale' THEN
            UPDATE public.product_variants SET quantity = quantity - NEW.quantity WHERE id = NEW.variant_id;
        END IF;
    -- Priority 2: Fallback to Master Product Stock
    ELSE
        IF NEW.transaction_type = 'purchase' THEN
            UPDATE public.products SET quantity = quantity + NEW.quantity WHERE id = NEW.product_id;
        ELSIF NEW.transaction_type = 'sale' THEN
            UPDATE public.products SET quantity = quantity - NEW.quantity WHERE id = NEW.product_id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Order-to-Transaction Sync (Now includes variant_id)
CREATE OR REPLACE FUNCTION public.sync_order_to_transaction()
RETURNS trigger AS $$
BEGIN
    IF NEW.status = 'completed' THEN
        INSERT INTO public.transactions (product_id, variant_id, transaction_type, quantity, user_id)
        VALUES (NEW.product_id, NEW.variant_id, 'sale', NEW.quantity, NEW.user_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. Real-Time & Security
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND tablename = 'product_variants') 
  THEN ALTER PUBLICATION supabase_realtime ADD TABLE product_variants; END IF;
END $$;

ALTER TABLE public.product_variants ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Variants are viewable by everyone" ON public.product_variants;
CREATE POLICY "Variants are viewable by everyone" ON public.product_variants FOR SELECT USING (true);

DROP POLICY IF EXISTS "Admins full management variants" ON public.product_variants;
CREATE POLICY "Admins full management variants" ON public.product_variants FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
);

-- 6. Cleanup products.variations JSONB (Deprecated)
-- We keep it for now but won't use it in UI.
ALTER TABLE public.products ALTER COLUMN variations SET DEFAULT '[]';

NOTIFY pgrst, 'reload schema';
