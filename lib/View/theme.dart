import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static Color lightFontColor = Colors.black;

  static Color lightContainerColor = Colors.grey.shade400;
  static const Color lightContainerBorderColor = Colors.grey;

  static final ThemeData lightThemeData = ThemeData(
      popupMenuTheme: PopupMenuThemeData(
          color: Colors.grey.shade400,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          textStyle: GoogleFonts.josefinSans(
              textStyle: const TextStyle(letterSpacing: 1, color: Colors.black),
              fontSize: 15,
              fontWeight: FontWeight.w900)),

      //background color
      scaffoldBackgroundColor: Colors.white,
      dividerColor: Colors.black,
      //divider
      dividerTheme: const DividerThemeData(
          color: Colors.black,
          endIndent: 8,
          indent: 8,
          thickness: 2,
          space: 10),
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
      popupMenuTheme: PopupMenuThemeData(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          color: Colors.blueGrey.shade400,
          textStyle: GoogleFonts.josefinSans(
              textStyle: const TextStyle(letterSpacing: 1, color: Colors.white),
              fontSize: 15,
              fontWeight: FontWeight.w900)),
      //background color
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
//divider
      dividerColor: Colors.white,
      dividerTheme: const DividerThemeData(
        // color: Colors.white,
        endIndent: 8,
        indent: 8,
        thickness: 2,
      ),
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
