import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  // color: Colors.indigoAccent,
                  colorBlendMode: BlendMode.saturation,
                  'assets/splashscreen.png',
                  fit: BoxFit.cover,
                  height: height * 1,
                  width: width * 1,
                ),
              ),
              Center(
                child: Text(
                  'News',
                  style: GoogleFonts.josefinSans(
                      textStyle: const TextStyle(
                          letterSpacing: 1, color: Colors.black),
                      fontSize: 50,
                      fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
        ));
  }
}
