import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? textSize;
  final FontWeight? textWeight;
  final Color? textColor;
  final double? textLetterSpace;
  final int? textMaxLines;
  final TextOverflow? textOverflow;

  const CustomText(
      {this.textSize,
      this.textOverflow,
      this.textLetterSpace,
      this.textWeight,
      this.textColor,
      this.textMaxLines,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return Text(
        text,
        maxLines: textMaxLines,
        style: GoogleFonts.actor(
          textStyle: TextStyle(
              overflow: textOverflow,
              letterSpacing: textLetterSpace,
              color: value.isDarkTheme
                  ? DarkTheme.darkFontColor
                  : LightTheme.lightFontColor),
          fontSize: textSize,
          fontWeight: textWeight,
        ),
      );
    });
  }
}
