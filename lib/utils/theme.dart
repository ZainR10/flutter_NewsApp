import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static Color lightFontColor = Colors.black;

  static Color lightContainerColor = Colors.grey.shade400;
  static const Color lightContainerBorderColor = Colors.black;

  static final ThemeData lightThemeData = ThemeData(
      popupMenuTheme: PopupMenuThemeData(
          iconSize: 50,
          color: Colors.grey.shade400,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          textStyle: GoogleFonts.actor(
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
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black, size: 50),
          titleTextStyle: GoogleFonts.actor(
            textStyle: const TextStyle(letterSpacing: 3, color: Colors.black),
            fontSize: 30,
            fontWeight: FontWeight.w900,
          )),
      //bottombar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.actor(
          textStyle: const TextStyle(letterSpacing: 3, color: Colors.black),
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Colors.black),
      ),
      fontFamily: 'Actor');
}

//darktheme
class DarkTheme {
  static Color darkFontColor = Colors.white;
  static Color darkContainerColor = Colors.black54;
  static const Color darkContainerBorderColor = Colors.white;

  static final ThemeData darkThemeData = ThemeData(
      popupMenuTheme: PopupMenuThemeData(
          iconSize: 50,
          iconColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          color: Colors.black54,
          textStyle: GoogleFonts.actor(
              textStyle: const TextStyle(letterSpacing: 1, color: Colors.white),
              fontSize: 15,
              fontWeight: FontWeight.w900)),
      //background color
      scaffoldBackgroundColor: const Color.fromARGB(255, 47, 65, 97),
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
          // backgroundColor: Colors.blue[900],
          backgroundColor: const Color.fromARGB(255, 47, 65, 97),
          iconTheme: const IconThemeData(color: Colors.white, size: 50),
          titleTextStyle: GoogleFonts.actor(
            textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
            fontSize: 30,
            fontWeight: FontWeight.w900,
          )),
      //bottombar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.actor(
          textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: const Color.fromARGB(255, 47, 65, 97),
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
      ),
      fontFamily: 'Actor');
}
