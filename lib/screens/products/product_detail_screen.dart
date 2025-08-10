import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/product_service.dart';
import '../../services/cart_service.dart';
import '../../widgets/buttons.dart';
import '../../services/wishlist_service.dart';

// Product detail screen UI
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductService>(
      context,
      listen: false,
    ).getProductById(productId);
    final cartService = Provider.of<CartService>(context, listen: false);
    final wishlistService = Provider.of<WishlistService>(context);
    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product Detail')),
        body: const Center(child: Text('Product not found.')),
      );
    }
    final isWishlisted = wishlistService.isInWishlist(product);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              wishlistService.toggleWishlist(product);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.imageUrl,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            '₹${product.price.toStringAsFixed(0)}',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.deepPurple),
          ),
          const SizedBox(height: 16),
          Text(product.description),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'Add to Cart',
            onPressed: () {
              cartService.addItem(product, 1);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
            },
          ),
        ],
      ),
    );
  }
}

// If you add any async loading in ProductDetailScreen, use PrimaryLoadingIndicator for loading states.
