import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/news_channel_provider.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReuseableAppbar extends StatefulWidget {
  const ReuseableAppbar({super.key});

  @override
  State<ReuseableAppbar> createState() => _ReuseableAppbarState();
}

enum NewsFilterList {
  aryNews,
  alJazeera,
  bbcNews,
}

class _ReuseableAppbarState extends State<ReuseableAppbar> {
  NewsFilterList? selectedMenu;
  String channelName = 'bbc-news';
  final dateFormat = DateFormat('yMMMMd');

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final channelProvider =
        Provider.of<ChannelProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme
            ? DarkTheme.darkThemeData.appBarTheme.backgroundColor
            : LightTheme.lightThemeData.appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Breaking New's",
          style: TextStyle(
              color: themeProvider.isDarkTheme
                  ? DarkTheme.darkThemeData.appBarTheme.titleTextStyle?.color
                  : LightTheme.lightThemeData.appBarTheme.titleTextStyle?.color,
              fontSize: themeProvider.isDarkTheme
                  ? DarkTheme.darkThemeData.appBarTheme.titleTextStyle?.fontSize
                  : LightTheme
                      .lightThemeData.appBarTheme.titleTextStyle?.fontSize),
        ),
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: Icon(
              size: 35,
              color: themeProvider.isDarkTheme
                  ? DarkTheme.darkThemeData.appBarTheme.iconTheme?.color
                  : LightTheme.lightThemeData.appBarTheme.iconTheme?.color,
              themeProvider.isDarkTheme
                  ? Icons.nightlight_round_sharp
                  : Icons.wb_sunny_sharp,
            ),
          ),
          PopupMenuButton<NewsFilterList>(
            iconSize: 35,
            position: PopupMenuPosition.under,
            iconColor: themeProvider.isDarkTheme
                ? DarkTheme.darkThemeData.popupMenuTheme.iconColor
                : LightTheme.lightThemeData.popupMenuTheme.iconColor,
            onSelected: (item) {
              channelProvider.updateChannel(_getChannelName(item));
            },
            initialValue: selectedMenu,
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (context) => <PopupMenuEntry<NewsFilterList>>[
              PopupMenuItem(
                value: NewsFilterList.alJazeera,
                child: Text('Al Jazeera',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              PopupMenuItem(
                value: NewsFilterList.bbcNews,
                child: Text('BBC News',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              PopupMenuItem(
                value: NewsFilterList.aryNews,
                child: Text('Ary News',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getChannelName(NewsFilterList item) {
    switch (item) {
      case NewsFilterList.alJazeera:
        return 'al-jazeera-english';
      case NewsFilterList.aryNews:
        return 'ary-news';
      case NewsFilterList.bbcNews:
      default:
        return 'bbc-news';
    }
  }
}
