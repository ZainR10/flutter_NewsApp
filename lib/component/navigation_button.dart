import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onpressed;
  const NavigationButton({this.onpressed, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return InkWell(
      onTap: onpressed,
      child: Container(
        margin: const EdgeInsets.all(6),
        height: height * .05,
        width: width * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.grey)),
        child: Center(
          child: Icon(
            icon,
            size: 30,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
