import 'package:flutter/material.dart';

// Integrates with payment gateways (Razorpay, Paytm)

class PaymentService extends ChangeNotifier {
  Future<void> processPayment(double amount) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate payment success
    // throw Exception('Payment failed'); // Uncomment to simulate failure
  }
}
