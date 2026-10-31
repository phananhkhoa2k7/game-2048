import 'package:flutter/services.dart';

import 'app_state.dart';

/// Pure Flutter can only play system sounds (no-op on web).
class AudioService {
  static void playMove() {
    if (AppState.instance.soundOn) SystemSound.play(SystemSoundType.click);
  }

  /// Hook for background music. Plug in a package such as audioplayers here
  /// and branch on AppState.instance.musicOn.
  static void syncMusic() {}
}
