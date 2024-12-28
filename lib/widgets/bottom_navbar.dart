import 'package:flutter/material.dart';
import 'package:flutter_news/View/theme.dart';
import 'package:flutter_news/View/themeprovider.dart';
import 'package:flutter_news/view_model/bottom_navbar_provider.dart';
import 'package:flutter_news/view_model/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavbarState = Provider.of<BottomNavbarState>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SalomonBottomBar(
      backgroundColor: themeProvider.isDarkTheme
          ? DarkTheme.darkThemeData.bottomNavigationBarTheme.backgroundColor
          : LightTheme.lightThemeData.bottomNavigationBarTheme.backgroundColor,
      currentIndex: bottomNavbarState.currentIndex,
      onTap: (index) {
        if (bottomNavbarState.currentIndex != index) {
          bottomNavbarState.setIndex(index);
          if (index == 0) {
            Navigator.pushReplacementNamed(context, RoutesName.Home);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, RoutesName.Categories);
          }
        }
      },
      items: [
        // Home
        SalomonBottomBarItem(
          selectedColor: themeProvider.isDarkTheme
              ? DarkTheme.darkThemeData.bottomNavigationBarTheme
                  .selectedIconTheme?.color
              : LightTheme.lightThemeData.bottomNavigationBarTheme
                  .selectedIconTheme?.color,
          icon: const Icon(Icons.newspaper_rounded, size: 35),
          title: Text(
            'Home',
            style: themeProvider.isDarkTheme
                ? DarkTheme
                    .darkThemeData.bottomNavigationBarTheme.selectedLabelStyle
                : LightTheme
                    .lightThemeData.bottomNavigationBarTheme.selectedLabelStyle,
          ),
        ),
        // Topics
        SalomonBottomBarItem(
          selectedColor: themeProvider.isDarkTheme
              ? DarkTheme.darkThemeData.bottomNavigationBarTheme
                  .selectedIconTheme?.color
              : LightTheme.lightThemeData.bottomNavigationBarTheme
                  .selectedIconTheme?.color,
          icon: const Icon(Icons.view_list_rounded, size: 35),
          title: Text(
            'Topics',
            style: themeProvider.isDarkTheme
                ? DarkTheme
                    .darkThemeData.bottomNavigationBarTheme.selectedLabelStyle
                : LightTheme
                    .lightThemeData.bottomNavigationBarTheme.selectedLabelStyle,
          ),
        ),
      ],
    );
  }
}
