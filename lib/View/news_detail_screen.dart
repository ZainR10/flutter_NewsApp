import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/View/theme.dart';
import 'package:flutter_news/View/themeprovider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewsDetail extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetail(
      {super.key,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.source});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: themeProvider.isDarkTheme
          ? DarkTheme.darkThemeData.scaffoldBackgroundColor
          : LightTheme.lightThemeData.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Center(
          child: Text('Full Article'),
        ),
        leading: const BackButton(),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: height * .35,
            child: ClipRRect(
              // borderRadius: const BorderRadius.only(
              //   topRight: Radius.circular(20),
              //   topLeft: Radius.circular(20),
              //   bottomLeft: Radius.circular(0),
              // ),
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: widget.newsImage,
                placeholder: (context, url) => const Center(
                  child: SpinKitDancingSquare(
                    color: Colors.amber,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.api,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Container(
            height: height * .8,
            margin: EdgeInsets.only(top: height * .35),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
              color: themeProvider.isDarkTheme
                  ? DarkTheme.darkContainerColor
                  : LightTheme.lightContainerColor,
              // borderRadius: const BorderRadius.only(
              //     topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: ListView(
              children: [
                //title
                Text(
                  widget.newsTitle,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        letterSpacing: 0,
                        color: themeProvider.isDarkTheme
                            ? DarkTheme.darkFontColor
                            : LightTheme.lightFontColor),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //news source
                    Text(
                      widget.source,
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                          color: themeProvider.isDarkTheme
                              ? DarkTheme.darkFontColor
                              : LightTheme.lightFontColor,
                          letterSpacing: 1,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    //date
                    Text(
                      widget.newsDate,
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            letterSpacing: 1,
                            color: themeProvider.isDarkTheme
                                ? DarkTheme.darkFontColor
                                : LightTheme.lightFontColor),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  widget.content,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        letterSpacing: 1,
                        color: themeProvider.isDarkTheme
                            ? DarkTheme.darkFontColor
                            : LightTheme.lightFontColor),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  widget.description,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        letterSpacing: 1,
                        color: themeProvider.isDarkTheme
                            ? DarkTheme.darkFontColor
                            : LightTheme.lightFontColor),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
