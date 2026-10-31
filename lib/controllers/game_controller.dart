import 'package:flutter/foundation.dart';

import '../models/board.dart';
import '../models/direction.dart';
import '../models/game_status.dart';
import '../services/app_state.dart';
import '../services/audio_service.dart';

class GameController extends ChangeNotifier {
  static const _slide = Duration(milliseconds: 130);

  final Board board = Board();
  GameStatus status = GameStatus.playing;
  bool _busy = false;
  bool _disposed = false;
  int _generation = 0;

  GameController() {
    board.reset();
  }

  int get score => board.score;

  void handleMove(Direction d) {
    if (status != GameStatus.playing || _busy) return;
    if (!board.move(d)) return;
    _busy = true;
    final gen = _generation;
    AudioService.playMove();
    notifyListeners(); // tiles slide

    Future.delayed(_slide, () {
      if (_disposed || gen != _generation) return;
      board.settle();
      board.spawn();
      AppState.instance.submitScore(score);
      if (!board.canMove) status = GameStatus.gameOver;
      _busy = false;
      notifyListeners();
    });
  }

  void togglePause() {
    if (status == GameStatus.playing) {
      status = GameStatus.paused;
    } else if (status == GameStatus.paused) {
      status = GameStatus.playing;
    }
    notifyListeners();
  }

  void restart() {
    _generation++;
    _busy = false;
    status = GameStatus.playing;
    board.reset();
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
