import 'package:flutter/material.dart';

class OverlayPanel extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onBackgroundTap;
  const OverlayPanel({super.key, required this.children, this.onBackgroundTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onBackgroundTap,
        child: Container(
          color: Colors.black54,
          alignment: Alignment.center,
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      );
}
