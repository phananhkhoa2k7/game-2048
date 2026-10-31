import 'dart:math';

import 'direction.dart';
import 'tile.dart';

class Board {
  final int rows, cols;
  final Random _rng;
  final List<Tile> tiles = [];

  Board({this.rows = 5, this.cols = 4, Random? rng}) : _rng = rng ?? Random();

  /// Score = sum of all numbers on the board.
  int get score => tiles.where((t) => !t.absorbed).fold(0, (s, t) => s + t.value);

  void reset() {
    tiles.clear();
    spawn();
    spawn();
  }

  /// Creates a 2 (90%) or 4 (10%) tile on a random empty cell.
  Tile? spawn() {
    final occupied = {for (final t in tiles) t.row * cols + t.col};
    final empty = [
      for (var i = 0; i < rows * cols; i++)
        if (!occupied.contains(i)) i
    ];
    if (empty.isEmpty) return null;
    final i = empty[_rng.nextInt(empty.length)];
    final tile = Tile(
      value: _rng.nextDouble() < 0.9 ? 2 : 4,
      row: i ~/ cols,
      col: i % cols,
      isNew: true,
    );
    tiles.add(tile);
    return tile;
  }

  /// Removes absorbed tiles and clears per-move flags.
  void settle() {
    tiles.removeWhere((t) => t.absorbed);
    for (final t in tiles) {
      t.merged = false;
    }
  }

  /// Slides + merges tiles. Returns true if anything changed.
  bool move(Direction d) {
    for (final t in tiles) {
      t.merged = false;
    }
    final horizontal = d == Direction.left || d == Direction.right;
    final lines = horizontal ? rows : cols;
    final len = horizontal ? cols : rows;
    final grid = {for (final t in tiles) t.row * cols + t.col: t};

    // k-th cell of a line, counted from the edge tiles move toward.
    (int, int) pos(int line, int k) => switch (d) {
          Direction.left => (line, k),
          Direction.right => (line, cols - 1 - k),
          Direction.up => (k, line),
          Direction.down => (rows - 1 - k, line),
        };

    var moved = false;
    for (var line = 0; line < lines; line++) {
      var target = 0;
      Tile? last;
      for (var k = 0; k < len; k++) {
        final (r, c) = pos(line, k);
        final t = grid[r * cols + c];
        if (t == null) continue;
        if (last != null && !last.merged && last.value == t.value) {
          t.row = last.row;
          t.col = last.col;
          t.absorbed = true;
          last.value *= 2;
          last.merged = true;
          moved = true;
        } else {
          final (tr, tc) = pos(line, target++);
          if (t.row != tr || t.col != tc) moved = true;
          t.row = tr;
          t.col = tc;
          last = t;
        }
      }
    }
    return moved;
  }

  bool get canMove {
    if (tiles.length < rows * cols) return true;
    final g = {for (final t in tiles) t.row * cols + t.col: t.value};
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final v = g[r * cols + c];
        if (c + 1 < cols && g[r * cols + c + 1] == v) return true;
        if (r + 1 < rows && g[(r + 1) * cols + c] == v) return true;
      }
    }
    return false;
  }
}
