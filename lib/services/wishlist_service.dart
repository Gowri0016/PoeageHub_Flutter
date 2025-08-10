import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistService extends ChangeNotifier {
  final List<Product> _wishlist = [];

  List<Product> get wishlist => List.unmodifiable(_wishlist);

  bool isInWishlist(Product product) {
    return _wishlist.any((p) => p.id == product.id);
  }

  void toggleWishlist(Product product, {String? userId}) async {
    if (isInWishlist(product)) {
      _wishlist.removeWhere((p) => p.id == product.id);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
    if (userId != null) {
      final ref = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('wishlist');
      if (isInWishlist(product)) {
        await ref.doc(product.id).set({
          'id': product.id,
          'name': product.name,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'description': product.description,
        });
      } else {
        await ref.doc(product.id).delete();
      }
    }
  }
}
