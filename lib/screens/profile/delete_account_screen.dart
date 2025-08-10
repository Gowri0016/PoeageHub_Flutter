import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/account_deletion_service.dart';

class DeleteAccountScreen extends StatefulWidget {
  final User user;
  final String name;
  const DeleteAccountScreen({Key? key, required this.user, required this.name})
    : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  bool canDelete = false;
  bool hasReason = false;
  bool isLoading = false;

  void _tryDelete() async {
    setState(() => isLoading = true);
    await AccountDeletionService.deleteAccount(
      user: widget.user,
      name: widget.name,
      reason: reasonController.text.trim(),
      onSuccess: () {
        setState(() => isLoading = false);
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Account deleted.')));
      },
      onError: (msg) async {
        setState(() => isLoading = false);
        if (msg.contains('requires-recent-login')) {
          await _showReauthDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete account: $msg')),
          );
        }
      },
    );
  }

  Future<void> _showReauthDialog() async {
    String? password;
    bool isGoogle = widget.user.providerData.any(
      (p) => p.providerId == 'google.com',
    );
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
                        final googleUser = await GoogleSignIn().signIn();
                        if (googleUser == null)
                          throw Exception('Google sign-in cancelled');
                        final googleAuth = await googleUser.authentication;
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth.accessToken,
                          idToken: googleAuth.idToken,
                        );
                        await widget.user.reauthenticateWithCredential(
                          credential,
                        );
                      } else {
                        if (password == null || password!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter your password.'),
                            ),
                          );
                          return;
                        }
                        final cred = EmailAuthProvider.credential(
                          email: widget.user.email!,
                          password: password!,
                        );
                        await widget.user.reauthenticateWithCredential(cred);
                      }
                      Navigator.of(context).pop();
                      _tryDelete();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Account')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Type "delete" to confirm account deletion.'),
            const SizedBox(height: 10),
            TextField(
              controller: confirmController,
              decoration: const InputDecoration(labelText: 'Type "delete"'),
              onChanged: (val) => setState(() {
                canDelete = val.trim().toLowerCase() == 'delete';
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for leaving (required)',
              ),
              minLines: 1,
              maxLines: 3,
              onChanged: (val) => setState(() {
                hasReason = val.trim().isNotEmpty;
              }),
            ),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: (canDelete && hasReason && !isLoading)
                        ? _tryDelete
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Delete Account'),
                  ),
          ],
        ),
      ),
    );
  }
}
