import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../model/cai_dat.dart';

/// Phat nhac nen va hieu ung am thanh (phan viec cua View).
class DichVuAmThanh {
  static final AudioPlayer _nhac = AudioPlayer();
  static final AudioPlayer _click = AudioPlayer();
  static final AudioPlayer _thua = AudioPlayer();
  static bool _dangKhoiDong = false;

  static Future<void> khoiTao() async {
    try {
      await _nhac.setReleaseMode(ReleaseMode.loop);
      await _nhac.setVolume(0.4);
    } catch (e) {
      debugPrint('Loi khoi tao am thanh: $e');
    }
    CaiDat.instance.themNguoiNghe(dongBoNhac); // tu dong bat/tat khi doi cai dat
    if (!kIsWeb) dongBoNhac(); // web phai cho nguoi dung cham vao truoc
  }

  static Future<void> phatClick() => _phatHieuUng(_click, 'audio/click.wav');
  static Future<void> phatThua() => _phatHieuUng(_thua, 'audio/lost.wav');

  static Future<void> _phatHieuUng(AudioPlayer p, String duongDan) async {
    if (!CaiDat.instance.amThanh) return;
    try {
      await p.stop();
      await p.play(AssetSource(duongDan));
    } catch (e) {
      debugPrint('Loi am thanh: $e');
    }
  }

  static Future<void> dongBoNhac() async {
    try {
      if (!CaiDat.instance.nhacNen) {
        await _nhac.pause();
        return;
      }
      if (_nhac.state == PlayerState.paused) {
        await _nhac.resume();
        return;
      }
      if (_nhac.state == PlayerState.playing || _dangKhoiDong) return;
      _dangKhoiDong = true;
      try {
        await _nhac.play(AssetSource('audio/music.mp3'));
      } finally {
        _dangKhoiDong = false;
      }
    } catch (e) {
      debugPrint('Loi nhac nen: $e');
    }
  }

  static void khiNguoiDungChamVao() {
    if (CaiDat.instance.nhacNen && _nhac.state != PlayerState.playing) {
      dongBoNhac();
    }
  }
}
