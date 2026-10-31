import 'package:flutter/material.dart';

import 'screens/menu_screen.dart';
import 'theme/app_colors.dart';

class App2048 extends StatelessWidget {
  const App2048({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: '2048',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: AppColors.gold),
        home: const MenuScreen(),
      );
}
