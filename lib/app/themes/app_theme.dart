import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFF0000),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFFF0000),
      secondary: Colors.red.shade400,
      surface: Colors.white,
      error: Colors.red,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFF0000),
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFFF0000),
      secondary: Colors.red.shade400,
      surface: const Color(0xFF1E1E1E),
      error: Colors.red,
    ),
  );
}
