import 'package:flutter/material.dart';

import '../models/board.dart';
import '../theme/app_colors.dart';
import 'tile_view.dart';

class BoardView extends StatelessWidget {
  final Board board;
  const BoardView({super.key, required this.board});

  static const double gap = 4;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppColors.pill,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: LayoutBuilder(
          builder: (context, box) {
            final cw = (box.maxWidth - gap * (board.cols + 1)) / board.cols;
            final ch = (box.maxHeight - gap * (board.rows + 1)) / board.rows;
            double left(int c) => gap + c * (cw + gap);
            double top(int r) => gap + r * (ch + gap);

            // Absorbed tiles are drawn underneath the tiles that swallow them.
            final ordered = [
              ...board.tiles.where((t) => t.absorbed),
              ...board.tiles.where((t) => !t.absorbed),
            ];

            return Stack(
              children: [
                for (var r = 0; r < board.rows; r++)
                  for (var c = 0; c < board.cols; c++)
                    Positioned(
                      left: left(c),
                      top: top(r),
                      width: cw,
                      height: ch,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                for (final t in ordered)
                  AnimatedPositioned(
                    key: ValueKey(t.id),
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,
                    left: left(t.col),
                    top: top(t.row),
                    width: cw,
                    height: ch,
                    child: TileView(tile: t),
                  ),
              ],
            );
          },
        ),
      );
}
