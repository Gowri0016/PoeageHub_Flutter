import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool twoFactorEnabled = false;
  bool biometricEnabled = false;
  bool personalizedAds = true;
  bool dataSharing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Security')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Account Security',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: twoFactorEnabled,
            onChanged: (v) => setState(() => twoFactorEnabled = v),
            title: const Text('Two-Factor Authentication'),
            subtitle: const Text(
              'Add an extra layer of security to your account.',
            ),
            secondary: const Icon(Icons.security),
          ),
          SwitchListTile(
            value: biometricEnabled,
            onChanged: (v) => setState(() => biometricEnabled = v),
            title: const Text('Biometric Login'),
            subtitle: const Text(
              'Enable fingerprint or face unlock for quick login.',
            ),
            secondary: const Icon(Icons.fingerprint),
          ),
          const Divider(height: 32),
          const Text(
            'Privacy Preferences',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: personalizedAds,
            onChanged: (v) => setState(() => personalizedAds = v),
            title: const Text('Personalized Ads'),
            subtitle: const Text(
              'Allow personalized ads based on your activity.',
            ),
            secondary: const Icon(Icons.privacy_tip),
          ),
          SwitchListTile(
            value: dataSharing,
            onChanged: (v) => setState(() => dataSharing = v),
            title: const Text('Data Sharing'),
            subtitle: const Text(
              'Allow sharing of anonymized data for analytics.',
            ),
            secondary: const Icon(Icons.bar_chart),
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.blue),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Implement change password logic
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Delete Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text(
                    'Are you sure you want to delete your account? This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // Implement delete logic
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
