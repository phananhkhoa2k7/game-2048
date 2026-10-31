import 'package:flutter/foundation.dart';

import 'audio_service.dart';

/// App-wide state (best score + settings). Singleton.
class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  int bestScore = 0; // in memory only (add shared_preferences to persist)
  bool musicOn = true;
  bool soundOn = true;

  void submitScore(int score) {
    if (score > bestScore) {
      bestScore = score;
      notifyListeners();
    }
  }

  void setMusic(bool v) {
    musicOn = v;
    AudioService.syncMusic();
    notifyListeners();
  }

  void setSound(bool v) {
    soundOn = v;
    notifyListeners();
  }
}
