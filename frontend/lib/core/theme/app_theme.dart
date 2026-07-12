import 'package:flutter/material.dart';

/// Centralized theme configuration for the application.
class AppTheme {
  /// The light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFE8F1F5), // Light sky-blue neobrutalist backdrop
      primaryColor: const Color(0xFF0056D2),
      cardColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0056D2),
        secondary: Color(0xFF00BFA5),
        error: Color(0xFFD32F2F),
        background: Color(0xFFE8F1F5),
        surface: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontFamily: 'Outfit'),
        bodyMedium: TextStyle(color: Colors.black87, fontFamily: 'Outfit'),
      ),
    );
  }

  /// The dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A0C16), // Premium dark space backdrop
      primaryColor: const Color(0xFF00E5FF),
      cardColor: const Color(0xFF121625), // Cyber neobrutalist card surface
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00E5FF), // Cyber cyan
        secondary: Color(0xFF00BFA5),
        error: Color(0xFFD32F2F),
        background: Color(0xFF0A0C16),
        surface: Color(0xFF121625),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Outfit'),
        bodyMedium: TextStyle(color: Colors.white70, fontFamily: 'Outfit'),
      ),
    );
  }
}
