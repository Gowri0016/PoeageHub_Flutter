import 'package:flutter/material.dart';

class Coupon {
  final String code;
  final String description;
  final DateTime expiry;
  final bool isRedeemed;
  Coupon({required this.code, required this.description, required this.expiry, this.isRedeemed = false});
}

class CouponsRewardsScreen extends StatefulWidget {
  const CouponsRewardsScreen({super.key});

  @override
  State<CouponsRewardsScreen> createState() => _CouponsRewardsScreenState();
}

class _CouponsRewardsScreenState extends State<CouponsRewardsScreen> {
  final List<Coupon> _coupons = [
    Coupon(code: 'WELCOME10', description: 'Get 10% off on your first order.', expiry: DateTime.now().add(const Duration(days: 30))),
    Coupon(code: 'FREESHIP', description: 'Free shipping on orders above ₹499.', expiry: DateTime.now().add(const Duration(days: 15))),
    Coupon(code: 'REWARD50', description: 'Earned 50 reward points.', expiry: DateTime.now().add(const Duration(days: 60)), isRedeemed: true),
  ];

  void _redeemCoupon(int index) {
    setState(() {
      _coupons[index] = Coupon(
        code: _coupons[index].code,
        description: _coupons[index].description,
        expiry: _coupons[index].expiry,
        isRedeemed: true,
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Coupon ${_coupons[index].code} redeemed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Coupons & Rewards')),
      body: _coupons.isEmpty
          ? Center(
              child: Text(
                'No coupons or rewards available.',
                style: theme.textTheme.titleMedium,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(18),
              itemCount: _coupons.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, i) {
                final c = _coupons[i];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              c.isRedeemed ? Icons.verified_rounded : Icons.card_giftcard_rounded,
                              color: c.isRedeemed ? Colors.green : theme.primaryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              c.code,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: c.isRedeemed ? Colors.green : theme.primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            if (!c.isRedeemed)
                              ElevatedButton(
                                onPressed: () => _redeemCoupon(i),
                                child: const Text('Redeem'),
                              )
                            else
                              const Chip(
                                label: Text('Redeemed'),
                                backgroundColor: Colors.greenAccent,
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          c.description,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Expires on: ${c.expiry.day}/${c.expiry.month}/${c.expiry.year}',
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
