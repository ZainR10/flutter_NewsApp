import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:flutter_news/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class InternetWidget extends StatefulWidget {
  final String msg;
  const InternetWidget({required this.msg, super.key});

  @override
  State<InternetWidget> createState() => _InternetWidgetState();
}

class _InternetWidgetState extends State<InternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 50,
            color: value.isDarkTheme
                ? DarkTheme.darkFontColor
                : LightTheme.lightFontColor,
          ),
          Center(
              child: CustomText(
            text: widget.msg, // Displays the error message,

            textSize: 24,
            textWeight: FontWeight.bold,
          )),
        ],
      );
    });
  }
}
