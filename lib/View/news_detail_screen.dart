// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/component/navigation_button.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:flutter_news/widgets/text_widget.dart';
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
                    CustomText(
                      text: widget.newsTitle,
                      textSize: 30,
                      textWeight: FontWeight.w900,
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
                        const Icon(
                          Icons.pause_circle_outline,
                          size: 45,
                          color: Colors.white,
                        ),

                        //news source
                        CustomText(
                          text: widget.source,
                          textSize: 16,
                          textWeight: FontWeight.w900,
                          textLetterSpace: 1,
                        ),

                        //date
                        CustomText(
                          text: widget.newsDate,
                          textSize: 16,
                          textWeight: FontWeight.w900,
                          textLetterSpace: 1,
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      height: height * .01,
                    ),
                    CustomText(
                      text: widget.content,
                      textSize: 25,
                      textWeight: FontWeight.w900,
                      textLetterSpace: 1,
                    ),

                    SizedBox(
                      height: height * .02,
                    ),
                    //description

                    CustomText(
                      text: widget.description,
                      textSize: 25,
                      textWeight: FontWeight.w900,
                      textLetterSpace: 1,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
