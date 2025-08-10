import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/wishlist_service.dart';
import '../../widgets/product_cards.dart';
import '../../widgets/app_bars.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistService = Provider.of<WishlistService>(context);
    final wishlist = wishlistService.wishlist;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainAppBar(actions: const []),
            Expanded(
              child: wishlist.isEmpty
                  ? const Center(child: Text('Your wishlist is empty.'))
                  : GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(16),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                      children: wishlist
                          .map(
                            (product) => ProductCard(
                              imageUrl: product.imageUrl,
                              name: product.name,
                              price: '₹${product.price.toStringAsFixed(0)}',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product-detail',
                                  arguments: product.id,
                                );
                              },
                              showWishlist: true,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
