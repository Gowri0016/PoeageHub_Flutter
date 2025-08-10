import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../configs/route_names.dart';
import '../../widgets/app_bars.dart';
import 'payment_methods_screen.dart';
import 'coupons_rewards_screen.dart';
import 'notifications_screen.dart';
import 'language_screen.dart';
import 'privacy_security_screen.dart';
import 'refer_earn_screen.dart';
import 'about_us_screen.dart';
import 'faqs_screen.dart';
import 'rate_us_screen.dart';
import 'report_problem_screen.dart';
import 'support_screen.dart';
import 'address_management_screen.dart';
import 'wallet_screen.dart';
import 'myaccount.dart';

// Profile screen UI
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;
    final isLoggedIn = auth.isLoggedIn;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainAppBar(actions: const []),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isLoggedIn || user == null) ...[
                      // Login prompt for guests (moved to top)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8),
                            const Icon(
                              Icons.lock_outline,
                              size: 60,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Login to see more options',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('LOGIN'),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                    if (isLoggedIn && user != null) ...[
                      // User Info Card
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 0,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColorLight,
                                  child: Icon(
                                    Icons.person,
                                    size: 48,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  (user.name.isNotEmpty)
                                      ? user.name
                                      : 'Your Name',
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  (user.email.isNotEmpty)
                                      ? user.email
                                      : 'your@email.com',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Quick Actions (only for logged in)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _QuickAction(
                            icon: Icons.receipt_long,
                            label: 'Orders',
                            onTap: () =>
                                Navigator.pushNamed(context, '/my-orders'),
                          ),
                          _QuickAction(
                            icon: Icons.wallet,
                            label: 'Wallet',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WalletScreen(),
                              ),
                            ),
                          ),
                          _QuickAction(
                            icon: Icons.location_on_outlined,
                            label: 'Addresses',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddressManagementScreen(),
                              ),
                            ),
                          ),
                          _QuickAction(
                            icon: Icons.credit_card,
                            label: 'Payment',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PaymentMethodsScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],

                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          if (isLoggedIn && user != null) ...[
                            _ProfileOption(
                              icon: Icons.manage_accounts,
                              label: 'Account & Settings',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MyAccountScreen(),
                                ),
                              ),
                            ),
                            _ProfileOption(
                              icon: Icons.card_giftcard,
                              label: 'Coupons & Rewards',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CouponsRewardsScreen(),
                                ),
                              ),
                            ),

                            _ProfileOption(
                              icon: Icons.share,
                              label: 'Refer & Earn',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ReferEarnScreen(),
                                ),
                              ),
                            ),
                          ],
                          // Always visible options for all users
                          _ProfileOption(
                            icon: Icons.support_agent,
                            label: 'Support',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SupportScreen(),
                              ),
                            ),
                          ),
                          _ProfileOption(
                            icon: Icons.notifications_none,
                            label: 'Notifications',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NotificationsScreen(),
                              ),
                            ),
                          ),
                          _ProfileOption(
                            icon: Icons.language,
                            label: 'Language',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LanguageScreen(),
                              ),
                            ),
                          ),
                          _ProfileOption(
                            icon: Icons.security,
                            label: 'Privacy & Security',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PrivacySecurityScreen(),
                              ),
                            ),
                          ),
                          _ProfileOption(
                            icon: Icons.info_outline,
                            label: 'About Us',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutUsScreen(),
                              ),
                            ),
                          ),
                          _ProfileOption(
                            icon: Icons.help_outline,
                            label: 'FAQs',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FaqsScreen(),
                              ),
                            ),
                          ),
                          _ProfileOption(
                            icon: Icons.star_rate,
                            label: 'Rate Us',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RateUsScreen(),
                              ),
                            ),
                          ),
                          _ProfileOption(
                            icon: Icons.bug_report,
                            label: 'Report a Problem',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ReportProblemScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (isLoggedIn && user != null) ...[
                      // Logout Button
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.error,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),
                          onPressed: () {
                            auth.signOut();
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.login,
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Removed invalid/duplicated code block from previous patch
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Theme.of(context).primaryColor, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ProfileOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
