import { useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { useAddresses } from '@/hooks/useAddresses';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Badge } from '@/components/ui/badge';
import { MapPin, Plus, Trash2, Home, Briefcase, User, Phone, Mail, CheckCircle2, Loader2, Landmark, MapPinned, Lock, ShieldAlert, AlertCircle } from 'lucide-react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogFooter,
  DialogDescription,
} from "@/components/ui/dialog";
import { toast } from 'sonner';

export default function ProfilePage() {
  const { profile, isAdmin, isStaff, updatePassword, deleteAccount } = useAuth();
  const { addresses, loading, addAddress, deleteAddress, setDefaultAddress } = useAddresses();
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  
  // Security States
  const [isPasswordDialogOpen, setIsPasswordDialogOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [securityLoading, setSecurityLoading] = useState(false);

  const [formData, setFormData] = useState({
    full_name: '',
    phone_number: '',
    house_no: '',
    street: '',
    city: '',
    pincode: '',
    landmark: '',
    is_default: false,
  });

  const handlePasswordChange = async (e: React.FormEvent) => {
    e.preventDefault();
    if (newPassword !== confirmPassword) {
      return toast.error("Passwords don't match");
    }
    if (newPassword.length < 6) {
      return toast.error("Password must be at least 6 characters");
    }

    setSecurityLoading(true);
    const { error } = await updatePassword(newPassword);
    setSecurityLoading(false);

    if (error) {
      toast.error(error);
    } else {
      toast.success("Password updated successfully");
      setIsPasswordDialogOpen(false);
      setNewPassword('');
      setConfirmPassword('');
    }
  };

  const handleDeleteAccount = async () => {
    setSecurityLoading(true);
    const { error } = await deleteAccount();
    setSecurityLoading(false);
    
    if (error) {
      toast.error(error);
    } else {
      toast.success("Account deleted successfully");
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const result = await addAddress(formData);
    if (result) {
      setIsDialogOpen(false);
      setFormData({
        full_name: '',
        phone_number: '',
        house_no: '',
        street: '',
        city: '',
        pincode: '',
        landmark: '',
        is_default: false,
      });
    }
  };

  return (
    <div className="max-w-5xl mx-auto space-y-12 pb-20">
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
        <div>
          <h1 className="text-4xl font-black tracking-tight flex items-center gap-3">
            <User className="h-10 w-10 text-primary" /> My Profile
          </h1>
          <p className="text-muted-foreground mt-2 font-medium italic">Manage your account and delivery details</p>
        </div>
        <div className="flex gap-4">
          {isAdmin && <Badge className="bg-primary/20 text-primary border-none px-4 py-1.5 rounded-full font-black uppercase">Admin Access</Badge>}
          {isStaff && <Badge className="bg-green-500/20 text-green-600 border-none px-4 py-1.5 rounded-full font-black uppercase">Staff Member</Badge>}
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-[1fr_2fr] gap-10">
        {/* Left Col: Account Info */}
        <div className="space-y-6">
          <Card className="glass-card overflow-hidden rounded-[2rem] border-border/50 shadow-xl">
            <div className="h-24 bg-gradient-to-br from-primary to-green-600" />
            <div className="px-6 pb-8">
              <div className="relative -mt-10 mb-4 h-20 w-20 rounded-[1.5rem] bg-background border-4 border-background flex items-center justify-center text-3xl font-black text-primary shadow-2xl">
                {profile?.name?.charAt(0).toUpperCase()}
              </div>
              <div className="space-y-4">
                <div>
                  <h3 className="text-2xl font-black">{profile?.name || 'User'}</h3>
                  <p className="text-sm text-muted-foreground flex items-center gap-2 mt-1">
                    <Mail className="h-3 w-3" /> {profile?.email}
                  </p>
                </div>
                <div className="flex items-center gap-2">
                  <Badge variant="secondary" className={`rounded-lg px-2 h-6 font-bold uppercase text-[10px] ${isAdmin ? 'bg-purple-500/10 text-purple-600' : isStaff ? 'bg-blue-500/10 text-blue-600' : 'bg-green-500/10 text-green-600'}`}>
                    {isAdmin ? 'Admin' : isStaff ? 'Staff' : 'Customer'}
                  </Badge>
                  <p className="text-[10px] text-muted-foreground font-medium uppercase tracking-widest">
                    Member since {profile?.created_at ? new Date(profile.created_at).getFullYear() : '2024'}
                  </p>
                </div>
              </div>
            </div>
          </Card>

          <Card className="glass-card rounded-[1.5rem] border-border/50">
            <CardHeader>
              <CardTitle className="text-lg font-black">Security</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <Dialog open={isPasswordDialogOpen} onOpenChange={setIsPasswordDialogOpen}>
                <DialogTrigger asChild>
                  <Button variant="outline" className="w-full rounded-xl justify-start font-bold gap-2">
                    <Lock className="h-4 w-4" /> Change Password
                  </Button>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle className="text-xl font-black">Change Password</DialogTitle>
                    <DialogDescription>Enter your new password below.</DialogDescription>
                  </DialogHeader>
                  <form onSubmit={handlePasswordChange} className="space-y-4 pt-4">
                    <div className="space-y-2">
                      <Label className="font-bold">New Password</Label>
                      <Input 
                        type="password" 
                        value={newPassword} 
                        onChange={e => setNewPassword(e.target.value)}
                        placeholder="••••••••"
                        required
                      />
                    </div>
                    <div className="space-y-2">
                      <Label className="font-bold">Confirm New Password</Label>
                      <Input 
                        type="password" 
                        value={confirmPassword} 
                        onChange={e => setConfirmPassword(e.target.value)}
                        placeholder="••••••••"
                        required
                      />
                    </div>
                    <DialogFooter className="pt-4">
                      <Button type="submit" className="w-full font-black" disabled={securityLoading}>
                        {securityLoading ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
                        Update Password
                      </Button>
                    </DialogFooter>
                  </form>
                </DialogContent>
              </Dialog>

              <Dialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen}>
                <DialogTrigger asChild>
                  <Button variant="outline" className="w-full rounded-xl justify-start font-bold text-destructive hover:bg-destructive/5 hover:text-destructive gap-2">
                    <ShieldAlert className="h-4 w-4" /> Delete Account
                  </Button>
                </DialogTrigger>
                <DialogContent className="border-destructive/30">
                  <DialogHeader>
                    <div className="mx-auto w-12 h-12 rounded-full bg-destructive/10 flex items-center justify-center mb-4">
                      <AlertCircle className="h-6 w-6 text-destructive" />
                    </div>
                    <DialogTitle className="text-xl font-black text-center">Are you absolutely sure?</DialogTitle>
                    <DialogDescription className="text-center">
                      This action will permanently delete your account and remove all your data from our servers. This cannot be undone.
                    </DialogDescription>
                  </DialogHeader>
                  <DialogFooter className="flex-col sm:flex-row gap-2 pt-6">
                    <Button variant="outline" className="flex-1" onClick={() => setIsDeleteOpen(false)}>Cancel</Button>
                    <Button 
                      variant="destructive" 
                      className="flex-1 font-black" 
                      onClick={handleDeleteAccount}
                      disabled={securityLoading}
                    >
                      {securityLoading ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
                      Yes, Delete My Account
                    </Button>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </CardContent>
          </Card>
        </div>

        {/* Right Col: Addresses */}
        <div className="space-y-8">
          <div className="flex items-center justify-between">
            <h2 className="text-2xl font-black tracking-tight flex items-center gap-3">
              <MapPin className="h-6 w-6 text-primary" /> Delivery Addresses
            </h2>
            <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
              <DialogTrigger asChild>
                <Button className="rounded-full px-6 font-black gap-2 shadow-lg shadow-primary/20">
                  <Plus className="h-4 w-4" /> Add New
                </Button>
              </DialogTrigger>
              <DialogContent className="max-w-xl rounded-[2rem]">
                <DialogHeader>
                  <DialogTitle className="text-2xl font-black">Add New Address</DialogTitle>
                </DialogHeader>
                <form onSubmit={handleSubmit} className="space-y-6 pt-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="full_name" className="font-bold">Receiver Name</Label>
                      <Input 
                        id="full_name" 
                        placeholder="John Doe" 
                        className="rounded-xl border-border/50" 
                        value={formData.full_name} 
                        onChange={e => setFormData({...formData, full_name: e.target.value})}
                        required 
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="phone" className="font-bold">Phone Number</Label>
                      <Input 
                        id="phone" 
                        placeholder="10-digit number" 
                        className="rounded-xl border-border/50" 
                        value={formData.phone_number} 
                        onChange={e => setFormData({...formData, phone_number: e.target.value})}
                        required 
                      />
                    </div>
                  </div>
                  <div className="grid grid-cols-[1fr_2fr] gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="house_no" className="font-bold">House / Flat No</Label>
                      <Input 
                        id="house_no" 
                        placeholder="A-101" 
                        className="rounded-xl border-border/50" 
                        value={formData.house_no} 
                        onChange={e => setFormData({...formData, house_no: e.target.value})}
                        required 
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="street" className="font-bold">Area / Street</Label>
                      <Input 
                        id="street" 
                        placeholder="Example Colony" 
                        className="rounded-xl border-border/50" 
                        value={formData.street} 
                        onChange={e => setFormData({...formData, street: e.target.value})}
                        required 
                      />
                    </div>
                  </div>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="city" className="font-bold">City</Label>
                      <Input 
                        id="city" 
                        placeholder="Bengaluru" 
                        className="rounded-xl border-border/50" 
                        value={formData.city} 
                        onChange={e => setFormData({...formData, city: e.target.value})}
                        required 
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="pincode" className="font-bold">Pincode</Label>
                      <Input 
                        id="pincode" 
                        placeholder="560001" 
                        className="rounded-xl border-border/50" 
                        value={formData.pincode} 
                        onChange={e => setFormData({...formData, pincode: e.target.value})}
                        required 
                      />
                    </div>
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="landmark" className="font-bold">Landmark (Optional)</Label>
                    <Input 
                      id="landmark" 
                      placeholder="Near Metro Station" 
                      className="rounded-xl border-border/50" 
                      value={formData.landmark} 
                      onChange={e => setFormData({...formData, landmark: e.target.value})}
                    />
                  </div>
                  <div className="flex items-center gap-3 pt-2">
                    <input 
                      type="checkbox" 
                      id="is_default" 
                      className="w-5 h-5 rounded-lg border-primary accent-primary" 
                      checked={formData.is_default}
                      onChange={e => setFormData({...formData, is_default: e.target.checked})}
                    />
                    <Label htmlFor="is_default" className="font-bold">Make this my default address</Label>
                  </div>
                  <DialogFooter className="pt-4">
                    <Button type="submit" className="w-full h-12 rounded-xl font-black text-lg shadow-xl shadow-primary/20">Save Address</Button>
                  </DialogFooter>
                </form>
              </DialogContent>
            </Dialog>
          </div>

          {loading ? (
             <div className="flex items-center justify-center py-20">
                <Loader2 className="h-8 w-8 text-primary animate-spin" />
             </div>
          ) : addresses.length === 0 ? (
            <div className="text-center py-20 bg-muted/20 border-2 border-dashed border-border/50 rounded-[2rem] space-y-4">
              <MapPinned className="h-12 w-12 text-muted-foreground/30 mx-auto" />
              <p className="font-bold text-muted-foreground">You haven't saved any addresses yet.</p>
              <Button variant="link" className="font-black text-primary" onClick={() => setIsDialogOpen(true)}>Add your first address</Button>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {addresses.map((addr) => (
                <Card key={addr.id} className={`glass-card rounded-[2rem] transition-all duration-300 border-2 ${addr.is_default ? 'border-primary shadow-xl shadow-primary/5' : 'border-border/50 hover:border-primary/20'}`}>
                  <CardContent className="p-6 space-y-4">
                    <div className="flex items-start justify-between">
                      <div className="flex items-center gap-3">
                        <div className={`p-2.5 rounded-xl ${addr.is_default ? 'bg-primary text-primary-foreground' : 'bg-secondary text-muted-foreground'}`}>
                          {addr.house_no.toLowerCase().includes('office') ? <Briefcase className="h-5 w-5" /> : <Home className="h-5 w-5" />}
                        </div>
                        {addr.is_default && (
                           <Badge className="bg-success text-white border-none py-0.5 px-2 rounded-full font-black text-[9px] uppercase">Default</Badge>
                        )}
                      </div>
                      <div className="flex gap-1">
                        {!addr.is_default && (
                           <Button variant="ghost" size="icon" className="h-8 w-8 rounded-lg hover:text-primary" onClick={() => setDefaultAddress(addr.id)}>
                             <CheckCircle2 className="h-4 w-4" />
                           </Button>
                        )}
                        <Button variant="ghost" size="icon" className="h-8 w-8 rounded-lg hover:text-destructive hover:bg-destructive/5" onClick={() => deleteAddress(addr.id)}>
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                    <div className="space-y-1">
                      <p className="font-black text-lg flex items-center gap-2">
                         {addr.full_name}
                      </p>
                      <p className="text-sm font-bold text-muted-foreground">{addr.phone_number}</p>
                    </div>
                    <div className="text-sm text-foreground/80 leading-relaxed font-medium">
                      {addr.house_no}, {addr.street}<br />
                      {addr.landmark && <span className="text-muted-foreground mr-1 italic">Landmark: {addr.landmark}</span>}
                      {addr.city} - <span className="font-bold">{addr.pincode}</span>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
