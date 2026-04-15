import { Navigate } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';

const Index = () => {
  const { user, loading } = useAuth();
  
  if (loading) return null;
  
  // If logged in, go to dashboard, else shop (accessible via auth)
  return <Navigate to={user ? "/dashboard" : "/shop"} replace />;
};

export default Index;
