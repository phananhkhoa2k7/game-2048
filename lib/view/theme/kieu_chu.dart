import 'package:flutter/material.dart';

class KieuChu {
  static TextStyle trang(double coChu, {double khoangChu = 1.5}) => TextStyle(
        color: Colors.white,
        fontSize: coChu,
        fontWeight: FontWeight.w900,
        letterSpacing: khoangChu,
      );
}
