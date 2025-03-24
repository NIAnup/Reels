import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton(
      {super.key, this.onTap, required this.text, this.height, this.width});
  final void Function()? onTap;
  final String text;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFFFA4768)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontFamily: "uber", fontSize: 20),
          ),
        ),
      ),
    );
  }
}
