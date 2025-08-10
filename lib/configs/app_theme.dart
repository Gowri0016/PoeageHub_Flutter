import 'package:flutter/material.dart';

// Modern Blue Color palette
const MaterialColor kPrimarySwatch = MaterialColor(
  0xFF1976D2, // Modern Blue (main branding color)
  <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(0xFF1976D2), // Main
    600: Color(0xFF1565C0),
    700: Color(0xFF0D47A1),
    800: Color(0xFF0B3C91),
    900: Color(0xFF082A5E),
  },
);
const Color kAccentBlue = Color(0xFF64B5F6); // Lighter blue accent
const Color kBackground = Color(0xFFF8FAFC); // Subtle off-white
const Color kSubtleGray = Color(0xFFF1F5F9); // Very light gray
const Color kCardGray = Color(0xFFFFFFFF); // Pure white for cards
const Color kHeadingText = Color(0xFF222B45); // Deep blue-gray
const Color kSecondaryText = Color(0xFF5A6273); // Muted blue-gray
const Color kPlaceholderText = Color(0xFFB0BEC5); // Soft blue-gray
const double kBorderRadius = 14.0;

ThemeData lightTheme = ThemeData(
  colorScheme:
      ColorScheme.fromSwatch(
        primarySwatch: kPrimarySwatch,
        backgroundColor: kBackground,
        cardColor: kCardGray,
        accentColor: kAccentBlue,
      ).copyWith(
        secondary: kAccentBlue,
        surface: kCardGray,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: kSecondaryText,
      ),
  scaffoldBackgroundColor: kBackground,
  cardColor: kCardGray,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: kHeadingText,
      letterSpacing: 0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: kHeadingText,
      letterSpacing: 0.2,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kHeadingText,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: kSecondaryText,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: kSecondaryText),
    labelLarge: TextStyle(fontSize: 16, color: kPlaceholderText),
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kSubtleGray,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: kPlaceholderText),
    labelStyle: TextStyle(color: kSecondaryText),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimarySwatch,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      elevation: 3,
      shadowColor: kAccentBlue.withAlpha(20),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kPrimarySwatch,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: kPrimarySwatch,
      side: BorderSide(color: kPrimarySwatch, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimarySwatch,
    elevation: 2,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: kCardGray,
    selectedItemColor: kPrimarySwatch,
    unselectedItemColor: kSecondaryText,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kPrimarySwatch,
    contentTextStyle: TextStyle(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    elevation: 4,
  ),
);
