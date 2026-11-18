import 'package:flutter/material.dart';

import '../controller/quan_ly_tro_choi.dart';
import 'dich_vu_am_thanh.dart';
import 'man_hinh/man_hinh_chinh.dart';
import 'theme/mau_sac.dart';

class UngDung2048 extends StatelessWidget {
  final QuanLyTroChoi quanLy;
  const UngDung2048({super.key, required this.quanLy});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: '2048',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: MauSac.vang),
        builder: (context, child) => Listener(
          behavior: HitTestBehavior.translucent,
          onPointerUp: (_) => DichVuAmThanh.khiNguoiDungChamVao(),
          child: child,
        ),
        home: ManHinhChinh(quanLy: quanLy),
      );
}
