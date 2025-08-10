import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountDeletionService {
  static Future<String?> deleteAccount({
    required User user,
    required String name,
    required String reason,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final uid = user.uid;
    final email = user.email;
    try {
      // Store deletion note
      await FirebaseFirestore.instance.collection('deletion_notes').add({
        'uid': uid,
        'email': email,
        'name': name,
        'reason': reason,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Delete user profile
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      // Delete Firebase Auth user
      await user.delete();
      onSuccess();
      return null;
    } catch (e) {
      onError(e.toString());
      return e.toString();
    }
  }
}
