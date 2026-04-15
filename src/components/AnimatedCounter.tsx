import { useEffect, useState } from 'react';

interface AnimatedCounterProps {
  value: number;
  duration?: number;
  prefix?: string;
  suffix?: string;
}

export default function AnimatedCounter({ value: rawValue, duration = 800, prefix = '', suffix = '' }: AnimatedCounterProps) {
  const value = typeof rawValue === 'number' ? rawValue : 0;
  const [display, setDisplay] = useState(0);

  useEffect(() => {
    if (!Number.isFinite(value) || value === 0) { setDisplay(0); return; }
    const start = 0;
    const startTime = performance.now();

    const tick = (now: number) => {
      const elapsed = now - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const eased = 1 - Math.pow(1 - progress, 3);
      setDisplay(Math.round(start + (value - start) * eased));
      if (progress < 1) requestAnimationFrame(tick);
    };

    requestAnimationFrame(tick);
  }, [value, duration]);

  const displayValue = Number.isFinite(display) ? display : 0;
  return <span>{prefix}{displayValue.toLocaleString()}{suffix}</span>;
}
