import 'package:flutter/material.dart';

import '../theme/app_text.dart';

class BackBar extends StatelessWidget {
  final String title;
  const BackBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(title, style: AppText.white(32)),
        ],
      );
}
