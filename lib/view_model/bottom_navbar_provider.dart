import 'package:flutter/material.dart';
import 'package:flutter_news/utils/routes_name.dart';

class BottomNavbarState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void navigateToIndex(BuildContext context, int index) {
    _currentIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);
        break;
      case 1:
        Navigator.pushNamed(context, RoutesName.categories);
        break;
    }
  }
}
