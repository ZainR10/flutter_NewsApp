import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    return SizedBox(
      height: height * .05,
      child: const VerticalDivider(
        thickness: 2,
        // endIndent: 5,
        // indent: 5,
        color: Colors.white,
      ),
    );
  }
}
