import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetail extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetail(
      {super.key,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.source});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: height * .45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.newsImage,
                placeholder: (context, url) => const Center(
                  child: SpinKitDancingSquare(
                    color: Colors.amber,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.api,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: ListView(
              children: [
                //title
                Text(
                  widget.newsTitle,
                  style: GoogleFonts.cormorantInfant(
                    textStyle:
                        const TextStyle(letterSpacing: 0, color: Colors.black),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //news source
                    Text(
                      widget.source,
                      style: GoogleFonts.cormorantInfant(
                        textStyle: const TextStyle(
                            letterSpacing: 1, color: Colors.black),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    //date
                    Text(
                      widget.newsDate,
                      style: GoogleFonts.cormorantInfant(
                        textStyle: const TextStyle(
                            letterSpacing: 1, color: Colors.black),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  widget.content,
                  style: GoogleFonts.cormorantInfant(
                    textStyle:
                        const TextStyle(letterSpacing: 1, color: Colors.black),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  widget.description,
                  style: GoogleFonts.cormorantInfant(
                    textStyle:
                        const TextStyle(letterSpacing: 1, color: Colors.black),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}