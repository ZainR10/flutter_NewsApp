import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/View/theme.dart';

import 'package:flutter_news/model/news_categories_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_news/view_model/routes.dart';
import 'package:flutter_news/view_model/routes_name.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _currentIndex = 1;
  NewsViewModel newsViewModel = NewsViewModel();

  final Format = DateFormat('yMMMMd');
  String categoryName = 'general';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
    'Politics'
  ];
  @override
  void initState() {
    super.initState();
    // Set the default category to "General" when the widget initializes
    categoryName = 'General';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text("New's Categories")),
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: themeData.bottomNavigationBarTheme.backgroundColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.pushNamed(context, RoutesName.Home);
            } else if (_currentIndex == 2) {
              Navigator.pushNamed(context, RoutesName.Home);
            }
          });
        },
        items: [
          //home
          SalomonBottomBarItem(
            selectedColor:
                themeData.bottomNavigationBarTheme.selectedIconTheme?.color,
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
          //topics
          SalomonBottomBarItem(
            selectedColor:
                themeData.bottomNavigationBarTheme.selectedIconTheme?.color,
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
          //settings
          SalomonBottomBarItem(
            selectedColor:
                themeData.bottomNavigationBarTheme.selectedIconTheme?.color,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        categoryName = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: categoryName == categoriesList[index]
                                  ? Colors.lightBlue.shade700
                                  : Colors.lightBlueAccent[200],
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                categoriesList[index].toString(),
                                style: GoogleFonts.cormorantInfant(
                                  textStyle: const TextStyle(
                                    letterSpacing: 1,
                                  ),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: FutureBuilder<NewsCategoriesModel>(
              future: newsViewModel.fetchNewsCategoriesApi(categoryName),
              builder: (BuildContext context,
                  AsyncSnapshot<NewsCategoriesModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitDancingSquare(
                      size: 20,
                      color: Colors.amber,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.articles?.length,
                    itemBuilder: (context, index) {
                      //created this var to only get formated date
                      String? publishedDate =
                          snapshot.data?.articles?[index].publishedAt;
                      DateTime dateTime = DateTime.parse(publishedDate!);
                      String formattedDate =
                          DateFormat.yMMMd().format(dateTime);
                      //this padding is for gap in between news rows
                      return Padding(
                        padding: const EdgeInsets.all(3.5),
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
                          //container for colored(grey) background
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Colors.grey[400]),
                            child: Row(

                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //*****image container******
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      height: height * .18,
                                      width: width * .5,
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
                                  Expanded(
                                    child: Container(
                                      // color: Colors.grey[400],
                                      height: height * .18,
                                      padding: const EdgeInsets.all(8),
                                      child: Column(children: [
                                        //*****title******
                                        Text(
                                          maxLines: 3,
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          style: GoogleFonts.cormorantInfant(
                                            textStyle: const TextStyle(
                                              letterSpacing: 0,
                                            ),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //*****source name******
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style:
                                                  GoogleFonts.cormorantInfant(
                                                textStyle: const TextStyle(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            //*****date******
                                            Text(
                                              Format.format(dateTime),
                                              style:
                                                  GoogleFonts.cormorantInfant(
                                                textStyle: const TextStyle(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
