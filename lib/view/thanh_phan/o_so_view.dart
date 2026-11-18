import 'dart:math' show min;

import 'package:flutter/material.dart';

import '../../model/o_so.dart';
import '../theme/mau_sac.dart';

/// Ve mot o so. O moi hien ra sau khi cac o khac truot xong; o vua gop "bat" len.
class OSoView extends StatelessWidget {
  final OSo oSo;
  const OSoView({super.key, required this.oSo});

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: oSo.moi ? 0.0 : 1.0, end: 1.0),
        duration: const Duration(milliseconds: 280),
        curve: const Interval(0.45, 1.0, curve: Curves.easeOutBack),
        builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
          child: SizedBox.expand(key: ValueKey(oSo.giaTri), child: _noiDung()),
        ),
      );

  Widget _noiDung() => LayoutBuilder(
        builder: (_, box) => Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: MauSac.o(oSo.giaTri),
            border: Border.all(color: Colors.black, width: 2),
          ),
          // FittedBox: so tu co nho de luon vua o.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${oSo.giaTri}',
              style: TextStyle(
                fontSize: min(box.maxWidth, box.maxHeight) * 0.5,
                fontWeight: FontWeight.w900,
                color: oSo.giaTri <= 4 ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      );
}
