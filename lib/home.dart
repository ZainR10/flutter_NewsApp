import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news/model/news_channel_headlines_model.dart';
import 'package:flutter_news/view_model/news_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
            child: Text(
          'Home',
          style: GoogleFonts.abrilFatface(
              fontSize: 24, fontWeight: FontWeight.bold),
        )),
      ),
      body: SizedBox(
          height: height * .36,
          width: width,
          child: FutureBuilder<NewsChannelHeadlinesModel>(
            future: newsViewModel.fetchNewsChannelHeadlinesApi(),
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
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              width: width * .9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: const SpinKitDancingSquare(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                child: Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }); // Placeholder, replace with appropriate Widget
              }
            },
          )),
    );
  }
}
