import 'package:flutter/material.dart';

import '../theme/mau_sac.dart';

class KhungManHinh extends StatelessWidget {
  final Widget child;
  const KhungManHinh({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: MauSac.vang,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(padding: const EdgeInsets.all(20), child: child),
            ),
          ),
        ),
      );
}
