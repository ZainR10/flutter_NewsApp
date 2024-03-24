import 'package:flutter/material.dart';
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
      body: ListView(
        children: [
          SizedBox(
              height: height * .30,
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
                    return Container(); // Placeholder, replace with appropriate Widget
                  }
                },
              ))
        ],
      ),
    );
  }
}
