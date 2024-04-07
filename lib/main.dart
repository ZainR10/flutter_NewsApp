import 'package:flutter/material.dart';
import 'package:flutter_news/View/theme.dart';
import 'package:flutter_news/View/themeprovider.dart';

import 'package:flutter_news/view_model/routes.dart';
import 'package:flutter_news/view_model/routes_name.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // bool isDarkTheme = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: themeProvider.getTheme(),
        // isDarkTheme ? DarkTheme.darkThemeData : LightTheme.lightThemeData,
        // theme: LightTheme.lightThemeData, // Set the default theme to light theme
        // darkTheme: DarkTheme.darkThemeData, // Set the dark theme
        // themeMode: ThemeMode.dark,
        // Uncomment this line if you want to start the app in dark mode by default
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.Home,
        onGenerateRoute: Routes.generateRoute,
      );
    });
  }
}
