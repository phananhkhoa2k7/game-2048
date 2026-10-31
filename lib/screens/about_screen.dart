import 'package:flutter/material.dart';

import '../theme/app_text.dart';
import '../widgets/back_bar.dart';
import '../widgets/screen_frame.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const members = [
    'Bùi Anh Hùng – 25103033',
    'Phan Anh Khoa – 25103039',
    'Phạm Công Tín – 25103094',
    'Phạm Hùng Dũng – 25103113'
  ];

  @override
  Widget build(BuildContext context) => ScreenFrame(
        child: Column(
          children: [
            const BackBar(title: 'About'),
            const Spacer(),
            Text('Dự án học phần:', style: AppText.white(22)),
            const SizedBox(height: 8),
            Text('Lập Trình Hướng Đối Tượng',
                textAlign: TextAlign.center, style: AppText.white(26)),
            const SizedBox(height: 40),
            Text('NHÓM 4', style: AppText.white(30, spacing: 3)),
            const SizedBox(height: 16),
            for (final m in members)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(m, style: AppText.white(20, spacing: 1)),
              ),
            const Spacer(flex: 2),
          ],
        ),
      );
}
