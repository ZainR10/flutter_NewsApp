import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/model/news_channel_headlines_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum NewsFilterList {
  aryNews,
  alJazeera,
  bbcNews,
}

class _HomeState extends State<Home> {
  NewsViewModel newsViewModel = NewsViewModel();

  NewsFilterList? selectedMenu;

  String channelName = 'al-jazeera-english';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top News',
          style: GoogleFonts.cormorantInfant(
            textStyle: const TextStyle(letterSpacing: 3, color: Colors.black),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<NewsFilterList>(
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
                      String? publishedDate =
                          snapshot.data?.articles?[index].publishedAt;
                      DateTime dateTime = DateTime.parse(publishedDate!);
                      String formattedDate =
                          DateFormat.yMMMd().format(dateTime);
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 110),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.scaleDown,
                                      placeholder: (context, url) =>
                                          const SpinKitDancingSquare(
                                        color: Colors.amber,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  style: GoogleFonts.cormorantInfant(
                                    textStyle: const TextStyle(
                                        letterSpacing: 0, color: Colors.white),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                                            color: Colors.white),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    child: Text(
                                      formattedDate,
                                      style: GoogleFonts.cormorantInfant(
                                        textStyle: const TextStyle(
                                            letterSpacing: 0,
                                            color: Colors.white),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                child: Text(
                                  snapshot.data!.articles![index].author
                                      .toString(),
                                  style: GoogleFonts.cormorantInfant(
                                    textStyle: const TextStyle(
                                        letterSpacing: 0, color: Colors.white),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
