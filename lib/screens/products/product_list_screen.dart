import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/product_service.dart';
import '../../services/category_service.dart';
import '../../services/wishlist_service.dart';
import '../../models/product.dart';
import '../../models/category.dart';
import '../../widgets/product_cards.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/loading_indicators.dart';
import '../../widgets/error_state_widget.dart';
import '../../widgets/empty_state_widgets.dart' hide ErrorStateWidget;
import '../../widgets/bottom_nav_bar.dart';
import '../../configs/route_names.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _productsFuture;
  final String _search = '';
  String? _selectedCategoryId;
  String? _selectedBrand;
  double? _minPrice;
  double? _maxPrice;
  bool? _inStock;
  String? _sortBy;
  List<Category> _categories = [];
  List<String> _brands = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final productService = Provider.of<ProductService>(context, listen: false);
    _productsFuture = productService.getAllProducts();
    _loadCategoriesAndBrands();
  }

  void _loadCategoriesAndBrands() async {
    final categoryService = Provider.of<CategoryService>(
      context,
      listen: false,
    );
    final categories = await categoryService.getAllCategories();
    setState(() {
      _categories = categories;
      _brands = Provider.of<ProductService>(context, listen: false).getBrands();
    });
  }

  void _applyFilters() {
    final productService = Provider.of<ProductService>(context, listen: false);
    setState(() {
      _productsFuture = productService.searchProducts(
        query: _search,
        categoryId: _selectedCategoryId,
        brand: _selectedBrand,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        inStock: _inStock,
        sortBy: _sortBy,
      );
    });
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          DropdownButton<String>(
            hint: const Text('Category'),
            value: _selectedCategoryId,
            items: _categories
                .map(
                  (cat) =>
                      DropdownMenuItem(value: cat.id, child: Text(cat.name)),
                )
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedCategoryId = val;
              });
              _applyFilters();
            },
          ),
          DropdownButton<String>(
            hint: const Text('Brand'),
            value: _selectedBrand,
            items: _brands
                .map(
                  (brand) => DropdownMenuItem(value: brand, child: Text(brand)),
                )
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedBrand = val;
              });
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }

  void _onNavBarTap(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, RouteNames.categories);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, RouteNames.wishlist);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, RouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainAppBar(actions: const []),
            const GlobalPromoBar(
              message:
                  'Summer Sales For All Swim Suits And Free Express Delivery - OFF 50%!',
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PrimaryLoadingIndicator();
                  } else if (snapshot.hasError) {
                    return ErrorStateWidget(
                      message: 'Failed to load products',
                      onRetry: () {
                        setState(() {
                          final productService = Provider.of<ProductService>(
                            context,
                            listen: false,
                          );
                          _productsFuture = productService.getAllProducts();
                        });
                      },
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.inventory_2_outlined,
                      message: 'No products found',
                    );
                  }
                  final products = _search.isEmpty
                      ? snapshot.data!
                      : snapshot.data!
                            .where(
                              (p) => p.name.toLowerCase().contains(
                                _search.toLowerCase(),
                              ),
                            )
                            .toList();
                  if (products.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.search_off,
                      message: 'No products match your search.',
                    );
                  }
                  final wishlistService = Provider.of<WishlistService>(context);
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                    children: products
                        .map(
                          (product) => ProductCard(
                            imageUrl: product.imageUrl,
                            name: product.name,
                            price: '₹${product.price.toStringAsFixed(0)}',
                            isFavorite: wishlistService.isInWishlist(product),
                            onFavorite: () {
                              wishlistService.toggleWishlist(product);
                            },
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _buildFilterBar(),
          );
        },
        tooltip: 'Filter',
        child: const Icon(Icons.filter_list),
      ),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
