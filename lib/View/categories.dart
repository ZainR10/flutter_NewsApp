import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';

import 'package:flutter_news/model/news_categories_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_news/utils/routes.dart';
import 'package:flutter_news/utils/routes_name.dart';
import 'package:flutter_news/widgets/bottom_navbar.dart';
import 'package:flutter_news/widgets/text_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                                    width: 3,
                                    color: categoryName == categoriesList[index]
                                        ? Colors.black
                                        : Colors.transparent
                                    // : Colors.grey.shade500,
                                    ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: themeProvider.isDarkTheme
                                      ? [
                                          const Color.fromARGB(255, 39, 38, 38),
                                          const Color.fromARGB(255, 47, 65, 97),
                                        ]
                                      : [
                                          const Color.fromARGB(255, 47, 65, 97),
                                          Colors.white,
                                        ],
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CustomText(
                                    text: categoriesList[index].toString(),
                                    textLetterSpace: 1,
                                    textSize: 20,
                                    textColor: Colors.black,
                                    textWeight: FontWeight.bold,
                                  )),
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
                                          CustomText(
                                            text: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            textMaxLines: 3,
                                            textSize: 20,
                                            textOverflow: TextOverflow.fade,
                                          ),

                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //*****source name******
                                              CustomText(
                                                text: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                                textLetterSpace: 3,
                                                textSize: 14,
                                                textOverflow: TextOverflow.fade,
                                                textWeight: FontWeight.w900,
                                              ),

                                              //*****date******

                                              CustomText(
                                                text: Format.format(dateTime),
                                                textSize: 14,
                                                textOverflow: TextOverflow.fade,
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
