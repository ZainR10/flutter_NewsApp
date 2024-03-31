import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news/model/news_categories_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
      appBar: AppBar(),
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
                                  ? Colors.amber
                                  : Colors.blueGrey,
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
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                  height: height * .18,
                                  padding: const EdgeInsets.all(8),
                                  child: Column(children: [
                                    Text(
                                      maxLines: 3,
                                      snapshot.data!.articles![index].title
                                          .toString()
                                          .toString(),
                                      style: GoogleFonts.cormorantInfant(
                                        textStyle: const TextStyle(
                                            letterSpacing: 0,
                                            color: Colors.black),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          snapshot.data!.articles![index]
                                              .source!.name
                                              .toString(),
                                          style: GoogleFonts.cormorantInfant(
                                            textStyle: const TextStyle(
                                                color: Colors.black),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          Format.format(dateTime),
                                          style: GoogleFonts.cormorantInfant(
                                            textStyle: const TextStyle(
                                                color: Colors.black),
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