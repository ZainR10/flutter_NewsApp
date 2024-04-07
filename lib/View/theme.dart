import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  // static Color lightbackgroundColor = Colors.white;
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
  // static Color darkbackgroundColor = Colors.black;
  static Color darkContainerColor = Colors.black;
  static const Color darkContainerBorderColor = Colors.black;

  static final ThemeData darkThemeData = ThemeData(
      scaffoldBackgroundColor: Colors.black,

      //background color
      colorScheme: ColorScheme.light(background: Colors.black),
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
