import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'app_state.dart';

class AudioService {
  static final AudioPlayer _music = AudioPlayer();
  static final AudioPlayer _click = AudioPlayer();
  static final AudioPlayer _lost = AudioPlayer();
  static bool _starting = false;

  static Future<void> init() async {
    try {
      await _music.setReleaseMode(ReleaseMode.loop);
      await _music.setVolume(0.4);
    } catch (e) {
      debugPrint('Audio init error: $e');
    }
  }

  static Future<void> playClick() => _playEffect(_click, 'audio/click.wav');
  static Future<void> playLost() => _playEffect(_lost, 'audio/lost.wav');

  static Future<void> _playEffect(AudioPlayer p, String path) async {
    if (!AppState.instance.soundOn) return;
    try {
      await p.stop(); // restart so quick clicks still sound
      await p.play(AssetSource(path));
    } catch (e) {
      debugPrint('Sound error: $e');
    }
  }

  static Future<void> syncMusic() async {
    try {
      if (!AppState.instance.musicOn) {
        await _music.pause();
        return;
      }
      if (_music.state == PlayerState.paused) {
        await _music.resume();
        return;
      }
      if (_music.state == PlayerState.playing || _starting) return;
      _starting = true;
      try {
        await _music.play(AssetSource('audio/music.mp3'));
      } finally {
        _starting = false;
      }
    } catch (e) {
      debugPrint('Music error: $e');
    }
  }

  static void onUserGesture() {
    if (AppState.instance.musicOn && _music.state != PlayerState.playing) {
      syncMusic();
    }
  }
}