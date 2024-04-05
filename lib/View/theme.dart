import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  colorScheme: const ColorScheme.light(background: Colors.white),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[900],
      iconTheme: const IconThemeData(color: Colors.white, size: 35),
      titleTextStyle: GoogleFonts.cormorantInfant(
        textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
        fontSize: 25,
        fontWeight: FontWeight.w900,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.blue[900],
      selectedItemColor: Colors.amber,
      selectedIconTheme: const IconThemeData(color: Colors.white)),
);
