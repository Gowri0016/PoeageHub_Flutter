import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService with ChangeNotifier {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? _token;
  String? get token => _token;

  Future<void> init() async {
    // Request permissions (iOS)
    await _fcm.requestPermission();
    // Get the token
    _token = await _fcm.getToken();
    notifyListeners();
    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen(_onMessage);
    // Listen for background/terminated messages
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  void _onMessage(RemoteMessage message) {
    // Handle foreground notification
    debugPrint(
      'FCM Foreground: ${message.notification?.title} - ${message.notification?.body}',
    );
    // You can show a local notification here if desired
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    // Handle notification tap when app is in background/terminated
    debugPrint(
      'FCM Opened: ${message.notification?.title} - ${message.notification?.body}',
    );
    // Navigate or perform actions as needed
  }

  Future<void> subscribeToTopic(String topic) async {
    await _fcm.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _fcm.unsubscribeFromTopic(topic);
  }

  // Send a notification to a specific device (requires server key and backend call)
  Future<void> sendPushNotification({
    required String title,
    required String body,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    // This is a placeholder. In production, you should call your backend or a cloud function
    // to send the notification using the FCM server key.
    debugPrint('Send push: $title - $body to $token');
    // Example: await http.post(...)
  }

  // Helper for order status updates
  Future<void> notifyOrderStatus({
    required String userToken,
    required String orderId,
    required String status,
  }) async {
    await sendPushNotification(
      title: 'Order Update',
      body: 'Your order #$orderId is now $status.',
      token: userToken,
      data: {'orderId': orderId, 'status': status},
    );
  }

  // Helper for promotions
  Future<void> notifyPromotion({
    required String title,
    required String body,
  }) async {
    await sendPushNotification(
      title: title,
      body: body,
      // Optionally use topic for all users
    );
  }

  // Helper for abandoned cart reminders
  Future<void> notifyAbandonedCart({required String userToken}) async {
    await sendPushNotification(
      title: 'Don\'t forget your cart!',
      body: 'You have items waiting in your cart. Complete your purchase now!',
      token: userToken,
    );
  }
}
