// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/news_channel_provider.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:flutter_news/model/news_channel_headlines_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_news/utils/routes.dart';
import 'package:flutter_news/utils/routes_name.dart';
import 'package:flutter_news/widgets/appbar.dart';
import 'package:flutter_news/widgets/bottom_navbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

//news channels name stored as enum because these are constant values
enum NewsFilterList {
  aryNews,
  alJazeera,
  bbcNews,
}

class _HomeState extends State<Home> {
  NewsViewModel newsViewModel = NewsViewModel();
//default channel variable
  NewsFilterList? selectedMenu;
//default channel and parameter for filtering and fetching desired channel from api
//it is also used in api as a parameter and in news_repository,future builder and in news view_model
  String channelName = 'bbc-news';
  final Format = DateFormat('yMMMMd');

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final channelProvider = Provider.of<ChannelProvider>(context);
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(0, 49),
        child: ReuseableAppbar(),
      ),
      backgroundColor: themeProvider.isDarkTheme
          ? DarkTheme.darkThemeData.scaffoldBackgroundColor
          : LightTheme.lightThemeData.scaffoldBackgroundColor,
      bottomNavigationBar: const BottomNavbar(),
      body: SafeArea(
        child: FutureBuilder<NewsChannelHeadlinesModel>(
          future: newsViewModel
              .fetchNewsChannelHeadlinesApi(channelProvider.channelName),
          builder: (BuildContext context,
              AsyncSnapshot<NewsChannelHeadlinesModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitDancingSquare(
                  size: 50,
                  color: Colors.amber,
                ),
              );
            } else {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.articles?.length ?? 0,
                    itemBuilder: (context, index) {
                      //created this var to only get formated date
                      String? publishedDate =
                          snapshot.data?.articles?[index].publishedAt;
                      DateTime dateTime = DateTime.parse(publishedDate!);
                      String formattedDate =
                          DateFormat.yMMMd().format(dateTime);
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        //to naviget for full news.
                        child: InkWell(onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.newsDetail,
                            arguments: NewsDetailArguments(
                              newsImage: snapshot
                                  .data!.articles![index].urlToImage
                                  .toString(),
                              newsTitle: snapshot.data!.articles![index].title
                                  .toString(),
                              newsDate: formattedDate,
                              author: snapshot.data!.articles![index].author
                                  .toString(),
                              description: snapshot
                                  .data!.articles![index].description
                                  .toString(),
                              content: snapshot.data!.articles![index].content
                                  .toString(),
                              source: snapshot
                                  .data!.articles![index].source!.name
                                  .toString(),
                            ),
                          );
                        },
                            //main container for holding all content
                            child: Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) {
                            return Container(
                              decoration: BoxDecoration(
                                // Container border color
                                border: Border.all(
                                  color: themeProvider.isDarkTheme
                                      ? DarkTheme.darkContainerBorderColor
                                      : LightTheme.lightContainerBorderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                // Gradient color based on theme
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: themeProvider.isDarkTheme
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.zero,
                                        bottomRight: Radius.zero,
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SpinKitDancingSquare(
                                        color: Colors.amber,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.api,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    //******title*****
                                    child: Text(
                                      maxLines: 3,
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      style: GoogleFonts.actor(
                                        textStyle: TextStyle(
                                            letterSpacing: 2,
                                            color: themeProvider.isDarkTheme
                                                ? DarkTheme.darkFontColor
                                                : LightTheme.lightFontColor),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  //****date******
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                          child: Text(
                                            'Published at:',
                                            style: GoogleFonts.actor(
                                              textStyle: TextStyle(
                                                  letterSpacing: 0,
                                                  color: themeProvider
                                                          .isDarkTheme
                                                      ? DarkTheme.darkFontColor
                                                      : LightTheme
                                                          .lightFontColor),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                          child: Text(
                                            Format.format(dateTime),
                                            style: GoogleFonts.actor(
                                              textStyle: TextStyle(
                                                  letterSpacing: 0,
                                                  color: themeProvider
                                                          .isDarkTheme
                                                      ? DarkTheme.darkFontColor
                                                      : LightTheme
                                                          .lightFontColor),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  //*****auther ****

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    child: Text(
                                      snapshot.data!.articles![index].author
                                          .toString(),
                                      style: GoogleFonts.actor(
                                        textStyle: TextStyle(
                                          color: themeProvider.isDarkTheme
                                              ? DarkTheme.darkFontColor
                                              : LightTheme.lightFontColor,
                                          letterSpacing: 0,
                                        ),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Use themeProvider as needed
                            );
                          },
                        )),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
