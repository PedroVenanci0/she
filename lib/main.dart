import 'package:encontro_perfeito/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/question_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'O Encontro Perfeito',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF69B4), // Hot Pink
          primary: const Color(0xFFFF1493),
          secondary: const Color(0xFFFFB6C1),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.pacifico(
            fontSize: 42, 
            color: const Color(0xFF880E4F)
          ),
          bodyLarge: GoogleFonts.nunito(
            fontSize: 18, 
            color: const Color(0xFF4A4A4A)
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
