import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Expanded(
          //   child: Image.asset(
          //     // color: Colors.indigoAccent,
          //     // colorBlendMode: BlendMode.saturation,
          //     'assets/splashscreen.jpg',
          //     fit: BoxFit.cover,
          //     height: height * 1,
          //     width: width * 1,
          //   ),
          // ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
              height: height,
              width: width,
            ),
          ),
          Center(
            child: Container(
              height: height * .25,
              width: width * .50,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.shade400
                          .withOpacity(0.5), // Adjust opacity as needed
                      spreadRadius: 10,
                      blurRadius: 30,
                      offset: const Offset(0, 9), // changes position of shadow
                    ),
                  ],
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  'News\nNest',
                  style: GoogleFonts.rubik80sFade(
                      textStyle: const TextStyle(
                          letterSpacing: 4, color: Colors.white),
                      fontSize: 50,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
