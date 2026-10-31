import 'dart:math';

import 'package:flutter/material.dart';

import '../models/tile.dart';
import '../theme/app_colors.dart';

class TileView extends StatelessWidget {
  final Tile tile;
  const TileView({super.key, required this.tile});

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: tile.isNew ? 0.0 : 1.0, end: 1.0),
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutBack,
        builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
        child: LayoutBuilder(
          builder: (_, box) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.tile(tile.value),
              border: Border.all(color: Colors.black, width: 2),
            ),
            // FittedBox shrinks the number so it always fits the tile.
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${tile.value}',
                style: TextStyle(
                  fontSize: min(box.maxWidth, box.maxHeight) * 0.5,
                  fontWeight: FontWeight.w900,
                  color: tile.value <= 4 ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
}
