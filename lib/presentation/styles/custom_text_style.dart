import 'package:flutter/material.dart';

class CustomTextStyle {
  static bool isLightTheme = false;

  static TextStyle get bodyRegular {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get headlineMedium {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get topHeadline {
    return TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: isLightTheme ? const Color(0xFF0058C6) : Colors.white);
  }

  static TextStyle get headlineLarge {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get initialNameOfTutor {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }
}
