import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF69B4); // Hot Pink
  static const Color secondaryColor = Color(0xFFFFC1CC); // Bubblegum Pink
  static const Color accentColor = Color(0xFFFF1493); // Deep Pink
  static const Color backgroundColor = Color(0xFFFFF0F5); // Lavender Blush
  static const Color textColor = Color(0xFF4A4A4A);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.pacifico(
          fontSize: 48,
          color: accentColor,
        ),
        displayMedium: GoogleFonts.pacifico(
          fontSize: 32,
          color: primaryColor,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: 18,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 16,
          color: textColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
