import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import '../models/order.dart' as model_order;
import '../models/product.dart';
import '../models/user.dart';

class OrderService extends ChangeNotifier {
  final List<model_order.Order> _orders = [];

  List<model_order.Order> get orders => List.unmodifiable(_orders);

  Future<void> addOrder(
    model_order.Order order, {
    required String userId,
  }) async {
    _orders.add(order);
    notifyListeners();
    // Persist to Firestore
    final ref = firestore.FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(order.id);
    await ref.set({
      'userId': order.user.email,
      'products': order.products
          .map(
            (p) => {
              'id': p.id,
              'name': p.name,
              'price': p.price,
              'imageUrl': p.imageUrl,
            },
          )
          .toList(),
      'totalAmount': order.totalAmount,
      'status': order.status.name,
      'createdAt': order.createdAt.toIso8601String(),
      'updatedAt': order.updatedAt?.toIso8601String(),
      'shippingAddress': order.shippingAddress,
      'paymentId': order.paymentId,
    });
  }

  Future<void> fetchOrders({required String userId}) async {
    final snapshot = await firestore.FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .get();
    _orders.clear();
    for (final doc in snapshot.docs) {
      final data = doc.data();
      _orders.add(
        model_order.Order(
          id: doc.id,
          user: AppUser(
            uid: data['userUid'] ?? '',
            name: data['userName'] ?? '',
            email: data['userEmail'] ?? '',
            phone: data['userPhone'] ?? '',
            address: data['userAddress'] ?? '',
            gender: data['userGender'] ?? '',
            dob: data['userDob'] ?? '',
          ),
          products: (data['products'] as List)
              .map(
                (p) => Product(
                  id: p['id'],
                  name: p['name'],
                  price: (p['price'] as num).toDouble(),
                  imageUrl: p['imageUrl'],
                  description: p['description'] ?? '',
                ),
              )
              .toList(),
          totalAmount: (data['totalAmount'] as num).toDouble(),
          status: model_order.OrderStatus.values.firstWhere(
            (e) => e.name == data['status'],
          ),
          createdAt: DateTime.parse(data['createdAt']),
          updatedAt: data['updatedAt'] != null
              ? DateTime.parse(data['updatedAt'])
              : null,
          shippingAddress: data['shippingAddress'],
          paymentId: data['paymentId'],
        ),
      );
    }
    notifyListeners();
  }
}
