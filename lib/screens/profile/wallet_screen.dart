import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double balance = 1250.00;
  List<Map<String, dynamic>> transactions = [
    {
      'type': 'credit',
      'amount': 100.0,
      'desc': 'Referral Bonus',
      'date': '26 Jun 2025, 10:30 AM',
    },
    {
      'type': 'debit',
      'amount': 250.0,
      'desc': 'Order #1234',
      'date': '25 Jun 2025, 4:15 PM',
    },
    {
      'type': 'credit',
      'amount': 500.0,
      'desc': 'Wallet Top-up',
      'date': '24 Jun 2025, 2:00 PM',
    },
    {
      'type': 'debit',
      'amount': 100.0,
      'desc': 'Order #1220',
      'date': '22 Jun 2025, 11:45 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wallet Balance',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.blue[700],
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Money'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                        ),
                        onPressed: () {
                          // Add money logic
                        },
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.history),
                        label: const Text('History'),
                        onPressed: () {
                          // Scroll to history
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Recent Transactions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: transactions.isEmpty
                  ? const Center(child: Text('No transactions yet.'))
                  : ListView.separated(
                      itemCount: transactions.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, i) {
                        final t = transactions[i];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: t['type'] == 'credit'
                                ? Colors.green[50]
                                : Colors.red[50],
                            child: Icon(
                              t['type'] == 'credit'
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: t['type'] == 'credit'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          title: Text(
                            t['desc'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(t['date']),
                          trailing: Text(
                            (t['type'] == 'credit' ? '+' : '-') +
                                '₹${t['amount'].toStringAsFixed(2)}',
                            style: TextStyle(
                              color: t['type'] == 'credit'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
