import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: TextTheme(
    titleSmall: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 14, color: const Color.fromRGBO(56, 182, 255, 1.0)),
    titleMedium: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
    titleLarge: GoogleFonts.anton(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    bodySmall: GoogleFonts.mavenPro(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
    bodyMedium: GoogleFonts.mavenPro(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
    bodyLarge: GoogleFonts.mavenPro(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
  ),
  colorScheme: const ColorScheme.light(
    background: Colors.white,
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
    textTheme: TextTheme(
    titleSmall: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 14, color: const Color.fromRGBO(56, 182, 255, 1.0)),
    titleMedium: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[400]),
    titleLarge: GoogleFonts.anton(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    bodySmall: GoogleFonts.mavenPro(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey[350]),
    bodyMedium: GoogleFonts.mavenPro(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey[350]),
    bodyLarge: GoogleFonts.mavenPro(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900
  )
);