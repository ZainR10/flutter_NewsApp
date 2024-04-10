import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeProvider.getTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.Home,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
