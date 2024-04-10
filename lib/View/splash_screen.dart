import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'home_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        // backgroundColor: Colors.black,
        body: Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              // color: Colors.indigoAccent,
              // colorBlendMode: BlendMode.saturation,
              'assets/splashscreen.jpg',
              fit: BoxFit.cover,
              height: height * 1,
              width: width * 1,
            ),
          ),
          // Center(
          //   child: Text(
          //     'News',
          //     style: GoogleFonts.josefinSans(
          //         textStyle:
          //             const TextStyle(letterSpacing: 1, color: Colors.black),
          //         fontSize: 50,
          //         fontWeight: FontWeight.w900),
          //   ),
          // )
        ],
      ),
    ));
  }
}
