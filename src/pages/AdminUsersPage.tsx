import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { toast } from 'sonner';
import { Users, Search, Shield, User, Loader2, MoreHorizontal, UserCog, UserMinus, CheckCircle2 } from 'lucide-react';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import type { Tables } from '@/integrations/supabase/types';

type Profile = Tables<'profiles'>;

export default function AdminUsersPage() {
  const [users, setUsers] = useState<Profile[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');

  const fetchUsers = async () => {
    setLoading(true);
    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .order('created_at', { ascending: false });

    if (error) {
      toast.error('Failed to load users');
    } else {
      setUsers(data || []);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleUpdateRole = async (userId: string, newRole: 'admin' | 'staff' | 'customer') => {
    try {
      // 1. Update Profile Role
      const { error: profileError } = await supabase
        .from('profiles')
        .update({ role: newRole })
        .eq('id', userId);

      if (profileError) throw profileError;

      // 2. Sync user_roles table (Insert/Update)
      // First, remove existing roles for this user to ensure clean state
      await supabase.from('user_roles').delete().eq('user_id', userId);
      
      // Add the new role
      const { error: roleError } = await supabase
        .from('user_roles')
        .insert({ user_id: userId, role: newRole });

      if (roleError) throw roleError;

      toast.success(`User updated to ${newRole}`);
      fetchUsers();
    } catch (err: any) {
      toast.error(err.message || 'Failed to update user role');
    }
  };

  const filteredUsers = users.filter(user => 
    user.name?.toLowerCase().includes(searchTerm.toLowerCase()) || 
    user.email?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="space-y-10 pb-20">
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
        <div>
          <h1 className="text-4xl font-black tracking-tight flex items-center gap-3">
            <Users className="h-10 w-10 text-primary" /> User Management
          </h1>
          <p className="text-muted-foreground mt-2 font-medium italic">Monitor and manage all GrozoSphere users</p>
        </div>
        <div className="relative w-full md:w-80">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input 
            placeholder="Search name or email..." 
            className="pl-11 rounded-full border-border/50 h-12 glass-card focus:ring-primary/20" 
            value={searchTerm}
            onChange={e => setSearchTerm(e.target.value)}
          />
        </div>
      </div>

      <div className="grid grid-cols-1 gap-6">
        {loading ? (
          <div className="flex flex-col items-center justify-center py-40 space-y-4">
            <Loader2 className="h-10 w-10 text-primary animate-spin" />
            <p className="font-bold text-muted-foreground animate-pulse">Fetching global user data...</p>
          </div>
        ) : filteredUsers.length === 0 ? (
          <div className="text-center py-20 bg-muted/20 border-2 border-dashed border-border/50 rounded-[3rem]">
            <User className="h-16 w-16 text-muted-foreground/20 mx-auto mb-4" />
            <p className="text-xl font-bold text-muted-foreground">No users matching your search.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
            {filteredUsers.map((u) => (
              <Card key={u.id} className="glass-card rounded-[2rem] border-border/50 hover:border-primary/20 transition-all duration-300 shadow-sm hover:shadow-xl group">
                <CardContent className="p-6 space-y-6">
                  <div className="flex items-center gap-4">
                    <div className="h-16 w-16 rounded-2xl bg-secondary flex items-center justify-center text-2xl font-black text-primary group-hover:scale-105 transition-transform duration-500">
                      {u.name?.charAt(0).toUpperCase()}
                    </div>
                    <div className="flex-1 min-w-0">
                      <h3 className="font-black text-lg truncate">{u.name || 'Anonymous User'}</h3>
                      <p className="text-xs text-muted-foreground truncate">{u.email}</p>
                    </div>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon" className="rounded-xl">
                          <MoreHorizontal className="h-5 w-5" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end" className="rounded-2xl min-w-[180px]">
                        <DropdownMenuLabel>Change Role</DropdownMenuLabel>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem className="gap-2 font-bold" onClick={() => handleUpdateRole(u.id, 'admin')}>
                          <Shield className="h-4 w-4 text-primary" /> Admin
                        </DropdownMenuItem>
                        <DropdownMenuItem className="gap-2 font-bold" onClick={() => handleUpdateRole(u.id, 'staff')}>
                          <UserCog className="h-4 w-4 text-green-500" /> Staff
                        </DropdownMenuItem>
                        <DropdownMenuItem className="gap-2 font-bold" onClick={() => handleUpdateRole(u.id, 'customer')}>
                          <User className="h-4 w-4 text-muted-foreground" /> Customer
                        </DropdownMenuItem>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem className="gap-2 font-bold text-destructive hover:bg-destructive/5">
                          <UserMinus className="h-4 w-4" /> Suspend User
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>

                  <div className="flex items-center justify-between pt-4 border-t border-dashed border-border/50">
                    <Badge className={`px-4 py-1 rounded-lg uppercase font-black text-[10px] ${
                      u.role === 'admin' ? 'bg-primary/20 text-primary border-none' :
                      u.role === 'staff' ? 'bg-green-500/20 text-green-600 border-none' :
                      'bg-secondary text-muted-foreground border-none'
                    }`}>
                      {u.role || 'Customer'}
                    </Badge>
                    <p className="text-[10px] text-muted-foreground font-medium uppercase tracking-widest">
                      ID: {u.id.substring(0, 8)}...
                    </p>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
