import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String type; // 'card', 'upi', 'wallet', etc.
  final String details; // Masked card/UPI/wallet info
  final String? brand; // e.g. 'Visa', 'Mastercard', 'Paytm'
  final bool isDefault;
  PaymentMethod({
    required this.id,
    required this.type,
    required this.details,
    this.brand,
    this.isDefault = false,
  });
}

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<PaymentMethod> methods = [
    PaymentMethod(
      id: '1',
      type: 'card',
      brand: 'Visa',
      details: '**** 1234',
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: 'card',
      brand: 'Mastercard',
      details: '**** 5678',
    ),
    PaymentMethod(
      id: '3',
      type: 'upi',
      brand: 'GPay',
      details: 'vignesh@okhdfcbank',
    ),
    PaymentMethod(
      id: '4',
      type: 'wallet',
      brand: 'Paytm',
      details: 'vignesh@paytm',
    ),
  ];

  void _setDefault(String id) {
    setState(() {
      methods = methods.map((m) => m.copyWith(isDefault: m.id == id)).toList();
    });
  }

  void _deleteMethod(String id) {
    setState(() {
      methods.removeWhere((m) => m.id == id);
    });
  }

  void _addMethod() {
    // Show a bottom sheet or dialog to add a new method (mock)
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.credit_card, color: Colors.blue),
              title: const Text('Credit/Debit Card'),
              onTap: () {
                Navigator.pop(context);
                // Add card logic here
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.account_balance_wallet,
                color: Colors.green,
              ),
              title: const Text('Wallet/UPI'),
              onTap: () {
                Navigator.pop(context);
                // Add wallet/UPI logic here
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(PaymentMethod m) {
    switch (m.type) {
      case 'card':
        if (m.brand == 'Visa')
          return Image.asset(
            'assets/icons/visa.png',
            width: 32,
            height: 32,
            errorBuilder: (_, __, ___) => const Icon(Icons.credit_card),
          );
        if (m.brand == 'Mastercard')
          return Image.asset(
            'assets/icons/mastercard.png',
            width: 32,
            height: 32,
            errorBuilder: (_, __, ___) => const Icon(Icons.credit_card),
          );
        return const Icon(Icons.credit_card, color: Colors.blue);
      case 'upi':
        return const Icon(Icons.account_balance_wallet, color: Colors.green);
      case 'wallet':
        return const Icon(Icons.account_balance_wallet, color: Colors.orange);
      default:
        return const Icon(Icons.payment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Methods')),
      body: methods.isEmpty
          ? const Center(child: Text('No payment methods added.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: methods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final m = methods[i];
                return Dismissible(
                  key: ValueKey(m.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    color: Colors.red[100],
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  onDismissed: (_) => _deleteMethod(m.id),
                  child: ListTile(
                    leading: _buildIcon(m),
                    title: Text(
                      m.details,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(m.brand ?? m.type.toUpperCase()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (m.isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Default',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        else
                          IconButton(
                            icon: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.grey,
                            ),
                            tooltip: 'Set as default',
                            onPressed: () => _setDefault(m.id),
                          ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          tooltip: 'Edit',
                          onPressed: () {
                            // Edit logic here
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Payment Method'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: _addMethod,
          ),
        ),
      ),
    );
  }
}

extension on PaymentMethod {
  PaymentMethod copyWith({
    String? id,
    String? type,
    String? details,
    String? brand,
    bool? isDefault,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      type: type ?? this.type,
      details: details ?? this.details,
      brand: brand ?? this.brand,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
