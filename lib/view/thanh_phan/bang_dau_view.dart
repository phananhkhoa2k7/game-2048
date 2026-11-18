import 'package:flutter/material.dart';

import '../../model/bang_dau.dart';
import '../theme/mau_sac.dart';
import 'o_so_view.dart';

class BangDauView extends StatelessWidget {
  final BangDau bangDau;
  const BangDauView({super.key, required this.bangDau});

  static const double khoangCach = 4;
  static const Duration thoiGianTruot = Duration(milliseconds: 120);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: MauSac.nut,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: LayoutBuilder(
          builder: (context, box) {
            final rong = (box.maxWidth - khoangCach * (bangDau.soCot + 1)) / bangDau.soCot;
            final cao = (box.maxHeight - khoangCach * (bangDau.soDong + 1)) / bangDau.soDong;
            double trai(int c) => khoangCach + c * (rong + khoangCach);
            double tren(int r) => khoangCach + r * (cao + khoangCach);

            return Stack(
              children: [
                // Nen: cac o trong
                for (int r = 0; r < bangDau.soDong; r++)
                  for (int c = 0; c < bangDau.soCot; c++)
                    Positioned(
                      left: trai(c),
                      top: tren(r),
                      width: rong,
                      height: cao,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                // Cac o so: key = id nen khi doi vi tri se truot muot
                for (final o in bangDau.cacOCoSo)
                  AnimatedPositioned(
                    key: ValueKey(o.id),
                    duration: thoiGianTruot,
                    curve: Curves.easeOut,
                    left: trai(o.cot),
                    top: tren(o.dong),
                    width: rong,
                    height: cao,
                    child: OSoView(oSo: o),
                  ),
              ],
            );
          },
        ),
      );
}
