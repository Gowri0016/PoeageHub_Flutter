import 'package:flutter/material.dart';
// If you have font_awesome_flutter, uncomment the next line:
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../services/product_service.dart';
import '../../models/product.dart';
import '../../configs/route_names.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/product_cards.dart';
import '../../configs/app_theme.dart';
import '../../widgets/loading_indicators.dart';
import '../../widgets/error_state_widget.dart';
import '../../widgets/empty_state_widgets.dart' hide ErrorStateWidget;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _productsFuture;
  late Future<List<Product>> _featuredFuture;

  @override
  void initState() {
    super.initState();
    final productService = Provider.of<ProductService>(context, listen: false);
    _productsFuture = productService.getAllProducts();
    _featuredFuture = productService.getFeaturedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainAppBar(actions: const []),
            // Modern Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for products, brands, and more',
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                  ),
                ),
              ),
            ),
            const GlobalPromoBar(
              message:
                  'Summer Sales For All Swim Suits And Free Express Delivery - OFF 50%!',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Product Carousel
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<List<Product>>(
                        future: _featuredFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const PrimaryLoadingIndicator();
                          } else if (snapshot.hasError) {
                            return ErrorStateWidget(
                              message: 'Failed to load featured products',
                              onRetry: () {
                                setState(() {
                                  final productService =
                                      Provider.of<ProductService>(
                                        context,
                                        listen: false,
                                      );
                                  _featuredFuture = productService
                                      .getFeaturedProducts();
                                });
                              },
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const EmptyStateWidget(
                              icon: Icons.star_border,
                              message: 'No featured products',
                            );
                          }
                          return ProductCarousel(
                            banners: snapshot.data!
                                .map(
                                  (product) => GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.productDetail,
                                        arguments: product.id,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          kBorderRadius,
                                        ),
                                        image:
                                            product.imageUrl.contains(
                                              'placeholder.com',
                                            )
                                            ? null
                                            : DecorationImage(
                                                image: NetworkImage(
                                                  product.imageUrl,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                        color: kSubtleGray,
                                      ),
                                      alignment: Alignment.bottomLeft,
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        product.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Category List
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 4),
                        _CategoryChip(label: "Women's Fashion", selected: true),
                        _CategoryChip(label: "Men's Fashion"),
                        _CategoryChip(label: "TechSmart Gadgets"),
                        _CategoryChip(label: "EcoBlend Essentials"),
                        _CategoryChip(label: "Lifestyle Enhancers"),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Product Grid
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    margin: const EdgeInsets.only(top: 8, bottom: 32),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder<List<Product>>(
                        future: _productsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const PrimaryLoadingIndicator();
                          } else if (snapshot.hasError) {
                            return ErrorStateWidget(
                              message: 'Failed to load products',
                              onRetry: () {
                                setState(() {
                                  final productService =
                                      Provider.of<ProductService>(
                                        context,
                                        listen: false,
                                      );
                                  _productsFuture = productService
                                      .getAllProducts();
                                });
                              },
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const EmptyStateWidget(
                              icon: Icons.inventory_2_outlined,
                              message: 'No products found',
                            );
                          }
                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.7,
                            children: snapshot.data!
                                .map(
                                  (product) => ProductCard(
                                    imageUrl:
                                        product.imageUrl.contains(
                                          'placeholder.com',
                                        )
                                        ? ''
                                        : product.imageUrl,
                                    name: product.name,
                                    price:
                                        '₹${product.price.toStringAsFixed(0)}',
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.productDetail,
                                        arguments: product.id,
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Footer
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    margin: const EdgeInsets.only(bottom: 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _CategoryChip({required this.label, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: kPrimarySwatch,
        labelStyle: TextStyle(
          color: selected ? Colors.white : kPrimarySwatch,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: kSubtleGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        onSelected: (_) {},
      ),
    );
  }
}
