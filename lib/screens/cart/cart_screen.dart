// Cart screen UI
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/cart_service.dart';
import '../../widgets/buttons.dart';
import '../../widgets/empty_state_widgets.dart';
import '../../widgets/loading_indicators.dart';
import '../../widgets/app_bars.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainAppBar(actions: const []),
            Expanded(
              child: Consumer<CartService>(
                builder: (context, cart, _) {
                  if (cart.isLoading) {
                    return const PrimaryLoadingIndicator();
                  }
                  // Simulate error state for demonstration (replace with real error logic if needed)
                  // final hasError = false;
                  // if (hasError) {
                  //   return ErrorStateWidget(
                  //     message: 'Failed to load cart items',
                  //     onRetry: () {
                  //       // Add retry logic here
                  //     },
                  //   );
                  // }
                  if (cart.items.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.remove_shopping_cart,
                      message: 'Your cart is empty!',
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cart.items.length,
                          itemBuilder: (context, i) {
                            final item = cart.items[i];
                            return ListTile(
                              leading: Image.network(
                                item.product.imageUrl,
                                width: 48,
                                height: 48,
                              ),
                              title: Text(item.product.name),
                              subtitle: Text(
                                '₹${item.product.price.toStringAsFixed(0)}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () =>
                                        cart.decreaseQuantity(item.product),
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        cart.increaseQuantity(item.product),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        cart.removeItem(item.product),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              '₹${cart.totalAmount.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: PrimaryButton(
                          text: 'Proceed to Checkout',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Remove bottomNavigationBar from here
    );
  }
}

// If you add any async loading in CartScreen, use PrimaryLoadingIndicator for loading states.
