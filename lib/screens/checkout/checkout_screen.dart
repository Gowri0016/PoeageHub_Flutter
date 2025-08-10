import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/cart_service.dart';
import '../../services/payment_service.dart';
import '../../services/address_service.dart';
import '../../widgets/buttons.dart';
import '../../widgets/loading_indicators.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isProcessing = false;
  String? _error;
  Address? _selectedAddress;

  Future<void> _processPayment() async {
    setState(() {
      _isProcessing = true;
      _error = null;
    });
    final cart = Provider.of<CartService>(context, listen: false);
    final paymentService = Provider.of<PaymentService>(context, listen: false);
    try {
      await paymentService.processPayment(cart.totalAmount);
      cart.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Payment successful!')));
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final addressService = Provider.of<AddressService>(context, listen: false);
    _selectedAddress = addressService.defaultAddress;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartService>(context);
    final addressService = Provider.of<AddressService>(context);
    if (_isProcessing) {
      return const PrimaryLoadingIndicator();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total: ₹${cart.totalAmount.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            DropdownButton<Address>(
              hint: const Text('Select Delivery Address'),
              value: _selectedAddress,
              items: addressService.addresses
                  .map(
                    (a) => DropdownMenuItem(
                      value: a,
                      child: Text('${a.addressLine1}, ${a.city}'),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedAddress = val;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_error != null) ...[
              Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
            ],
            PrimaryButton(
              text: _isProcessing ? 'Processing...' : 'Pay Now',
              onPressed: _isProcessing ? null : _processPayment,
            ),
          ],
        ),
      ),
    );
  }
}
