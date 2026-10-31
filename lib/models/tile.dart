class Tile {
  static int _nextId = 0;

  final int id = _nextId++;
  int value, row, col;
  bool absorbed = false; // merged into another tile, removed after animation
  bool merged = false; // already merged during the current move
  final bool isNew;

  Tile({
    required this.value,
    required this.row,
    required this.col,
    this.isNew = false,
  });
}
