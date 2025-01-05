import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:provider/provider.dart';

class CustomContainer extends StatefulWidget {
  final Widget child;
  const CustomContainer({required this.child, super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return Container(
        decoration: BoxDecoration(
          // Container border color
          border: Border.all(
            color: value.isDarkTheme
                ? DarkTheme.darkContainerBorderColor
                : LightTheme.lightContainerBorderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          // Gradient color based on theme
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: value.isDarkTheme
                ? [
                    const Color.fromARGB(255, 3, 32, 83),
                    Colors.black,
                  ]
                : [
                    const Color.fromARGB(255, 3, 32, 83),
                    Colors.white,
                  ],
          ),
        ),
        child: widget.child,
      );
    });
  }
}
