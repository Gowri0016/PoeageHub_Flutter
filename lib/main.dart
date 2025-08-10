import 'package:flutter/material.dart';
import 'package:primepick/services/address_service.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/product_service.dart';
import 'services/cart_service.dart';
import 'services/payment_service.dart';
import 'services/category_service.dart';
import 'services/wishlist_service.dart';
import 'services/order_service.dart';
import 'screens/auth/login_screen.dart';
import 'configs/route_names.dart';
import 'screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/products/product_list_screen.dart';
import 'screens/wishlist/wishlist_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/categories/category_list_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/my_orders_screen.dart';
import 'screens/main_tab_screen.dart';
import 'configs/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        Provider<ProductService>(create: (_) => ProductService()),
        ChangeNotifierProvider<CartService>(create: (_) => CartService()),
        ChangeNotifierProvider<PaymentService>(create: (_) => PaymentService()),
        Provider<CategoryService>(create: (_) => CategoryService()),
        ChangeNotifierProvider<WishlistService>(
          create: (_) => WishlistService(),
        ),
        ChangeNotifierProvider<OrderService>(create: (_) => OrderService()),
        ChangeNotifierProvider<AddressService>(create: (_) => AddressService()),
      ],
      child: MaterialApp(
        title: 'PrimePick',
        theme: lightTheme,
        initialRoute: RouteNames.home,
        routes: {
          RouteNames.login: (context) => const LoginScreen(),
          RouteNames.signup: (context) => const SignupScreen(),
          RouteNames.home: (context) => const MainTabScreen(),
          RouteNames.products: (context) => const ProductListScreen(),
          RouteNames.wishlist: (context) => const WishlistScreen(),
          RouteNames.cart: (context) => const CartScreen(),
          RouteNames.categories: (context) => const CategoryListScreen(),
          RouteNames.profile: (context) => const ProfileScreen(),
          RouteNames.myOrders: (context) => const MyOrdersScreen(),
        },
        home: const MainTabScreen(),
      ),
    );
  }
}
