import 'package:flutter/material.dart';

class AppColors {
  static const gold = Color(0xFFE6B035);
  static const pill = Color(0xFFF2D466);

  static Color tile(int v) => switch (v) {
        2 => const Color(0xFFE0E0E0),
        4 => const Color(0xFFCCCCCC),
        8 => const Color(0xFFF2B179),
        16 => const Color(0xFFF59563),
        32 => const Color(0xFFF67C5F),
        64 => const Color(0xFFF65E3B),
        128 => const Color(0xFFEDCF72),
        256 => const Color(0xFFEDCC61),
        512 => const Color(0xFFEDC850),
        1024 => const Color(0xFFEDC53F),
        2048 => const Color(0xFFEDC22E),
        _ => const Color(0xFF3C3A32),
      };
}
