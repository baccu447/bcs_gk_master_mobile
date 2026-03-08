import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData premiumDarkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0A0A12),
    primaryColor: const Color(0xFFF0C14B),
    cardColor: const Color(0xFF161B22),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF0C14B),
      surface: Color(0xFF161B22),
      background: Color(0xFF0A0A12),
      secondary: Color(0xFF10B981), // Success/Correct
      error: Color(0xFFEF4444), // Error/Incorrect
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF161B22),
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF161B22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
