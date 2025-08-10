import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // keep only one
import '../../services/account_deletion_service.dart';
import 'delete_account_screen.dart';
import 'profile_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  Future<void> _showDeleteAccountScreen() async {
    if (_user == null) return;
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            DeleteAccountScreen(user: _user!, name: _nameController.text),
      ),
    );
    if (result == true) {
      await FirebaseAuth.instance.signOut();
      // Also update AuthService provider state if used
      final authService = context.read<AuthService>();
      authService.signOut();
      setState(() {
        _user = null;
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _dobController.clear();
        _genderController.clear();
        _kyc = false;
        _profilePic = null;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted.')),
        );
        // Redirect to ProfileScreen in unlogged-in state
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
          (route) => false,
        );
      }
    }
  }

  Future<void> _deleteAccount(String reason) async {
    if (_user == null) return;
    final name = _nameController.text;
    await AccountDeletionService.deleteAccount(
      user: _user!,
      name: name,
      reason: reason,
      onSuccess: () {
        setState(() {
          _user = null;
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _dobController.clear();
          _genderController.clear();
          _kyc = false;
          _profilePic = null;
        });
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Account deleted.')));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MyAccountScreen()),
          );
        }
      },
      onError: (msg) async {
        if (msg.contains('requires-recent-login')) {
          await _showReauthDialog(reason);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete account: $msg')),
          );
        }
      },
    );
  }

  Future<void> _showReauthDialog(String reason) async {
    String? password;
    bool isGoogle =
        _user?.providerData.any((p) => p.providerId == 'google.com') ?? false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Re-authentication Required'),
              content: isGoogle
                  ? const Text(
                      'For security, please re-sign in with Google to delete your account.',
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'For security, please enter your password to delete your account.',
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          onChanged: (val) => password = val,
                        ),
                      ],
                    ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (isGoogle) {
                        // Google re-auth
                        final googleUser = await GoogleSignIn().signIn();
                        if (googleUser == null)
                          throw Exception('Google sign-in cancelled');
                        final googleAuth = await googleUser.authentication;
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth.accessToken,
                          idToken: googleAuth.idToken,
                        );
                        await _user!.reauthenticateWithCredential(credential);
                      } else {
                        // Email/password re-auth
                        if (password == null || password!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter your password.'),
                            ),
                          );
                          return;
                        }
                        final cred = EmailAuthProvider.credential(
                          email: _user!.email!,
                          password: password!,
                        );
                        await _user!.reauthenticateWithCredential(cred);
                      }
                      Navigator.of(context).pop();
                      // Retry deletion
                      await _deleteAccount(reason);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Re-authentication failed: $e')),
                      );
                    }
                  },
                  child: const Text('Re-authenticate'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If user is logged in and not loading, always fetch profile on dependency change (covers hot reload, re-login, etc)
    if (_user != null && !_loading) {
      _fetchProfile();
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  bool _kyc = false;
  String? _profilePic;
  bool _loading = true;
  bool _editing = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _fetchProfile();
    } else {
      setState(() => _loading = false);
    }
    // Listen for auth state changes to reload profile on login/logout
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
        _loading = true;
      });
      if (user != null) {
        _fetchProfile();
      } else {
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _dobController.clear();
        _genderController.clear();
        _kyc = false;
        _profilePic = null;
        setState(() => _loading = false);
      }
    });
  }

  Future<void> _fetchProfile() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      _nameController.text = data['name'] ?? '';
      _emailController.text = data['email'] ?? '';
      _phoneController.text = data['phone'] ?? '';
      _dobController.text = data['dob'] ?? '';
      final genderRaw = data['gender'] ?? '';
      // Normalize gender to match dropdown values
      if (genderRaw.toLowerCase() == 'male') {
        _genderController.text = 'Male';
      } else if (genderRaw.toLowerCase() == 'female') {
        _genderController.text = 'Female';
      } else if (genderRaw.toLowerCase() == 'other') {
        _genderController.text = 'Other';
      } else if (genderRaw.toLowerCase().contains('prefer')) {
        _genderController.text = 'Prefer not to say';
      } else {
        _genderController.text = '';
      }
      _kyc = data['kyc'] ?? false;
      _profilePic = data['profilePic'];
    } else {
      _nameController.text = _user?.displayName ?? '';
      _emailController.text = _user?.email ?? '';
    }
    setState(() => _loading = false);
  }

  Future<void> _saveProfile() async {
    if (_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to edit your profile.')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await FirebaseFirestore.instance.collection('users').doc(_user!.uid).set({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'dob': _dobController.text.trim(),
      'gender': _genderController.text.trim(),
      'kyc': _kyc,
      'profilePic': _profilePic,
    }, SetOptions(merge: true));
    if (!mounted) return;
    setState(() {
      _editing = false;
      _loading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Account')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [], // Removed edit pencil from app bar
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue[50],
                        backgroundImage: _profilePic != null
                            ? NetworkImage(_profilePic!)
                            : null,
                        child: _profilePic == null
                            ? const Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.blue,
                              )
                            : null,
                      ),
                      if (!_editing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Material(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            elevation: 2,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => setState(() => _editing = true),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    enabled: _editing,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: _editing ? Colors.blue[50] : Colors.grey[100],
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Enter your name' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Modern phone number input with country code dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: _editing ? Colors.blue[50] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: '+91',
                            items: const [
                              DropdownMenuItem(
                                value: '+91',
                                child: Text(
                                  '🇮🇳 +91',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: '+1',
                                child: Text(
                                  '🇺🇸 +1',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: '+44',
                                child: Text(
                                  '🇬🇧 +44',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: '+61',
                                child: Text(
                                  '🇦🇺 +61',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: '+1c',
                                child: Text(
                                  '🇨🇦 +1',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                            onChanged: _editing ? (v) {} : null,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: _editing
                                  ? Colors.blue
                                  : const Color.fromARGB(255, 0, 0, 0),
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            dropdownColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            enabled: _editing,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(
                                Icons.phone_outlined,
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _editing
                        ? () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _dobController.text.isNotEmpty
                                  ? DateTime.tryParse(_dobController.text) ??
                                        DateTime(2000, 1, 1)
                                  : DateTime(2000, 1, 1),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      surface: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                    dialogBackgroundColor: Colors.white,
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              _dobController.text = picked
                                  .toIso8601String()
                                  .split('T')[0];
                              setState(() {});
                            }
                          }
                        : null,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dobController,
                        enabled: _editing,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          prefixIcon: const Icon(Icons.cake_outlined),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: _editing ? Colors.blue : Colors.grey,
                          ),
                          filled: true,
                          fillColor: _editing
                              ? Colors.blue[50]
                              : Colors.grey[100],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      color: _editing ? Colors.blue[50] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _editing
                            ? Colors.blue.shade100
                            : Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _genderController.text.isNotEmpty
                          ? _genderController.text
                          : null,
                      items: const [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Row(
                            children: [
                              Icon(Icons.male, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Male'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Row(
                            children: [
                              Icon(Icons.female, color: Colors.pink),
                              SizedBox(width: 8),
                              Text('Female'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Row(
                            children: [
                              Icon(Icons.transgender, color: Colors.purple),
                              SizedBox(width: 8),
                              Text('Other'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Prefer not to say',
                          child: Row(
                            children: [
                              Icon(Icons.help_outline, color: Colors.grey),
                              SizedBox(width: 8),
                              Text('Prefer not to say'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: _editing
                          ? (val) {
                              if (val != null)
                                setState(() => _genderController.text = val);
                            }
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.wc_outlined),
                        filled: false,
                      ),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.white,
                      disabledHint: Text(
                        _genderController.text.isNotEmpty
                            ? _genderController.text
                            : 'Select',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (_editing)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Save Changes'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(44),
                      ),
                      onPressed: _saveProfile,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _AccountOption(
                    icon: Icons.lock_outline,
                    label: 'Change Password',
                    onTap: () {},
                  ),
                  _AccountOption(
                    icon: Icons.verified_user,
                    label: _kyc ? 'KYC Verified' : 'Verify KYC',
                    onTap: () {},
                    trailing: _kyc
                        ? const Icon(Icons.verified, color: Colors.green)
                        : const Icon(Icons.warning, color: Colors.orange),
                  ),

                  _AccountOption(
                    icon: Icons.delete_forever,
                    label: 'Delete Account',
                    onTap: _showDeleteAccountScreen,
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountOption extends StatelessWidget {
  final IconData icon;
  final String label;
  // Removed unused value parameter
  final VoidCallback onTap;
  final Widget? trailing;
  const _AccountOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing:
          trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
