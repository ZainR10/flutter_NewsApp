import 'package:flutter/material.dart';
import 'package:flutter_news/View/theme.dart';
import 'package:flutter_news/View/themeprovider.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReuseableAppbar extends StatefulWidget {
  const ReuseableAppbar({super.key});

  @override
  State<ReuseableAppbar> createState() => __ReuseableAppbarState();
}

//news channels name stored as enum because these are constant values
enum NewsFilterList {
  aryNews,
  alJazeera,
  bbcNews,
}

@override
class __ReuseableAppbarState extends State<ReuseableAppbar> {
  NewsViewModel newsViewModel = NewsViewModel();
//default channel variable
  NewsFilterList? selectedMenu;
//default channel and parameter for filtering and fetching desired channel from api
//it is also used in api as a parameter and in news_repository,future builder and in news view_model
  String channelName = 'bbc-news';
  final Format = DateFormat('yMMMMd');
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Breaking New's",
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                icon: Icon(
                  themeProvider.isDarkTheme
                      ? Icons.nightlight_round_sharp
                      : Icons.wb_sunny_sharp,
                ),
              );
            },
          ),
          PopupMenuButton<NewsFilterList>(
              // offset: Offset(0.0, appBarHeight),
              onSelected: (NewsFilterList item) {
                if (NewsFilterList.alJazeera.name == item.name) {
                  channelName = 'al-jazeera-english';
                }
                if (NewsFilterList.aryNews.name == item.name) {
                  channelName = 'ary-news';
                }
                if (NewsFilterList.bbcNews.name == item.name) {
                  channelName = 'bbc-news';
                }
                //changes news channel  on selection
                setState(() {
                  selectedMenu = item;
                });
              },
              initialValue: selectedMenu,
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<NewsFilterList>>[
                    PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.alJazeera,
                      child: Text(
                        'Al Jazeera',
                        style: themeProvider.isDarkTheme
                            ? DarkTheme.darkThemeData.popupMenuTheme.textStyle
                            : LightTheme
                                .lightThemeData.popupMenuTheme.textStyle,
                      ),
                    ),
                    PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.bbcNews,
                      child: Text('BBC News',
                          style: themeProvider.isDarkTheme
                              ? DarkTheme.darkThemeData.popupMenuTheme.textStyle
                              : LightTheme
                                  .lightThemeData.popupMenuTheme.textStyle),
                    ),
                    PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.aryNews,
                      child: Text('Ary News',
                          style: themeProvider.isDarkTheme
                              ? DarkTheme.darkThemeData.popupMenuTheme.textStyle
                              : LightTheme
                                  .lightThemeData.popupMenuTheme.textStyle),
                    )
                  ]),
        ],
      ),
    );
  }
}
