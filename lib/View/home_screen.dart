// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/component/back_press_handler.dart';
import 'package:flutter_news/component/custom_container.dart';
import 'package:flutter_news/main.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/news_channel_provider.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:flutter_news/model/news_channel_headlines_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_news/utils/routes.dart';
import 'package:flutter_news/utils/routes_name.dart';
import 'package:flutter_news/widgets/appbar.dart';
import 'package:flutter_news/widgets/bottom_navbar.dart';
import 'package:flutter_news/widgets/internet_widget.dart';
import 'package:flutter_news/widgets/text_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    if (kDebugMode) {
      print("Home widget is rebuilding");
    }
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final channelProvider = Provider.of<ChannelProvider>(context);
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Consumer<ThemeProvider>(builder: (context, value, child) {
      if (kDebugMode) {
        print("Consumer in Home widget is rebuilding");
      }
      return BackPressHandler(
        shouldExitApp: true,
        scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
        onBackPressed: () {},
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size(0, 49),
            child: ReuseableAppbar(),
          ),
          backgroundColor: value.isDarkTheme
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
                    child: SpinKitHourGlass(
                      size: 50,
                      color: Colors.amber,
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Handle errors

                  return InternetWidget(
                    msg: snapshot.error.toString(),
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
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.newsDetail,
                                    arguments: NewsDetailArguments(
                                      newsImage: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      newsTitle: snapshot
                                          .data!.articles![index].title
                                          .toString(),
                                      newsDate: formattedDate,
                                      author: snapshot
                                          .data!.articles![index].author
                                          .toString(),
                                      description: snapshot
                                          .data!.articles![index].description
                                          .toString(),
                                      content: snapshot
                                          .data!.articles![index].content
                                          .toString(),
                                      source: snapshot
                                          .data!.articles![index].source!.name
                                          .toString(),
                                    ),
                                  );
                                },
                                //main container for holding all content
                                child: CustomContainer(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              const SpinKitHourGlass(
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
                                          child: CustomText(
                                            text: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            textMaxLines: 3,
                                            textLetterSpace: 2,
                                            textSize: 30,
                                            textWeight: FontWeight.bold,
                                          )),
                                      const SizedBox(height: 10),
                                      //****date******
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 20),
                                                child: CustomText(
                                                  text: 'Published at:',
                                                  textLetterSpace: 0,
                                                  textSize: 18,
                                                  textWeight: FontWeight.bold,
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 0),
                                              child: CustomText(
                                                text: Format.format(dateTime),
                                                textLetterSpace: 0,
                                                textSize: 18,
                                                textWeight: FontWeight.bold,
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
                                        child: CustomText(
                                          text: snapshot
                                              .data!.articles![index].author
                                              .toString(),
                                          textLetterSpace: 0,
                                          textSize: 20,
                                          textWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Use themeProvider as needed
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
        ),
      );
    });
  }
}
