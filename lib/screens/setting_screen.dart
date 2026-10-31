import 'package:flutter/material.dart';

import '../services/app_state.dart';
import '../theme/app_text.dart';
import '../widgets/back_bar.dart';
import '../widgets/screen_frame.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Widget _row(String label, bool value, ValueChanged<bool> onChanged) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        child: Row(
          children: [
            Expanded(child: Text(label, style: AppText.white(26))),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => ScreenFrame(
        child: ListenableBuilder(
          listenable: AppState.instance,
          builder: (_, __) {
            final s = AppState.instance;
            return Column(
              children: [
                const BackBar(title: 'Setting'),
                const SizedBox(height: 40),
                _row('Music :', s.musicOn, s.setMusic),
                _row('Sound :', s.soundOn, s.setSound),
              ],
            );
          },
        ),
      );
}
