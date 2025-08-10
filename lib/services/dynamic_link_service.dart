// ignore_for_file: deprecated_member_use
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  static Future<void> handleDynamicLinks({
    required void Function(Uri deepLink) onDeepLink,
  }) async {
    // Handle dynamic link when app is opened from terminated state
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks
        .instance
        .getInitialLink();
    _handleLink(initialLink, onDeepLink);

    // Handle dynamic link when app is in background/foreground
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleLink(dynamicLinkData, onDeepLink);
    });
  }

  static void _handleLink(
    PendingDynamicLinkData? data,
    void Function(Uri deepLink) onDeepLink,
  ) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      onDeepLink(deepLink);
    }
  }

  static Future<Uri> createProductLink(String productId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://yourapp.page.link',
      link: Uri.parse('https://yourapp.com/product?id=$productId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.yourcompany.yourapp',
      ),
      iosParameters: const IOSParameters(bundleId: 'com.yourcompany.yourapp'),
    );
    final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance
        .buildShortLink(parameters);
    return shortLink.shortUrl;
  }
}
