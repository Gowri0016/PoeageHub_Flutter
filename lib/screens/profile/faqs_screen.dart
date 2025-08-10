import 'package:flutter/material.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  final List<Map<String, String>> faqs = const [
    // General
    {
      'question': 'How do I place an order?',
      'answer':
          'Browse products, add them to your cart, and proceed to checkout. Follow the on-screen instructions to complete your purchase.',
    },
    {
      'question': 'How do I create an account?',
      'answer':
          'Tap Sign Up on the login screen and fill in your details to create a new account.',
    },
    {
      'question': 'How do I log in?',
      'answer': 'Tap Log In and enter your registered email and password.',
    },
    {
      'question': 'How do I reset my password?',
      'answer':
          'Click on "Forgot Password" at the login screen and follow the instructions to reset your password via email.',
    },
    {
      'question': 'How do I update my profile information?',
      'answer':
          'Go to your profile and tap Edit to update your personal information.',
    },
    {
      'question': 'How do I update my shipping address?',
      'answer':
          'Go to your profile, select Addresses, and add or edit your shipping address as needed.',
    },
    {
      'question': 'How do I change my email address?',
      'answer':
          'Go to your account settings and update your email address. You may need to verify the new email.',
    },
    {
      'question': 'How do I update my password?',
      'answer':
          'Go to account settings and select Change Password. Follow the prompts to update your password.',
    },
    {
      'question': 'How do I delete my account?',
      'answer':
          'Please contact customer support to request account deletion. We will process your request promptly.',
    },
    {
      'question': 'How do I subscribe/unsubscribe to newsletters?',
      'answer':
          'You can manage your email preferences in your account settings.',
    },
    {
      'question': 'How do I enable push notifications?',
      'answer':
          'Go to your device settings and enable notifications for our app.',
    },
    {
      'question': 'How do I change the language of the app?',
      'answer':
          'Go to app settings and select your preferred language from the available options.',
    },
    // Extra General
    {
      'question': 'Can I use the app on multiple devices?',
      'answer': 'Yes, simply log in with your account on any supported device.',
    },
    {
      'question': 'Is there a dark mode available?',
      'answer': 'Yes, you can enable dark mode in the app settings.',
    },
    {
      'question': 'How do I log out?',
      'answer': 'Go to your profile and tap the Log Out button at the bottom.',
    },
    {
      'question': 'Can I customize my profile picture?',
      'answer': 'Yes, tap your profile image to upload or change your picture.',
    },
    {
      'question': 'How do I view my order history?',
      'answer':
          'Go to your profile and select Order History to view all past orders.',
    },
    {
      'question': 'How do I save my favorite products?',
      'answer': 'Tap the heart icon on any product to add it to your wishlist.',
    },
    {
      'question': 'Can I share products with friends?',
      'answer':
          'Yes, use the share button on the product page to send links via social media or messaging apps.',
    },
    {
      'question': 'How do I turn off promotional notifications?',
      'answer': 'Manage notification preferences in your account settings.',
    },
    {
      'question': 'How do I contact the app developers?',
      'answer': 'Use the Feedback or Contact Us section in the app.',
    },
    {
      'question': 'Can I use the app offline?',
      'answer':
          'Some features are available offline, but you need internet for purchases and updates.',
    },
    {
      'question': 'How do I update my phone number?',
      'answer': 'Go to your profile and edit your contact information.',
    },
    {
      'question': 'How do I set up two-factor authentication?',
      'answer':
          'Enable two-factor authentication in your account security settings.',
    },
    {
      'question': 'How do I deactivate my account temporarily?',
      'answer': 'Contact support to request temporary deactivation.',
    },
    {
      'question': 'How do I reactivate my account?',
      'answer': 'Log in again or contact support if you have issues.',
    },
    {
      'question': 'How do I change my default address?',
      'answer':
          'Go to Addresses in your profile and set your preferred address as default.',
    },
    {
      'question': 'How do I change my notification preferences?',
      'answer': 'Go to account settings and select Notification Preferences.',
    },
    {
      'question': 'How do I check app version?',
      'answer':
          'Go to About section in app settings to see the current version.',
    },
    {
      'question': 'How do I clear app cache?',
      'answer': 'Go to app settings and select Clear Cache.',
    },
    {
      'question': 'How do I report inappropriate content?',
      'answer':
          'Use the Report button on the relevant page or contact support.',
    },
    {
      'question': 'How do I block another user?',
      'answer': 'Go to the user’s profile and select Block User.',
    },
    {
      'question': 'How do I unblock a user?',
      'answer': 'Go to Blocked Users in your settings and remove the block.',
    },
    {
      'question': 'How do I change my username?',
      'answer': 'Go to profile settings and edit your username.',
    },
    {
      'question': 'How do I enable biometric login?',
      'answer':
          'Enable biometric login in the security section of app settings.',
    },
    {
      'question': 'How do I set up app lock?',
      'answer':
          'Go to security settings and enable app lock with PIN or biometrics.',
    },
    {
      'question': 'How do I get help with accessibility?',
      'answer':
          'Contact support or visit the Accessibility section in app settings.',
    },
    {
      'question': 'How do I change the app theme?',
      'answer': 'Go to app settings and select your preferred theme.',
    },
    {
      'question': 'How do I enable/disable location services?',
      'answer': 'Manage location permissions in your device settings.',
    },
    {
      'question': 'How do I check for app updates?',
      'answer': 'Visit the app store and check for available updates.',
    },
    {
      'question': 'How do I request a feature?',
      'answer':
          'Use the Feedback section in the app to submit feature requests.',
    },
    {
      'question': 'How do I view app tutorials?',
      'answer': 'Go to the Help or Tutorials section in the app.',
    },
    {
      'question': 'How do I participate in beta testing?',
      'answer':
          'Sign up for beta testing in the About or Settings section if available.',
    },
    {
      'question': 'How do I check my app permissions?',
      'answer': 'Go to your device settings and review app permissions.',
    },
    {
      'question': 'How do I contact support for urgent issues?',
      'answer':
          'Use the 24/7 live chat or call the support hotline listed in the app.',
    },
    {
      'question': 'How do I get a copy of my data?',
      'answer': 'Request a data export in your account privacy settings.',
    },
    {
      'question': 'How do I opt out of analytics tracking?',
      'answer': 'Disable analytics in your privacy settings.',
    },
    {
      'question': 'How do I set up parental controls?',
      'answer': 'Go to app settings and enable parental controls.',
    },
    {
      'question': 'How do I use voice commands?',
      'answer':
          'Enable voice control in app settings and follow the on-screen instructions.',
    },
    {
      'question': 'How do I get notified about flash sales?',
      'answer':
          'Enable promotional notifications in your notification preferences.',
    },
    {
      'question': 'How do I check my app usage statistics?',
      'answer': 'Go to the Usage section in app settings.',
    },
    {
      'question': 'How do I join the app community?',
      'answer': 'Visit the Community section in the app or on our website.',
    },
    {
      'question': 'How do I participate in contests or giveaways?',
      'answer': 'Check the Promotions or Events section in the app.',
    },
    {
      'question': 'How do I get early access to new features?',
      'answer': 'Join the beta program or subscribe to our newsletter.',
    },
    {
      'question': 'How do I request a product review?',
      'answer':
          'Contact support or use the Request Review feature on the product page.',
    },
    {
      'question': 'How do I get a product recommendation?',
      'answer':
          'Use the Product Recommendation tool in the app or contact support.',
    },
    {
      'question': 'How do I check product compatibility?',
      'answer':
          'Check the product details page or contact support for compatibility information.',
    },
    {
      'question': 'How do I get notified about restocks?',
      'answer': 'Enable restock notifications on the product page.',
    },
    {
      'question': 'How do I request a product sample?',
      'answer': 'Contact our sales team to inquire about product samples.',
    },
    {
      'question': 'How do I get a product datasheet?',
      'answer':
          'Download datasheets from the product page or request from support.',
    },
    {
      'question': 'How do I get a product safety sheet?',
      'answer': 'Request safety sheets from support for eligible products.',
    },
    {
      'question': 'How do I get a product installation guide?',
      'answer':
          'Download installation guides from the product page or request from support.',
    },
    {
      'question': 'How do I get a product warranty card?',
      'answer':
          'Warranty cards are included with eligible products or available from support.',
    },
    {
      'question': 'How do I get a product service manual?',
      'answer':
          'Service manuals are available for eligible products on request.',
    },
    {
      'question': 'How do I get a product technical drawing?',
      'answer':
          'Request technical drawings from support for eligible products.',
    },
    {
      'question': 'How do I get a product compliance certificate?',
      'answer':
          'Compliance certificates are available for eligible products on request.',
    },
    {
      'question': 'How do I get a product test report?',
      'answer': 'Test reports are available for eligible products on request.',
    },
    {
      'question': 'How do I get a product user manual?',
      'answer': 'User manuals are available for download on the product page.',
    },
    {
      'question': 'How do I get a product quick start guide?',
      'answer':
          'Quick start guides are available for eligible products on the product page.',
    },
    {
      'question': 'How do I get a product troubleshooting guide?',
      'answer':
          'Troubleshooting guides are available in the Help section or from support.',
    },
    {
      'question': 'How do I get a product FAQ?',
      'answer':
          'FAQs are available on the product page and in the Help section.',
    },
    {
      'question': 'How do I get a product support contact?',
      'answer':
          'Support contact details are listed on the product page and in the app.',
    },
    {
      'question': 'How do I get a product service center location?',
      'answer':
          'Service center locations are listed in the app and on our website.',
    },
    {
      'question': 'How do I get a product repair status?',
      'answer':
          'Repair status is available in your account dashboard or from support.',
    },
    {
      'question': 'How do I get a product replacement?',
      'answer':
          'Request a replacement in your order history or contact support.',
    },
    {
      'question': 'How do I get a product upgrade offer?',
      'answer':
          'Upgrade offers are available in the Promotions section or from support.',
    },
    {
      'question': 'How do I get a product trade-in offer?',
      'answer':
          'Trade-in offers are available for eligible products in the app.',
    },
    {
      'question': 'How do I get a product buyback offer?',
      'answer':
          'Buyback offers are available for eligible products in the app.',
    },
    {
      'question': 'How do I get a product recycling offer?',
      'answer':
          'Recycling offers are available for eligible products in the app.',
    },
    {
      'question': 'How do I get a product disposal offer?',
      'answer':
          'Disposal offers are available for eligible products in the app.',
    },
    {
      'question': 'How do I get a product insurance offer?',
      'answer':
          'Insurance offers are available for eligible products at checkout.',
    },
    {
      'question': 'How do I get a product financing offer?',
      'answer':
          'Financing offers are available for eligible products at checkout.',
    },
    {
      'question': 'How do I get a product EMI offer?',
      'answer': 'EMI offers are available for eligible products at checkout.',
    },
    {
      'question': 'How do I get a product cashback offer?',
      'answer':
          'Cashback offers are available for eligible products in the Promotions section.',
    },
    {
      'question': 'How do I get a product discount offer?',
      'answer':
          'Discount offers are available for eligible products in the Promotions section.',
    },
    {
      'question': 'How do I get a product referral offer?',
      'answer': 'Referral offers are available in the Refer & Earn section.',
    },
    {
      'question': 'How do I get a product loyalty offer?',
      'answer':
          'Loyalty offers are available for eligible users in the Rewards section.',
    },
    {
      'question': 'How do I get a product partner offer?',
      'answer': 'Partner offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product corporate offer?',
      'answer': 'Corporate offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product student offer?',
      'answer': 'Student offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product senior citizen offer?',
      'answer':
          'Senior citizen offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product military offer?',
      'answer': 'Military offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product healthcare offer?',
      'answer':
          'Healthcare offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product government offer?',
      'answer':
          'Government offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product NGO offer?',
      'answer': 'NGO offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product export offer?',
      'answer': 'Export offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product import offer?',
      'answer': 'Import offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product international offer?',
      'answer':
          'International offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product local offer?',
      'answer': 'Local offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product seasonal offer?',
      'answer': 'Seasonal offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product festival offer?',
      'answer': 'Festival offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product clearance offer?',
      'answer': 'Clearance offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product flash sale offer?',
      'answer':
          'Flash sale offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product limited time offer?',
      'answer':
          'Limited time offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product exclusive offer?',
      'answer': 'Exclusive offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product new user offer?',
      'answer': 'New user offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product returning user offer?',
      'answer':
          'Returning user offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product birthday offer?',
      'answer': 'Birthday offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product anniversary offer?',
      'answer':
          'Anniversary offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product referral bonus?',
      'answer': 'Referral bonuses are available in the Refer & Earn section.',
    },
    {
      'question': 'How do I get a product signup bonus?',
      'answer': 'Signup bonuses are available for new users in the app.',
    },
    {
      'question': 'How do I get a product feedback bonus?',
      'answer': 'Feedback bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product review bonus?',
      'answer': 'Review bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product survey bonus?',
      'answer': 'Survey bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product contest bonus?',
      'answer': 'Contest bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product event bonus?',
      'answer': 'Event bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product milestone bonus?',
      'answer':
          'Milestone bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product achievement bonus?',
      'answer':
          'Achievement bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product participation bonus?',
      'answer':
          'Participation bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product engagement bonus?',
      'answer':
          'Engagement bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product loyalty bonus?',
      'answer':
          'Loyalty bonuses are available for eligible users in the Rewards section.',
    },
    {
      'question': 'How do I get a product retention bonus?',
      'answer':
          'Retention bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product reactivation bonus?',
      'answer':
          'Reactivation bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product winback bonus?',
      'answer': 'Winback bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product upsell offer?',
      'answer': 'Upsell offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product cross-sell offer?',
      'answer':
          'Cross-sell offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product bundle offer?',
      'answer': 'Bundle offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product combo offer?',
      'answer': 'Combo offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product add-on offer?',
      'answer': 'Add-on offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product accessory offer?',
      'answer': 'Accessory offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product service offer?',
      'answer': 'Service offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product subscription offer?',
      'answer':
          'Subscription offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product renewal offer?',
      'answer': 'Renewal offers are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product upgrade bonus?',
      'answer': 'Upgrade bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product downgrade bonus?',
      'answer':
          'Downgrade bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product transfer bonus?',
      'answer': 'Transfer bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product ownership bonus?',
      'answer':
          'Ownership bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product authenticity bonus?',
      'answer':
          'Authenticity bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product compliance bonus?',
      'answer':
          'Compliance bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product legal bonus?',
      'answer': 'Legal bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product regulatory bonus?',
      'answer':
          'Regulatory bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product safety bonus?',
      'answer': 'Safety bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product environmental bonus?',
      'answer':
          'Environmental bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product social bonus?',
      'answer': 'Social bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product ethical bonus?',
      'answer': 'Ethical bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product sustainability bonus?',
      'answer':
          'Sustainability bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product innovation bonus?',
      'answer':
          'Innovation bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product technology bonus?',
      'answer':
          'Technology bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product market bonus?',
      'answer': 'Market bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product customer bonus?',
      'answer': 'Customer bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product supplier bonus?',
      'answer': 'Supplier bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product partner bonus?',
      'answer': 'Partner bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product stakeholder bonus?',
      'answer':
          'Stakeholder bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product board bonus?',
      'answer': 'Board bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product executive bonus?',
      'answer':
          'Executive bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product management bonus?',
      'answer':
          'Management bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product performance bonus?',
      'answer':
          'Performance bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product risk bonus?',
      'answer': 'Risk bonuses are available for eligible users in the app.',
    },
    {
      'question': 'How do I get a product opportunity bonus?',
      'answer':
          'Opportunity bonuses are available for eligible users in the app.',
    },
    // ...existing code...
    // Additional General
    {
      'question': 'Can I use the app on multiple devices?',
      'answer':
          'Yes, you can log in to your account on multiple devices simultaneously.',
    },
    {
      'question': 'How do I log out of all devices?',
      'answer': 'Go to account settings and select "Log out of all devices".',
    },
    {
      'question': 'How do I enable dark mode?',
      'answer': 'Go to app settings and toggle the dark mode option.',
    },
    {
      'question': 'How do I clear my app cache?',
      'answer':
          'Go to app settings and select "Clear cache" to free up storage.',
    },
    {
      'question': 'How do I update my phone number?',
      'answer':
          'Go to your profile and edit your phone number. Verification may be required.',
    },
    {
      'question': 'How do I set up two-factor authentication?',
      'answer':
          'Enable two-factor authentication in your account security settings.',
    },
    {
      'question': 'How do I view my login history?',
      'answer': 'Login history is available in your account security section.',
    },
    {
      'question': 'How do I recover a deleted account?',
      'answer':
          'Contact support as soon as possible. Account recovery is only possible within a limited time.',
    },
    {
      'question': 'How do I set a profile picture?',
      'answer':
          'Go to your profile and tap the profile picture area to upload a new photo.',
    },
    {
      'question': 'How do I manage app permissions?',
      'answer':
          'Manage permissions in your device settings under the app permissions section.',
    },
    {
      'question': 'How do I turn off location tracking?',
      'answer': 'Disable location access for the app in your device settings.',
    },
    {
      'question': 'How do I set notification preferences?',
      'answer': 'Customize notification preferences in your account settings.',
    },
    {
      'question': 'How do I access the app offline?',
      'answer':
          'Some features are available offline. Ensure you have synced your data before going offline.',
    },
    {
      'question': 'How do I report inappropriate content?',
      'answer':
          'Use the report button on the relevant page or contact support.',
    },
    {
      'question': 'How do I block or unblock a user?',
      'answer': 'Go to the user’s profile and select block or unblock.',
    },
    {
      'question': 'How do I view app version information?',
      'answer':
          'App version is displayed in the About section of the app settings.',
    },
    {
      'question': 'How do I access beta features?',
      'answer': 'Join our beta program via the app settings or our website.',
    },
    {
      'question': 'How do I request a data export?',
      'answer': 'Request a data export in your account privacy settings.',
    },
    {
      'question': 'How do I view my app usage statistics?',
      'answer': 'Usage statistics are available in your account dashboard.',
    },
    {
      'question': 'How do I set up parental controls?',
      'answer': 'Parental controls can be enabled in the app settings.',
    },
    {
      'question': 'How do I access accessibility settings?',
      'answer': 'Accessibility options are available in the app settings.',
    },
    {
      'question': 'How do I request a feature demo?',
      'answer': 'Contact our support or sales team to schedule a demo.',
    },
    {
      'question': 'How do I participate in surveys or feedback?',
      'answer':
          'Participate via the Feedback section in the app or through email invitations.',
    },
    {
      'question': 'How do I get notified about app updates?',
      'answer': 'Enable update notifications in your device or app settings.',
    },
    {
      'question': 'How do I access the help center?',
      'answer':
          'The help center is available in the app menu or on our website.',
    },
    {
      'question': 'How do I contact the app developer?',
      'answer':
          'Contact details are available in the About section of the app.',
    },
    {
      'question': 'How do I check for known issues?',
      'answer': 'Known issues are listed in the help center or on our website.',
    },
    {
      'question': 'How do I join the user community?',
      'answer': 'Join our user community via the app or our website.',
    },
    {
      'question': 'How do I access the FAQ offline?',
      'answer': 'Download the FAQ for offline access in the help center.',
    },
    {
      'question': 'How do I request a callback?',
      'answer': 'Request a callback via the support section in the app.',
    },
    // Technical
    {
      'question': 'What platforms does the app support?',
      'answer':
          'The app supports Android, iOS, web, Windows, macOS, and Linux.',
    },
    {
      'question': 'What are the minimum system requirements?',
      'answer':
          'See the app store listing or our website for minimum requirements.',
    },
    {
      'question': 'How do I report a technical issue?',
      'answer':
          'Use the in-app feedback or contact support with details and screenshots.',
    },
    {
      'question': 'How do I enable debug logs?',
      'answer':
          'Enable debug logs in the app settings under developer options.',
    },
    {
      'question': 'How do I check server status?',
      'answer': 'Server status is displayed in the app or on our status page.',
    },
    {
      'question': 'How do I troubleshoot connectivity issues?',
      'answer':
          'Check your internet connection, restart the app, or contact support.',
    },
    {
      'question': 'How do I update the app manually?',
      'answer': 'Visit the app store and tap Update.',
    },
    {
      'question': 'How do I enable/disable auto-updates?',
      'answer': 'Manage auto-update settings in your device’s app store.',
    },
    {
      'question': 'How do I check app permissions?',
      'answer': 'App permissions are listed in your device settings.',
    },
    {
      'question': 'How do I enable developer mode?',
      'answer': 'Enable developer mode in the app settings if available.',
    },
    {
      'question': 'How do I access the API?',
      'answer':
          'API access is available for partners. Contact support for details.',
    },
    {
      'question': 'How do I integrate with third-party services?',
      'answer': 'See our developer documentation or contact support.',
    },
    {
      'question': 'How do I check app logs?',
      'answer':
          'App logs are available in the developer section of the app settings.',
    },
    {
      'question': 'How do I enable crash reporting?',
      'answer':
          'Crash reporting is enabled by default. You can opt out in settings.',
    },
    {
      'question': 'How do I test beta features?',
      'answer': 'Join our beta program and enable beta features in settings.',
    },
    {
      'question': 'How do I check for app updates?',
      'answer': 'Check for updates in the app store or enable auto-updates.',
    },
    {
      'question': 'How do I access the changelog?',
      'answer':
          'The changelog is available in the About section or on our website.',
    },
    {
      'question': 'How do I enable experimental features?',
      'answer': 'Enable experimental features in the developer options.',
    },
    {
      'question': 'How do I check app compatibility?',
      'answer':
          'Compatibility information is available in the app store listing.',
    },
    // Policy & Security
    {
      'question': 'How is my data protected?',
      'answer':
          'We use encryption and follow industry best practices for data security.',
    },
    {
      'question': 'How do I request a copy of my data?',
      'answer': 'Request a data copy in your account privacy settings.',
    },
    {
      'question': 'How do I report a privacy concern?',
      'answer':
          'Contact our Data Protection Officer or use the privacy feedback form.',
    },
    {
      'question': 'How do I opt out of analytics tracking?',
      'answer': 'Opt out in your account privacy settings.',
    },
    {
      'question': 'How do I request data correction?',
      'answer': 'Request data correction in your account privacy settings.',
    },
    {
      'question': 'How do I request account restriction?',
      'answer': 'Request account restriction in your account privacy settings.',
    },
    {
      'question': 'How do I request account deactivation?',
      'answer':
          'Request deactivation in your account settings or contact support.',
    },
    {
      'question': 'How do I request account reactivation?',
      'answer': 'Contact support to request reactivation of your account.',
    },
    {
      'question': 'How do I request a privacy audit?',
      'answer':
          'Contact our Data Protection Officer to request a privacy audit.',
    },
    {
      'question': 'How do I request a security audit?',
      'answer': 'Contact our security team to request a security audit.',
    },
    {
      'question': 'How do I request a compliance report?',
      'answer': 'Request a compliance report in your account settings.',
    },
    {
      'question': 'How do I request a vulnerability assessment?',
      'answer':
          'Contact our security team to request a vulnerability assessment.',
    },
    {
      'question': 'How do I request a penetration test?',
      'answer': 'Contact our security team to request a penetration test.',
    },
    {
      'question': 'How do I request a security incident report?',
      'answer': 'Contact our security team to request an incident report.',
    },
    {
      'question': 'How do I request a data breach notification?',
      'answer':
          'You will be notified in accordance with applicable laws if a breach occurs.',
    },
    {
      'question': 'How do I request a privacy impact assessment?',
      'answer':
          'Contact our Data Protection Officer to request a privacy impact assessment.',
    },
    {
      'question': 'How do I request a data retention policy?',
      'answer': 'Request a copy of our data retention policy from support.',
    },
    {
      'question': 'How do I request a cookie policy?',
      'answer': 'Our cookie policy is available on our website or by request.',
    },
    {
      'question': 'How do I request a terms of service document?',
      'answer':
          'Our terms of service are available on our website or by request.',
    },
    {
      'question': 'How do I request a privacy policy document?',
      'answer': 'Our privacy policy is available on our website or by request.',
    },
    {
      'question': 'How do I request a data processing agreement?',
      'answer': 'Contact support to request a data processing agreement.',
    },
    {
      'question': 'How do I request a list of sub-processors?',
      'answer': 'Contact support to request a list of sub-processors.',
    },
    {
      'question': 'How do I request a data transfer agreement?',
      'answer': 'Contact support to request a data transfer agreement.',
    },
    {
      'question': 'How do I request a data minimization policy?',
      'answer': 'Contact support to request a data minimization policy.',
    },
    {
      'question': 'How do I request a data subject access request (DSAR)?',
      'answer': 'Submit a DSAR in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to be forgotten?',
      'answer': 'Request data deletion in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to object?',
      'answer': 'Submit your objection in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to restrict processing?',
      'answer': 'Request restriction in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to data portability?',
      'answer': 'Request data portability in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to rectification?',
      'answer': 'Request rectification in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to access?',
      'answer': 'Request access in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to lodge a complaint?',
      'answer': 'Contact our Data Protection Officer or your local authority.',
    },
    {
      'question': 'How do I request a right to withdraw consent?',
      'answer': 'Withdraw consent in your account privacy settings.',
    },
    {
      'question': 'How do I request a right to information?',
      'answer': 'Request information in your account privacy settings.',
    },
    // Advanced
    {
      'question': 'How do I request a custom API integration?',
      'answer':
          'Contact our technical team to discuss custom API integrations.',
    },
    {
      'question': 'How do I request a sandbox environment?',
      'answer': 'Request a sandbox environment via the developer portal.',
    },
    {
      'question': 'How do I request a test account?',
      'answer': 'Request a test account via the developer portal or support.',
    },
    {
      'question': 'How do I request developer documentation?',
      'answer':
          'Developer documentation is available on our website or by request.',
    },
    {
      'question': 'How do I request a technical whitepaper?',
      'answer': 'Request a whitepaper from our technical team.',
    },
    {
      'question': 'How do I request a product roadmap?',
      'answer': 'Contact our product team to request a roadmap.',
    },
    {
      'question': 'How do I request a service level agreement (SLA)?',
      'answer': 'Contact support to request an SLA.',
    },
    {
      'question': 'How do I request a business continuity plan?',
      'answer': 'Contact support to request a business continuity plan.',
    },
    {
      'question': 'How do I request a disaster recovery plan?',
      'answer': 'Contact support to request a disaster recovery plan.',
    },
    {
      'question': 'How do I request a technical support escalation?',
      'answer': 'Request escalation via the support section in the app.',
    },
    {
      'question': 'How do I request a product lifecycle policy?',
      'answer': 'Contact support to request a lifecycle policy.',
    },
    {
      'question': 'How do I request a product end-of-life notice?',
      'answer':
          'End-of-life notices are available in the help center or by request.',
    },
    {
      'question': 'How do I request a migration guide?',
      'answer':
          'Migration guides are available in the developer documentation.',
    },
    {
      'question': 'How do I request a compatibility matrix?',
      'answer':
          'Compatibility matrices are available in the developer documentation.',
    },
    {
      'question': 'How do I request a release schedule?',
      'answer':
          'Release schedules are published in the help center or by request.',
    },
    {
      'question': 'How do I request a bug bounty program?',
      'answer':
          'Contact our security team to inquire about bug bounty programs.',
    },
    {
      'question': 'How do I request a code review?',
      'answer': 'Request a code review via the developer portal or support.',
    },
    {
      'question': 'How do I request a technical consultation?',
      'answer': 'Contact our technical team to schedule a consultation.',
    },
    {
      'question': 'How do I request a training session?',
      'answer': 'Request training via the support section or our website.',
    },
    {
      'question': 'How do I request a certification exam?',
      'answer': 'Contact support to request a certification exam.',
    },
    {
      'question': 'How do I request a user guide?',
      'answer': 'User guides are available in the help center or by request.',
    },
    {
      'question': 'How do I request a quick start guide?',
      'answer':
          'Quick start guides are available in the help center or by request.',
    },
    {
      'question': 'How do I request a troubleshooting guide?',
      'answer':
          'Troubleshooting guides are available in the help center or by request.',
    },
    {
      'question': 'How do I request a best practices guide?',
      'answer':
          'Best practices guides are available in the help center or by request.',
    },
    {
      'question': 'How do I request a knowledge base article?',
      'answer':
          'Knowledge base articles are available in the help center or by request.',
    },
    {
      'question': 'How do I request a webinar?',
      'answer': 'Webinars are announced in the app and on our website.',
    },
    {
      'question': 'How do I request a product video tutorial?',
      'answer':
          'Video tutorials are available in the help center or by request.',
    },
    {
      'question': 'How do I request a live chat with support?',
      'answer': 'Live chat is available in the app and on our website.',
    },
    {
      'question': 'How do I request a callback from technical support?',
      'answer': 'Request a callback via the support section in the app.',
    },
    {
      'question': 'How do I request a product walk-through?',
      'answer': 'Contact support to schedule a walk-through.',
    },
    {
      'question': 'How do I request a product onboarding session?',
      'answer': 'Onboarding sessions are available by request via support.',
    },
    {
      'question': 'How do I request a product integration guide?',
      'answer':
          'Integration guides are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product API key?',
      'answer':
          'API keys are available for partners. Contact support for details.',
    },
    {
      'question': 'How do I request a product SDK?',
      'answer': 'SDKs are available in the developer portal or by request.',
    },
    {
      'question': 'How do I request a product sample code?',
      'answer': 'Sample code is available in the developer documentation.',
    },
    {
      'question': 'How do I request a product test environment?',
      'answer':
          'Test environments are available for partners. Contact support for details.',
    },
    {
      'question': 'How do I request a product technical specification?',
      'answer':
          'Technical specifications are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product architecture diagram?',
      'answer':
          'Architecture diagrams are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product API documentation?',
      'answer': 'API documentation is available in the developer portal.',
    },
    {
      'question': 'How do I request a product release notes?',
      'answer': 'Release notes are published in the help center or by request.',
    },
    {
      'question': 'How do I request a product support matrix?',
      'answer':
          'Support matrices are available in the help center or by request.',
    },
    {
      'question': 'How do I request a product escalation procedure?',
      'answer':
          'Escalation procedures are available in the help center or by request.',
    },
    {
      'question': 'How do I request a product maintenance window?',
      'answer':
          'Maintenance windows are announced in the app and on our website.',
    },
    {
      'question': 'How do I request a product downtime schedule?',
      'answer':
          'Downtime schedules are published in the help center or by request.',
    },
    {
      'question': 'How do I request a product SLA breach report?',
      'answer': 'SLA breach reports are available by request from support.',
    },
    {
      'question': 'How do I request a product incident report?',
      'answer': 'Incident reports are available by request from support.',
    },
    {
      'question': 'How do I request a product root cause analysis?',
      'answer': 'Root cause analyses are available by request from support.',
    },
    {
      'question': 'How do I request a product change log?',
      'answer': 'Change logs are available in the help center or by request.',
    },
    {
      'question': 'How do I request a product upgrade path?',
      'answer': 'Upgrade paths are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product downgrade path?',
      'answer': 'Downgrade paths are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product rollback procedure?',
      'answer':
          'Rollback procedures are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product migration tool?',
      'answer': 'Migration tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product compatibility tool?',
      'answer':
          'Compatibility tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product monitoring tool?',
      'answer':
          'Monitoring tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product analytics tool?',
      'answer': 'Analytics tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product reporting tool?',
      'answer': 'Reporting tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product alerting tool?',
      'answer': 'Alerting tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product notification tool?',
      'answer':
          'Notification tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product automation tool?',
      'answer':
          'Automation tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product integration tool?',
      'answer':
          'Integration tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product testing tool?',
      'answer': 'Testing tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product deployment tool?',
      'answer':
          'Deployment tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product CI/CD tool?',
      'answer': 'CI/CD tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product build tool?',
      'answer': 'Build tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product code quality tool?',
      'answer':
          'Code quality tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product code coverage tool?',
      'answer':
          'Code coverage tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product static analysis tool?',
      'answer':
          'Static analysis tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product dynamic analysis tool?',
      'answer':
          'Dynamic analysis tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product performance tool?',
      'answer':
          'Performance tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product scalability tool?',
      'answer':
          'Scalability tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product reliability tool?',
      'answer':
          'Reliability tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product availability tool?',
      'answer':
          'Availability tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product maintainability tool?',
      'answer':
          'Maintainability tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product security tool?',
      'answer': 'Security tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product compliance tool?',
      'answer':
          'Compliance tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product governance tool?',
      'answer':
          'Governance tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product risk management tool?',
      'answer':
          'Risk management tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product documentation tool?',
      'answer':
          'Documentation tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product collaboration tool?',
      'answer':
          'Collaboration tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product communication tool?',
      'answer':
          'Communication tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product scheduling tool?',
      'answer':
          'Scheduling tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product resource management tool?',
      'answer':
          'Resource management tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product budgeting tool?',
      'answer': 'Budgeting tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product forecasting tool?',
      'answer':
          'Forecasting tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product planning tool?',
      'answer': 'Planning tools are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product reporting dashboard?',
      'answer':
          'Reporting dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product analytics dashboard?',
      'answer':
          'Analytics dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product monitoring dashboard?',
      'answer':
          'Monitoring dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product alerting dashboard?',
      'answer':
          'Alerting dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product notification dashboard?',
      'answer':
          'Notification dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product automation dashboard?',
      'answer':
          'Automation dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product integration dashboard?',
      'answer':
          'Integration dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product testing dashboard?',
      'answer':
          'Testing dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product deployment dashboard?',
      'answer':
          'Deployment dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product CI/CD dashboard?',
      'answer':
          'CI/CD dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product build dashboard?',
      'answer':
          'Build dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product code quality dashboard?',
      'answer':
          'Code quality dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product code coverage dashboard?',
      'answer':
          'Code coverage dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product static analysis dashboard?',
      'answer':
          'Static analysis dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product dynamic analysis dashboard?',
      'answer':
          'Dynamic analysis dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product performance dashboard?',
      'answer':
          'Performance dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product scalability dashboard?',
      'answer':
          'Scalability dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product reliability dashboard?',
      'answer':
          'Reliability dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product availability dashboard?',
      'answer':
          'Availability dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product maintainability dashboard?',
      'answer':
          'Maintainability dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product security dashboard?',
      'answer':
          'Security dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product compliance dashboard?',
      'answer':
          'Compliance dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product governance dashboard?',
      'answer':
          'Governance dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product risk management dashboard?',
      'answer':
          'Risk management dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product documentation dashboard?',
      'answer':
          'Documentation dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product collaboration dashboard?',
      'answer':
          'Collaboration dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product communication dashboard?',
      'answer':
          'Communication dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product scheduling dashboard?',
      'answer':
          'Scheduling dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product resource management dashboard?',
      'answer':
          'Resource management dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product budgeting dashboard?',
      'answer':
          'Budgeting dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product forecasting dashboard?',
      'answer':
          'Forecasting dashboards are available in the developer documentation.',
    },
    {
      'question': 'How do I request a product planning dashboard?',
      'answer':
          'Planning dashboards are available in the developer documentation.',
    },
    // ...existing code...
    // Orders & Payments
    {
      'question': 'How can I track my order?',
      'answer':
          'After your order is shipped, you will receive a tracking link via email and in your account order history.',
    },
    {
      'question': 'How do I cancel or change my order?',
      'answer':
          'Orders can be changed or cancelled before they are shipped. Please contact support as soon as possible.',
    },
    {
      'question': 'How do I apply a promo code?',
      'answer':
          'Enter your promo code at checkout in the designated field to receive your discount.',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer':
          'We accept credit/debit cards, net banking, UPI, PayPal, and various wallets for your convenience.',
    },
    {
      'question': 'How do I use store credit or gift cards?',
      'answer':
          'Enter your store credit or gift card code at checkout to apply the balance to your order.',
    },
    {
      'question': 'What should I do if my payment fails?',
      'answer':
          'Try a different payment method or contact your bank. If the issue persists, contact our support team.',
    },
    {
      'question': 'Can I use multiple promo codes on one order?',
      'answer':
          'Only one promo code can be applied per order unless otherwise specified.',
    },
    {
      'question': 'How do I request a price match?',
      'answer':
          'Contact support with a link to the competitor’s offer. Price match is subject to terms and conditions.',
    },
    {
      'question': 'How do I get a tax invoice for business purchases?',
      'answer':
          'Select the business purchase option at checkout and provide your GSTIN or business details.',
    },
    {
      'question': 'How do I request a GST invoice?',
      'answer':
          'Select the GST invoice option at checkout or contact support after placing your order.',
    },
    {
      'question': 'How do I get an invoice for my order?',
      'answer':
          'Invoices are available in your order history. You can download or print them anytime.',
    },
    {
      'question': 'How do I get a copy of my previous invoices?',
      'answer':
          'All invoices are stored in your account order history for download.',
    },
    // Shipping & Delivery
    {
      'question': 'Do you offer international shipping?',
      'answer':
          'Yes, we ship to many countries worldwide. Shipping charges and delivery times vary by location.',
    },
    {
      'question': 'How do I check delivery charges?',
      'answer':
          'Delivery charges are calculated at checkout based on your location and order value.',
    },
    {
      'question': 'How do I check if a product is eligible for free shipping?',
      'answer':
          'Eligible products are marked with a Free Shipping badge on the product page.',
    },
    {
      'question': 'Can I request a product that is not listed?',
      'answer':
          'Yes, use the Product Request form on our website to suggest new products.',
    },
    {
      'question': 'How do I subscribe to product restock alerts?',
      'answer':
          'On the product page, click Notify Me to get an alert when the item is back in stock.',
    },
    // Returns & Refunds
    {
      'question': 'What is your return policy?',
      'answer':
          'You can return most items within 7 days of delivery. Please visit our Returns & Refunds page for detailed instructions.',
    },
    {
      'question': 'How do I return an item?',
      'answer':
          'Go to your order history, select the item, and follow the return instructions.',
    },
    {
      'question': 'How do I check the status of a refund?',
      'answer':
          'Refund status is available in your order history. You will also receive email updates.',
    },
    {
      'question': 'What if I receive a damaged or wrong item?',
      'answer':
          'Please contact our support team with your order details and photos. We will resolve the issue promptly.',
    },
    // Products & Reviews
    {
      'question': 'How do I check product availability?',
      'answer':
          'Product availability is shown on each product page. Out-of-stock items cannot be added to cart.',
    },
    {
      'question': 'How do I leave a product review?',
      'answer':
          'After your order is delivered, go to the product page and click on "Write a Review".',
    },
    {
      'question': 'Can I save items for later?',
      'answer':
          'Yes, use the Wishlist feature to save products you want to purchase later.',
    },
    {
      'question': 'How do I refer a friend?',
      'answer':
          'Use the Refer & Earn section in your account to invite friends and earn rewards.',
    },
    {
      'question': 'How do I check my reward points?',
      'answer':
          'Reward points are visible in your account dashboard. You can redeem them at checkout.',
    },
    {
      'question': 'Are there any loyalty or rewards programs?',
      'answer':
          'Yes, we offer a rewards program. Earn points on every purchase and redeem them for discounts.',
    },
    // Support & Contact
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can reach us via the Contact Us page, email, or our 24/7 live chat support.',
    },
    {
      'question': 'What are your customer support hours?',
      'answer': 'Our support team is available 24/7 via live chat and email.',
    },
    {
      'question': 'How do I request a callback from support?',
      'answer':
          'Fill out the Callback Request form on our Contact Us page and our team will reach out.',
    },
    {
      'question': 'How do I request a product demo?',
      'answer':
          'Contact our sales team to schedule a live or virtual product demonstration.',
    },
    {
      'question': 'How do I get technical support for app issues?',
      'answer':
          'Use the in-app support chat or email support@primepick.com with details and screenshots.',
    },
    {
      'question': 'How do I report a bug or issue?',
      'answer':
          'Please use the Feedback section in the app or contact support with details and screenshots.',
    },
    {
      'question': 'How do I request a feature or improvement?',
      'answer':
          'Submit your suggestion via the Feedback section in the app or on our website.',
    },
    {
      'question': 'How do I join your affiliate program?',
      'answer':
          'Visit our Affiliate Program page for details and sign-up instructions.',
    },
    {
      'question': 'How do I request a custom order or bulk quote?',
      'answer':
          'Fill out the Bulk Order form on our website or contact our sales team.',
    },
    {
      'question': 'Do you offer bulk or corporate orders?',
      'answer':
          'Yes, please contact our sales team for bulk or corporate order inquiries.',
    },
    // Security & Privacy
    {
      'question': 'Is my payment information secure?',
      'answer':
          'Yes, we use industry-standard SSL encryption and do not store your card details on our servers.',
    },
    {
      'question': 'What is your privacy policy regarding user data?',
      'answer':
          'We comply with all applicable data protection laws. Read our full privacy policy on our website.',
    },
    {
      'question': 'How do I request data deletion under GDPR?',
      'answer':
          'Contact our Data Protection Officer via the Privacy section in your account settings.',
    },
    {
      'question': 'How do I report a security vulnerability?',
      'answer':
          'Email our security team at security@primepick.com with details of the issue.',
    },
    // App & Technical
    {
      'question': 'How do I update my app to the latest version?',
      'answer':
          'Visit the App Store or Google Play Store, search for our app, and tap Update if available.',
    },
    {
      'question': 'What should I do if my app crashes or freezes?',
      'answer':
          'Restart the app and your device. If the issue persists, reinstall the app or contact support.',
    },
    {
      'question': 'What accessibility features does your app support?',
      'answer':
          'Our app supports screen readers, high-contrast mode, and adjustable font sizes.',
    },
    {
      'question': 'How do I change the language of the app?',
      'answer':
          'Go to app settings and select your preferred language from the available options.',
    },
    {
      'question': 'How do I get updates on new arrivals?',
      'answer':
          'Subscribe to our newsletter or follow us on social media for the latest updates.',
    },
    {
      'question': 'Why am I not receiving order confirmation emails?',
      'answer':
          'Check your spam or junk folder. Ensure your email address is correct in your account settings.',
    },
    // Advanced/Policy
    {
      'question': 'How do I request data portability?',
      'answer':
          'Contact our support team to request a copy of your data in a portable format.',
    },
    {
      'question': 'How do I opt out of marketing communications?',
      'answer':
          'You can opt out in your account settings or by clicking the unsubscribe link in our emails.',
    },
    {
      'question': 'How do I request a product sample?',
      'answer': 'Contact our sales team to inquire about product samples.',
    },
    {
      'question': 'How do I request a callback from support?',
      'answer':
          'Fill out the Callback Request form on our Contact Us page and our team will reach out.',
    },
    {
      'question': 'How do I contact the seller directly?',
      'answer':
          'Use the Ask Seller feature on the product page to send a direct message.',
    },
    {
      'question': 'How do I get a price breakdown for my order?',
      'answer':
          'A detailed price breakdown is available at checkout and in your order summary.',
    },
    {
      'question': 'How do I request a product customization?',
      'answer':
          'Contact our support or sales team to discuss customization options.',
    },
    {
      'question': 'How do I subscribe to SMS alerts?',
      'answer': 'Enable SMS alerts in your account notification preferences.',
    },
    {
      'question': 'How do I get a warranty for my product?',
      'answer':
          'Warranty details are provided on the product page and in your order confirmation.',
    },
    {
      'question': 'How do I request a product recall?',
      'answer':
          'If you believe a product should be recalled, contact our support team immediately.',
    },
    {
      'question': 'How do I check the status of a service request?',
      'answer':
          'Service request status is available in your account dashboard.',
    },
    {
      'question': 'How do I request a product installation?',
      'answer':
          'Select installation at checkout or contact support after purchase.',
    },
    {
      'question': 'How do I get a certificate of authenticity?',
      'answer':
          'Certificates are provided for eligible products. Contact support for more info.',
    },
    {
      'question': 'How do I request a product manual?',
      'answer':
          'Product manuals are available for download on the product page.',
    },
    {
      'question': 'How do I check the status of a backorder?',
      'answer':
          'Backorder status is shown in your order history and you will receive updates via email.',
    },
    {
      'question': 'How do I request a product recall?',
      'answer':
          'If you believe a product should be recalled, contact our support team immediately.',
    },
    {
      'question': 'How do I request a product upgrade?',
      'answer': 'Contact our support or sales team to discuss upgrade options.',
    },
    {
      'question': 'How do I request a product exchange?',
      'answer':
          'Go to your order history, select the item, and follow the exchange instructions.',
    },
    {
      'question': 'How do I check the status of a loyalty reward?',
      'answer': 'Loyalty reward status is available in your account dashboard.',
    },
    {
      'question': 'How do I request a refund for a digital product?',
      'answer':
          'Contact support with your order details for digital product refund requests.',
    },
    {
      'question': 'How do I get a product sample?',
      'answer': 'Contact our sales team to inquire about product samples.',
    },
    {
      'question': 'How do I request a product trial?',
      'answer':
          'Contact our sales team to request a trial for eligible products.',
    },
    {
      'question': 'How do I check the status of a pre-order?',
      'answer': 'Pre-order status is available in your order history.',
    },
    {
      'question': 'How do I request a product return label?',
      'answer':
          'Return labels are available in your order history for eligible returns.',
    },
    {
      'question': 'How do I request a product warranty extension?',
      'answer': 'Contact support to inquire about warranty extension options.',
    },
    {
      'question': 'How do I request a product installation?',
      'answer':
          'Select installation at checkout or contact support after purchase.',
    },
    {
      'question': 'How do I request a product repair?',
      'answer':
          'Go to your order history and select the repair option for eligible products.',
    },
    {
      'question': 'How do I request a product disposal?',
      'answer': 'Contact support to arrange for responsible product disposal.',
    },
    {
      'question': 'How do I request a product recycling?',
      'answer': 'Contact support to arrange for product recycling.',
    },
    {
      'question': 'How do I request a product trade-in?',
      'answer':
          'Contact support to check if your product is eligible for trade-in.',
    },
    {
      'question': 'How do I request a product insurance?',
      'answer':
          'Product insurance options are available at checkout for eligible products.',
    },
    {
      'question': 'How do I request a product appraisal?',
      'answer':
          'Contact our support or sales team to request a product appraisal.',
    },
    {
      'question': 'How do I request a product certification?',
      'answer':
          'Contact support to request certification for eligible products.',
    },
    {
      'question': 'How do I request a product compliance document?',
      'answer':
          'Contact support to request compliance documents for eligible products.',
    },
    {
      'question': 'How do I request a product export document?',
      'answer':
          'Contact support to request export documents for international orders.',
    },
    {
      'question': 'How do I request a product import document?',
      'answer':
          'Contact support to request import documents for international orders.',
    },
    {
      'question': 'How do I request a product inspection?',
      'answer': 'Contact support to request inspection for eligible products.',
    },
    {
      'question': 'How do I request a product insurance claim?',
      'answer':
          'Contact support to file an insurance claim for eligible products.',
    },
    {
      'question': 'How do I request a product maintenance?',
      'answer':
          'Contact support to schedule maintenance for eligible products.',
    },
    {
      'question': 'How do I request a product upgrade?',
      'answer': 'Contact our support or sales team to discuss upgrade options.',
    },
    {
      'question': 'How do I request a product downgrade?',
      'answer':
          'Contact our support or sales team to discuss downgrade options.',
    },
    {
      'question': 'How do I request a product transfer?',
      'answer': 'Contact support to request transfer of product ownership.',
    },
    {
      'question': 'How do I request a product ownership certificate?',
      'answer':
          'Contact support to request an ownership certificate for eligible products.',
    },
    {
      'question': 'How do I request a product authenticity check?',
      'answer':
          'Contact support to request authenticity check for eligible products.',
    },
    {
      'question': 'How do I request a product recall?',
      'answer':
          'If you believe a product should be recalled, contact our support team immediately.',
    },
    {
      'question': 'How do I request a product withdrawal?',
      'answer': 'Contact support to request withdrawal of a product from sale.',
    },
    {
      'question': 'How do I request a product ban?',
      'answer':
          'Contact support to request a ban on a product for legal or safety reasons.',
    },
    {
      'question': 'How do I request a product investigation?',
      'answer':
          'Contact support to request investigation for eligible products.',
    },
    {
      'question': 'How do I request a product audit?',
      'answer': 'Contact support to request an audit for eligible products.',
    },
    {
      'question': 'How do I request a product compliance review?',
      'answer':
          'Contact support to request a compliance review for eligible products.',
    },
    {
      'question': 'How do I request a product legal review?',
      'answer':
          'Contact support to request a legal review for eligible products.',
    },
    {
      'question': 'How do I request a product regulatory review?',
      'answer':
          'Contact support to request a regulatory review for eligible products.',
    },
    {
      'question': 'How do I request a product safety review?',
      'answer':
          'Contact support to request a safety review for eligible products.',
    },
    {
      'question': 'How do I request a product environmental review?',
      'answer':
          'Contact support to request an environmental review for eligible products.',
    },
    {
      'question': 'How do I request a product social review?',
      'answer':
          'Contact support to request a social review for eligible products.',
    },
    {
      'question': 'How do I request a product ethical review?',
      'answer':
          'Contact support to request an ethical review for eligible products.',
    },
    {
      'question': 'How do I request a product sustainability review?',
      'answer':
          'Contact support to request a sustainability review for eligible products.',
    },
    {
      'question': 'How do I request a product innovation review?',
      'answer':
          'Contact support to request an innovation review for eligible products.',
    },
    {
      'question': 'How do I request a product technology review?',
      'answer':
          'Contact support to request a technology review for eligible products.',
    },
    {
      'question': 'How do I request a product market review?',
      'answer':
          'Contact support to request a market review for eligible products.',
    },
    {
      'question': 'How do I request a product customer review?',
      'answer':
          'Contact support to request a customer review for eligible products.',
    },
    {
      'question': 'How do I request a product supplier review?',
      'answer':
          'Contact support to request a supplier review for eligible products.',
    },
    {
      'question': 'How do I request a product partner review?',
      'answer':
          'Contact support to request a partner review for eligible products.',
    },
    {
      'question': 'How do I request a product stakeholder review?',
      'answer':
          'Contact support to request a stakeholder review for eligible products.',
    },
    {
      'question': 'How do I request a product board review?',
      'answer':
          'Contact support to request a board review for eligible products.',
    },
    {
      'question': 'How do I request a product executive review?',
      'answer':
          'Contact support to request an executive review for eligible products.',
    },
    {
      'question': 'How do I request a product management review?',
      'answer':
          'Contact support to request a management review for eligible products.',
    },
    {
      'question': 'How do I request a product performance review?',
      'answer':
          'Contact support to request a performance review for eligible products.',
    },
    {
      'question': 'How do I request a product risk review?',
      'answer':
          'Contact support to request a risk review for eligible products.',
    },
    {
      'question': 'How do I request a product opportunity review?',
      'answer':
          'Contact support to request an opportunity review for eligible products.',
    },
    {
      'question': 'How do I request a product threat review?',
      'answer':
          'Contact support to request a threat review for eligible products.',
    },
    {
      'question': 'How do I request a product SWOT analysis?',
      'answer':
          'Contact support to request a SWOT analysis for eligible products.',
    },
    {
      'question': 'How do I request a product PEST analysis?',
      'answer':
          'Contact support to request a PEST analysis for eligible products.',
    },
    {
      'question': 'How do I request a product competitor analysis?',
      'answer':
          'Contact support to request a competitor analysis for eligible products.',
    },
    {
      'question': 'How do I request a product market analysis?',
      'answer':
          'Contact support to request a market analysis for eligible products.',
    },
    {
      'question': 'How do I request a product customer analysis?',
      'answer':
          'Contact support to request a customer analysis for eligible products.',
    },
    {
      'question': 'How do I request a product supplier analysis?',
      'answer':
          'Contact support to request a supplier analysis for eligible products.',
    },
    {
      'question': 'How do I request a product partner analysis?',
      'answer':
          'Contact support to request a partner analysis for eligible products.',
    },
    {
      'question': 'How do I request a product stakeholder analysis?',
      'answer':
          'Contact support to request a stakeholder analysis for eligible products.',
    },
    {
      'question': 'How do I request a product board analysis?',
      'answer':
          'Contact support to request a board analysis for eligible products.',
    },
    {
      'question': 'How do I request a product executive analysis?',
      'answer':
          'Contact support to request an executive analysis for eligible products.',
    },
    {
      'question': 'How do I request a product management analysis?',
      'answer':
          'Contact support to request a management analysis for eligible products.',
    },
    {
      'question': 'How do I request a product performance analysis?',
      'answer':
          'Contact support to request a performance analysis for eligible products.',
    },
    {
      'question': 'How do I request a product risk analysis?',
      'answer':
          'Contact support to request a risk analysis for eligible products.',
    },
    {
      'question': 'How do I request a product opportunity analysis?',
      'answer':
          'Contact support to request an opportunity analysis for eligible products.',
    },
    {
      'question': 'How do I request a product threat analysis?',
      'answer':
          'Contact support to request a threat analysis for eligible products.',
    },
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Map<String, String>> filteredFaqs = faqs
        .where(
          (faq) =>
              faq['question']!.toLowerCase().contains(search.toLowerCase()) ||
              faq['answer']!.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();

    // Suggestions for autocomplete
    List<String> suggestions = search.isEmpty
        ? []
        : faqs
              .map((faq) => faq['question']!)
              .where((q) => q.toLowerCase().contains(search.toLowerCase()))
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        backgroundColor: theme.colorScheme.primary,
        elevation: 2,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: Container(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    TextField(
                      onChanged: (val) => setState(() => search = val),
                      decoration: InputDecoration(
                        hintText: 'Search questions... ',
                        prefixIcon: Icon(
                          Icons.search,
                          color: theme.colorScheme.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.cardColor,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                      ),
                    ),
                    if (suggestions.isNotEmpty)
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 56,
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: suggestions.length,
                            itemBuilder: (context, idx) {
                              return ListTile(
                                title: Text(suggestions[idx]),
                                onTap: () {
                                  setState(() {
                                    search = suggestions[idx];
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: filteredFaqs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final faq = filteredFaqs[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: theme.cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: theme.copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        childrenPadding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 16,
                        ),
                        title: Row(
                          children: [
                            Icon(
                              Icons.help_outline_rounded,
                              color: theme.colorScheme.primary,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                faq['question']!,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        iconColor: theme.colorScheme.primary,
                        collapsedIconColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              faq['answer']!,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.brightness == Brightness.dark
                                    ? Colors.white
                                    : const Color.fromRGBO(50, 50, 50, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
