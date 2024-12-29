// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/component/navigation_button.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
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
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: themeProvider.isDarkTheme
                    ? [
                        const Color.fromARGB(255, 47, 65, 97),
                        Colors.black,
                      ]
                    : [
                        Colors.white,
                        const Color.fromARGB(255, 3, 32, 83),
                      ],
              ),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              NavigationButton(
                icon: Icons.arrow_back,
                onpressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    //title
                    Text(
                      widget.newsTitle,
                      style: GoogleFonts.actor(
                        textStyle: TextStyle(
                            letterSpacing: 0,
                            color: themeProvider.isDarkTheme
                                ? DarkTheme.darkFontColor
                                : LightTheme.lightFontColor),
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: widget.newsImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const SpinKitDancingSquare(
                          color: Colors.amber,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.api,
                          color: Colors.red,
                        ),
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
                          style: GoogleFonts.actor(
                            textStyle: TextStyle(
                              color: themeProvider.isDarkTheme
                                  ? DarkTheme.darkFontColor
                                  : LightTheme.lightFontColor,
                              letterSpacing: 1,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        //date
                        Text(
                          widget.newsDate,
                          style: GoogleFonts.actor(
                            textStyle: TextStyle(
                                letterSpacing: 1,
                                color: themeProvider.isDarkTheme
                                    ? DarkTheme.darkFontColor
                                    : LightTheme.lightFontColor),
                            fontSize: 14,
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
                      style: GoogleFonts.actor(
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
                    //description

                    Text(
                      widget.description,
                      style: GoogleFonts.actor(
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
              ),
            ]),
          ),
        ));
  }
}
