import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:flutter_news/view_model/bottom_navbar_provider.dart';
import 'package:flutter_news/utils/routes_name.dart';
import 'package:flutter_news/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavbarState =
        Provider.of<BottomNavbarState>(context, listen: false);

    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return SalomonBottomBar(
        itemShape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            )),
        margin: const EdgeInsets.all(10),
        unselectedItemColor: const Color.fromARGB(255, 122, 122, 122),
        backgroundColor: value.isDarkTheme
            ? DarkTheme.darkThemeData.bottomNavigationBarTheme.backgroundColor
            : LightTheme
                .lightThemeData.bottomNavigationBarTheme.backgroundColor,
        currentIndex: bottomNavbarState.currentIndex,
        onTap: (index) {
          if (bottomNavbarState.currentIndex != index) {
            bottomNavbarState.setIndex(index);
            if (index == 0) {
              Navigator.pushReplacementNamed(context, RoutesName.home);
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, RoutesName.categories);
            }
          }
        },
        items: [
          // Home
          SalomonBottomBarItem(
            selectedColor: value.isDarkTheme
                ? DarkTheme.darkThemeData.bottomNavigationBarTheme
                    .selectedIconTheme?.color
                : LightTheme.lightThemeData.bottomNavigationBarTheme
                    .selectedIconTheme?.color,
            icon: const Icon(Icons.travel_explore, size: 35),
            title: CustomText(
              text: 'HOME',
              textWeight: FontWeight.bold,
              textSize: 18,
            ),
            // Text(
            //   'Hope',
            //   style: value.isDarkTheme
            //       ? DarkTheme
            //           .darkThemeData.bottomNavigationBarTheme.selectedLabelStyle
            //       : LightTheme.lightThemeData.bottomNavigationBarTheme
            //           .selectedLabelStyle,
            // ),
          ),
          // Topics
          SalomonBottomBarItem(
            selectedColor: value.isDarkTheme
                ? DarkTheme.darkThemeData.bottomNavigationBarTheme
                    .selectedIconTheme?.color
                : LightTheme.lightThemeData.bottomNavigationBarTheme
                    .selectedIconTheme?.color,
            icon: const Icon(Icons.table_chart_rounded, size: 40),

            title: const CustomText(
              text: 'TOPICS',
              textSize: 18,
              textWeight: FontWeight.bold,
            ),
            // title: Text(
            //   'Topics',
            //   style: value.isDarkTheme
            //       ? DarkTheme
            //           .darkThemeData.bottomNavigationBarTheme.selectedLabelStyle
            //       : LightTheme.lightThemeData.bottomNavigationBarTheme
            //           .selectedLabelStyle,
            // ),
          ),
        ],
      );
    });
  }
}
