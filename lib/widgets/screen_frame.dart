import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ScreenFrame extends StatelessWidget {
  final Widget child;
  const ScreenFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.gold,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(padding: const EdgeInsets.all(20), child: child),
            ),
          ),
        ),
      );
}
