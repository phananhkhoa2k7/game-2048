import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'services/audio_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioService.init();

  if (!kIsWeb) AudioService.syncMusic();

  HardwareKeyboard.instance.addHandler((KeyEvent event) {
    AudioService.onUserGesture();
    return false;
  });

  runApp(const App2048());
}