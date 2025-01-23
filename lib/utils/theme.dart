import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
      bodyMedium: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.grey[200],
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
      bodyMedium: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[300]),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[850],
      shadowColor: Colors.black26,
    ),
  );
}
