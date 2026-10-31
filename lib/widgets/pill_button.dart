import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class PillButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final double width, height, fontSize;

  const PillButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.width = 240,
    this.height = 60,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: Material(
          color: AppColors.pill,
          shape: const StadiumBorder(side: BorderSide(color: Colors.black)),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Center(
              child: icon != null
                  ? Icon(icon, color: Colors.white, size: fontSize)
                  : Text(label, style: AppText.white(fontSize)),
            ),
          ),
        ),
      );
}
