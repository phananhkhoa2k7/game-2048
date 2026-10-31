import 'package:flutter/material.dart';

import '../services/app_state.dart';
import '../theme/app_text.dart';
import '../widgets/pill_button.dart';
import '../widgets/screen_frame.dart';
import 'about_screen.dart';
import 'game_screen.dart';
import 'setting_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _open(BuildContext context, Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));

  @override
  Widget build(BuildContext context) => ScreenFrame(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text('2048', style: AppText.white(80, spacing: 4)),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: AppState.instance,
              builder: (_, __) => Text(
                'Best score: ${AppState.instance.bestScore}',
                style: AppText.white(16, spacing: 4),
              ),
            ),
            const Spacer(),
            PillButton(label: 'Play', onTap: () => _open(context, const GameScreen())),
            const SizedBox(height: 28),
            PillButton(label: 'Setting', onTap: () => _open(context, const SettingScreen())),
            const SizedBox(height: 28),
            PillButton(label: 'About', onTap: () => _open(context, const AboutScreen())),
            const Spacer(flex: 2),
            Text('- ' * 14, style: AppText.white(16, spacing: 2)),
            const SizedBox(height: 8),
            Text(
              'Nhóm 4\nLập Trình Hướng Đối Tượng',
              textAlign: TextAlign.center,
              style: AppText.white(15, spacing: 0.5),
            ),
          ],
        ),
      );
}
