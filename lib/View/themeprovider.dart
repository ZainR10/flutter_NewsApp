import 'package:flutter/material.dart';
import 'package:flutter_news/View/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = LightTheme.lightThemeData;
  bool _isDarkTheme = true;

  ThemeData getTheme() => _themeData;
  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _themeData =
        _isDarkTheme ? DarkTheme.darkThemeData : LightTheme.lightThemeData;
    notifyListeners();
  }
}
