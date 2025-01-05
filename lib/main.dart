import 'package:flutter/material.dart';
import 'package:flutter_news/View/splash_screen.dart';
import 'package:flutter_news/view_model/news_channel_provider.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:flutter_news/view_model/bottom_navbar_provider.dart';
import 'package:flutter_news/utils/routes.dart';
import 'package:flutter_news/utils/routes_name.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => BottomNavbarState()),
          ChangeNotifierProvider(create: (_) => ChannelProvider()),
        ],
        child: const MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
          // home: SplashScreen(),
        ));
  }
}
