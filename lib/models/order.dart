import 'product.dart';
import 'user.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

// Data structure for an order
class Order {
  final String id;
  final AppUser user;
  final List<Product> products;
  final double totalAmount;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? shippingAddress;
  final String? paymentId;

  Order({
    required this.id,
    required this.user,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.shippingAddress,
    this.paymentId,
  });

  Order copyWith({
    String? id,
    AppUser? user,
    List<Product>? products,
    double? totalAmount,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? shippingAddress,
    String? paymentId,
  }) {
    return Order(
      id: id ?? this.id,
      user: user ?? this.user,
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  // Add serialization/deserialization if needed
}
