import 'package:flutter/material.dart';
import 'package:flutter_news/View/categories.dart';
import 'package:flutter_news/View/home_screen.dart';
import 'package:flutter_news/View/news_detail_screen.dart';
import 'package:flutter_news/View/splash_screen.dart';
import 'package:flutter_news/view_model/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.SplashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.Home:
        return MaterialPageRoute(builder: (context) => const Home());

      case RoutesName.Categories:
        return MaterialPageRoute(builder: (context) => const Categories());

      case RoutesName.NewsDetail:
        // Retrieve arguments passed to NewsDetail screen
        final args = settings.arguments;
        if (args is NewsDetailArguments) {
          return MaterialPageRoute(
            builder: (context) => NewsDetail(
              newsImage: args.newsImage,
              newsTitle: args.newsTitle,
              newsDate: args.newsDate,
              author: args.author,
              description: args.description,
              content: args.content,
              source: args.source,
            ),
          );
        }
        // If args is not of type NewsDetailArguments, return an error route
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  // Error route for handling unknown routes
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text('Something went wrong')),
      ),
    );
  }
}

// Class to hold arguments for NewsDetail screen
class NewsDetailArguments {
  final String newsImage;
  final String newsTitle;
  final String newsDate;
  final String author;
  final String description;
  final String content;
  final String source;

  NewsDetailArguments({
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  });
}
