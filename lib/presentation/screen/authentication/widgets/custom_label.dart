import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  const CustomLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(164, 176, 190, 1),
        ),
      ),
    );
  }
}
