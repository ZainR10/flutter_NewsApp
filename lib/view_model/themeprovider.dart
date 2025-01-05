import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData =
      DarkTheme.darkThemeData; // Align with the default theme
  bool _isDarkTheme = true;

  ThemeData get theme => _themeData;
  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _themeData =
        _isDarkTheme ? DarkTheme.darkThemeData : LightTheme.lightThemeData;
    print("Theme toggled. New theme is ${_isDarkTheme ? 'Dark' : 'Light'}");
    notifyListeners();
  }
}
