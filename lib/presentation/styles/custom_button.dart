import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final double height;
  final double radius;
  final double width;
  final double textSize;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const MyElevatedButton({
    super.key,
    required this.text,
    required this.height,
    required this.radius,
    required this.onPressed,
    this.width = double.infinity,
    this.textSize = 20.0,
    this.color = const Color(0xFF0058C6),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        minimumSize: Size(width, height),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
        ),
      ),
    );
  }
}
