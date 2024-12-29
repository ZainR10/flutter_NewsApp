import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';

import 'package:flutter_news/model/news_categories_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_news/utils/routes.dart';
import 'package:flutter_news/utils/routes_name.dart';
import 'package:flutter_news/widgets/bottom_navbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  NewsViewModel newsViewModel = NewsViewModel();

  final Format = DateFormat('M:d:y');

  String categoryName = 'general';

  List<String> categoriesList = [
    'General',
    'Politics',
    'Technology',
    'Fashion',
    'Entertainment',
    'Business',
    'Health',
    'Sports',
  ];
  @override
  void initState() {
    super.initState();
    // Set the default category to "General" when the widget initializes
    categoryName = 'General';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: themeProvider.isDarkTheme
          ? DarkTheme.darkThemeData.scaffoldBackgroundColor
          : LightTheme.lightThemeData.scaffoldBackgroundColor,
      bottomNavigationBar: const BottomNavbar(),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            width: width * 0.3,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: categoryName == categoriesList[index]
                                      ? Colors.black
                                      : Colors.grey.shade500,
                                ),
                                color: categoryName == categoriesList[index]
                                    ? Colors.lightBlue.shade200
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  categoriesList[index].toString(),
                                  style: GoogleFonts.actor(
                                    textStyle: const TextStyle(
                                      letterSpacing: 1,
                                    ),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
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
                        size: 50,
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
                          padding: const EdgeInsets.all(3),
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
                                  author: snapshot.data!.articles![index].author
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
                            //container for colored(grey) background
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
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
                                          const Color.fromARGB(255, 47, 65, 97),
                                        ],
                                ),
                              ),
                              child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //*****image container******
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        height: height * .15,
                                        width: width * 0.4,
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.fill,
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
                                        height: height * .18,
                                        padding: const EdgeInsets.all(8),
                                        child: Column(children: [
                                          //*****title******
                                          Text(
                                            maxLines: 3,
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.actor(
                                              textStyle: TextStyle(
                                                overflow: TextOverflow.fade,
                                                color: themeProvider.isDarkTheme
                                                    ? DarkTheme.darkFontColor
                                                    : LightTheme.lightFontColor,
                                              ),
                                              fontSize: 20,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //*****source name******
                                              Text(
                                                overflow: TextOverflow.fade,
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.actor(
                                                  textStyle: TextStyle(
                                                      color: themeProvider
                                                              .isDarkTheme
                                                          ? DarkTheme
                                                              .darkFontColor
                                                          : LightTheme
                                                              .lightFontColor),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              //*****date******
                                              Text(
                                                Format.format(dateTime),
                                                style: GoogleFonts.actor(
                                                  textStyle: TextStyle(
                                                      overflow:
                                                          TextOverflow.fade,
                                                      color: themeProvider
                                                              .isDarkTheme
                                                          ? DarkTheme
                                                              .darkFontColor
                                                          : LightTheme
                                                              .lightFontColor),
                                                  fontSize: 14,
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
      ),
    );
  }
}
