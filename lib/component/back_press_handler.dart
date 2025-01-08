import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/view_model/bottom_navbar_provider.dart';
import 'package:provider/provider.dart';

class BackPressHandler extends StatelessWidget {
  final Widget child;
  final bool shouldExitApp;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final VoidCallback? onBackPressed;

  static DateTime? lastBackPressed; // Retain across builds

  const BackPressHandler({
    super.key,
    required this.child,
    this.shouldExitApp = true,
    this.scaffoldMessengerKey,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavbarState =
        Provider.of<BottomNavbarState>(context, listen: false);

    return PopScope(
      canPop: false, // Prevent automatic pop by Flutter
      onPopInvoked: (didPop) async {
        // Handle back navigation when not exiting the app
        if (!shouldExitApp) {
          if (onBackPressed != null) {
            onBackPressed!();
          } else {
            Navigator.of(context).pop();
          }

          if (bottomNavbarState.currentIndex > 0) {
            bottomNavbarState.setIndex(bottomNavbarState.currentIndex - 1);
          }

          return; // Do not exit the app
        }

        // Handle app exit
        final now = DateTime.now();
        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
          lastBackPressed = now;

          scaffoldMessengerKey?.currentState?.showSnackBar(
            const SnackBar(
              showCloseIcon: true,
              clipBehavior: Clip.hardEdge,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              dismissDirection: DismissDirection.horizontal,
              animation: kAlwaysDismissedAnimation,
              content: Text('Press again to exit'),
              duration: Duration(seconds: 10),
            ),
          );

          return; // Do not exit yet
        }
        // Allow app to exit
        SystemNavigator.pop();
        return;
      },
      child: child,
    );
  }
}
