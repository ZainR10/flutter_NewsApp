import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_news/widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, 'home_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 3, 32, 83),
      body: Container(
        height: height * 1,
        width: width * 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 47, 65, 97),
              Colors.white,
            ],
          ),
        ),
        child: const Center(
          child: CustomText(
            text: 'News Nest',
            textLetterSpace: 2,
            textSize: 50,
            textWeight: FontWeight.bold,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
