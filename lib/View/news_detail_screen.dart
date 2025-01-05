// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/component/navigation_button.dart';
import 'package:flutter_news/component/vertical_divider.dart';
import 'package:flutter_news/utils/theme.dart';
import 'package:flutter_news/view_model/themeprovider.dart';
import 'package:flutter_news/widgets/text_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewsDetail extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetail({
    super.key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final FlutterTts _flutterTts = FlutterTts();
  bool isPlaying = false;
  int? _currentWordStart, _currentWordEnd;
  String? _remainingText;

  @override
  void initState() {
    super.initState();
    initTTS();
  }

  void initTTS() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.6);

    // Handle word progress
    _flutterTts.setProgressHandler((text, start, end, word) {
      setState(() {
        _currentWordStart = start;
        _currentWordEnd = end;
      });
    });

    // Handle completion
    _flutterTts.setCompletionHandler(() {
      resetTTS();
    });
  }

  void togglePlayPause() async {
    if (isPlaying) {
      // Pause the TTS
      await _flutterTts.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      // Resume from where it was paused
      if (_remainingText != null) {
        await _flutterTts.speak(_remainingText!);
      } else {
        // Start from the beginning
        setState(() {
          _currentWordStart = 0;
          _currentWordEnd = 0;
          _remainingText =
              '${widget.newsTitle}${widget.content}${widget.description}';
        });
        await _flutterTts.speak(_remainingText!);
      }

      setState(() {
        isPlaying = true;
      });
    }
  }

  void resetTTS() async {
    await _flutterTts.stop();
    setState(() {
      isPlaying = false;
      _currentWordStart = null;
      _currentWordEnd = null;
      _remainingText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: value.isDarkTheme
            ? DarkTheme.darkThemeData.scaffoldBackgroundColor
            : LightTheme.lightThemeData.scaffoldBackgroundColor,
        body: SafeArea(
          child: Container(
            height: height * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: value.isDarkTheme
                    ? [const Color.fromARGB(255, 47, 65, 97), Colors.black]
                    : [Colors.white, const Color.fromARGB(255, 3, 32, 83)],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationButton(
                    icon: Icons.arrow_back,
                    onpressed: () {
                      resetTTS();
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: widget.newsImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const SpinKitDancingSquare(
                          color: Colors.amber,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: togglePlayPause,
                        child: Icon(
                          isPlaying
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_outline,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                      const CustomVerticalDivider(),
                      CustomText(
                        text: widget.source,
                        textSize: 16,
                        textWeight: FontWeight.w900,
                        textLetterSpace: 1,
                      ),
                      const CustomVerticalDivider(),
                      CustomText(
                        text: widget.newsDate,
                        textSize: 16,
                        textWeight: FontWeight.w900,
                        textLetterSpace: 1,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: (TextSpan(children: <TextSpan>[
                        TextSpan(
                          text:
                              '${widget.newsTitle} ${widget.content} ${widget.description}'
                                  .substring(0, _currentWordStart),
                          style: GoogleFonts.actor(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: value.isDarkTheme
                                  ? DarkTheme.darkFontColor
                                  : LightTheme.lightFontColor),
                        ),
                        if (_currentWordStart != null)
                          TextSpan(
                            text:
                                '${widget.newsTitle} ${widget.content}${widget.description}'
                                    .substring(
                                        _currentWordStart!, _currentWordEnd),
                            style: GoogleFonts.actor(
                                color: value.isDarkTheme
                                    ? DarkTheme.darkFontColor
                                    : LightTheme.lightFontColor,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.purple.shade300,
                                fontSize: 24),
                          ),
                        if (_currentWordEnd != null)
                          TextSpan(
                            text:
                                '${widget.newsTitle} ${widget.content}  ${widget.description}'
                                    .substring(_currentWordEnd!),
                            style: GoogleFonts.actor(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: value.isDarkTheme
                                    ? DarkTheme.darkFontColor
                                    : LightTheme.lightFontColor),
                          ),
                      ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
