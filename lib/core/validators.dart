// Helper functions for input validation (e.g., email, password)

class AppValidators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.contains('@')) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password too short';
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final e164 = RegExp(r'^\+[1-9]\d{1,14}\$');
    if (!e164.hasMatch(value)) {
      return 'Enter phone in +[country][number] format (e.g. +919876543210)';
    }
    return null;
  }
}
