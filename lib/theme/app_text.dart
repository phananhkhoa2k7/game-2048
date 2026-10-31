import 'package:flutter/material.dart';

class AppText {
  static TextStyle white(double size, {double spacing = 1.5}) => TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: FontWeight.w900,
        letterSpacing: spacing,
      );
}
