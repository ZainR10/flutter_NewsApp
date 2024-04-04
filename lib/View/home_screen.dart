import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_news/model/news_channel_headlines_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_news/view_model/routes.dart';
import 'package:flutter_news/view_model/routes_name.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
  int _currentIndex = 0;
  NewsViewModel newsViewModel = NewsViewModel();
//default channel variable
  NewsFilterList? selectedMenu;
//default channel and parameter for filtering and fetching desired channel from api
//it is also used in api as a parameter and in news_repository,future builder and in news view_model
  String channelName = 'bbc-news';
  final Format = DateFormat('yMMMMd');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Top News',
          style: GoogleFonts.cormorantInfant(
            textStyle: const TextStyle(letterSpacing: 3, color: Colors.white),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<NewsFilterList>(
              iconColor: Colors.white,
              onSelected: (NewsFilterList item) {
                if (NewsFilterList.alJazeera.name == item.name) {
                  channelName = '"al-jazeera-english';
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
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.alJazeera,
                      child: Text('Al Jazeera'),
                    ),
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.bbcNews,
                      child: Text('BBC News'),
                    ),
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.aryNews,
                      child: Text('Ary News'),
                    )
                  ]),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.blue[900],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index
            // Navigate to the respective screens based on the selected index
            if (_currentIndex == 1) {
              Navigator.pushNamed(context, RoutesName.Categories);
            } else if (_currentIndex == 2) {
              Navigator.pushNamed(context, RoutesName.Home);
            }
          });
        }, // Add currentIndex if needed

        items: [
          // Home
          SalomonBottomBarItem(
            selectedColor: Colors.amber,
            icon: const Icon(
              Icons.newspaper_rounded,
              size: 35,
            ),
            title: Text(
              'Home',
              style: GoogleFonts.cormorantInfant(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          // Topics
          SalomonBottomBarItem(
            selectedColor: Colors.amber,
            icon: const Icon(
              Icons.view_list_rounded,
              size: 35,
            ),
            title: Text(
              'Topics',
              style: GoogleFonts.cormorantInfant(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          // Settings
          SalomonBottomBarItem(
            selectedColor: Colors.amber,
            icon: const Icon(
              Icons.settings_outlined,
              size: 35,
            ),
            title: Text(
              'Settings',
              style: GoogleFonts.cormorantInfant(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: FutureBuilder<NewsChannelHeadlinesModel>(
          future: newsViewModel.fetchNewsChannelHeadlinesApi(channelName),
          builder: (BuildContext context,
              AsyncSnapshot<NewsChannelHeadlinesModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitDancingSquare(
                  size: 20,
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
                        padding: const EdgeInsets.all(15),
                        //to naviget for full news.
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.NewsDetail,
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
                          child: Container(
                            height: MediaQuery.of(context).size.height * .80,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[400],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  //image holder and decorator
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  //******title*****
                                  child: Text(
                                    maxLines: 3,
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    style: GoogleFonts.cormorantInfant(
                                      textStyle: const TextStyle(
                                          letterSpacing: 2,
                                          color: Colors.black),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                //****date******
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 20),
                                      child: Text(
                                        'Published at:',
                                        style: GoogleFonts.cormorantInfant(
                                          textStyle: const TextStyle(
                                              letterSpacing: 0,
                                              color: Colors.black),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 20),
                                      child: Text(
                                        Format.format(dateTime),
                                        style: GoogleFonts.cormorantInfant(
                                          textStyle: const TextStyle(
                                              letterSpacing: 0,
                                              color: Colors.black),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                //*****auther ****
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  child: Text(
                                    snapshot.data!.articles![index].author
                                        .toString(),
                                    style: GoogleFonts.cormorantInfant(
                                      textStyle: const TextStyle(
                                        letterSpacing: 0,
                                      ),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
