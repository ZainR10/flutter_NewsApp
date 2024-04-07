import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static Color lightFontColor = Colors.black;

  static Color lightContainerColor = Colors.grey.shade400;
  static const Color lightContainerBorderColor = Colors.grey;

  static final ThemeData lightThemeData = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      //background color
      colorScheme: const ColorScheme.light(background: Colors.white),
      //appbar
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900],
          iconTheme: const IconThemeData(color: Colors.white, size: 35),
          titleTextStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
            fontSize: 25,
            fontWeight: FontWeight.w900,
          )),
      //bottombar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.josefinSans(
          textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.blue[900],
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
      ),
      fontFamily: 'josefin Sans');
}

//darktheme
class DarkTheme {
  static Color darkFontColor = Colors.white;
  static Color darkContainerColor = Colors.black54;
  static const Color darkContainerBorderColor = Colors.grey;

  static final ThemeData darkThemeData = ThemeData(
      //background color
      scaffoldBackgroundColor: Colors.blueGrey.shade900,

      //appbar
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900],
          iconTheme: const IconThemeData(color: Colors.white, size: 35),
          titleTextStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
            fontSize: 25,
            fontWeight: FontWeight.w900,
          )),
      //bottombar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.josefinSans(
          textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.blue[900],
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
      ),
      fontFamily: 'josefin Sans');
}
