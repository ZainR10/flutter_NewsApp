import 'package:flutter/material.dart';
import 'package:flutter_news/View/theme.dart';

import 'package:flutter_news/view_model/routes.dart';
import 'package:flutter_news/view_model/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.Home,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
