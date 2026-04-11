
DROP POLICY "System can insert alerts" ON public.alerts;
CREATE POLICY "Admins can insert alerts" ON public.alerts FOR INSERT TO authenticated WITH CHECK (public.has_role(auth.uid(), 'admin'));
