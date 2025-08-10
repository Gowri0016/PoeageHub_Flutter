import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Address {
  final String id;
  final String name;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.isDefault = false,
  });

  factory Address.fromMap(String id, Map<String, dynamic> data) {
    return Address(
      id: id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      addressLine1: data['addressLine1'] ?? '',
      addressLine2: data['addressLine2'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      zipCode: data['zipCode'] ?? '',
      country: data['country'] ?? 'India',
      isDefault: data['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'isDefault': isDefault,
    };
  }
}

class AddressService extends ChangeNotifier {
  final List<Address> _addresses = [];

  List<Address> get addresses => List.unmodifiable(_addresses);

  Address? get defaultAddress =>
      _addresses.firstWhereOrNull((a) => a.isDefault) ??
      (_addresses.isNotEmpty ? _addresses.first : null);

  Future<void> addAddress(Address address, {required String userId}) async {
    // If new address is default, unset all others
    if (address.isDefault) {
      for (var i = 0; i < _addresses.length; i++) {
        final a = _addresses[i];
        _addresses[i] = Address(
          id: a.id,
          name: a.name,
          phone: a.phone,
          addressLine1: a.addressLine1,
          addressLine2: a.addressLine2,
          city: a.city,
          state: a.state,
          zipCode: a.zipCode,
          country: a.country,
          isDefault: false,
        );
      }
    }
    _addresses.add(address);
    notifyListeners();
    await saveAddress(userId, address);
  }

  Future<void> updateAddress(Address address, {required String userId}) async {
    final idx = _addresses.indexWhere((a) => a.id == address.id);
    if (idx != -1) {
      // If updating to default, unset all others
      if (address.isDefault) {
        for (var i = 0; i < _addresses.length; i++) {
          final a = _addresses[i];
          _addresses[i] = Address(
            id: a.id,
            name: a.name,
            phone: a.phone,
            addressLine1: a.addressLine1,
            addressLine2: a.addressLine2,
            city: a.city,
            state: a.state,
            zipCode: a.zipCode,
            country: a.country,
            isDefault: false,
          );
        }
      }
      _addresses[idx] = address;
      notifyListeners();
      await saveAddress(userId, address);
    }
  }

  Future<void> removeAddress(String id, {required String userId}) async {
    _addresses.removeWhere((a) => a.id == id);
    notifyListeners();
    await deleteAddress(userId, id);
  }

  Future<void> selectDefault(String id, {required String userId}) async {
    // 1. Get all addresses from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .get();
    // 2. Batch update: set all isDefault to false, except the selected one
    final batch = FirebaseFirestore.instance.batch();
    for (final doc in snapshot.docs) {
      final isSelected = doc.id == id;
      batch.update(doc.reference, {'isDefault': isSelected});
    }
    await batch.commit();
    // 3. Update local state
    for (var i = 0; i < _addresses.length; i++) {
      final a = _addresses[i];
      _addresses[i] = Address(
        id: a.id,
        name: a.name,
        phone: a.phone,
        addressLine1: a.addressLine1,
        addressLine2: a.addressLine2,
        city: a.city,
        state: a.state,
        zipCode: a.zipCode,
        country: a.country,
        isDefault: a.id == id,
      );
    }
    notifyListeners();
  }

  Future<void> loadAddresses(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .get();
    _addresses.clear();
    for (final doc in snapshot.docs) {
      final data = doc.data();
      _addresses.add(Address.fromMap(doc.id, data));
    }
    notifyListeners();
  }

  Future<void> saveAddress(String userId, Address address) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(address.id);
    await ref.set(address.toMap());
    await loadAddresses(userId);
  }

  Future<void> deleteAddress(String userId, String id) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(id);
    await ref.delete();
    await loadAddresses(userId);
  }
}
