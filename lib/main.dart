import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/quan_ly_tro_choi.dart';
import 'view/dich_vu_am_thanh.dart';
import 'view/ung_dung.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DichVuAmThanh.khoiTao();

  // Trinh duyet chan tu phat am thanh: nhac se bat dau o lan cham / bam phim dau tien.
  HardwareKeyboard.instance.addHandler((KeyEvent e) {
    DichVuAmThanh.khiNguoiDungChamVao();
    return false;
  });

  runApp(UngDung2048(quanLy: QuanLyTroChoi()));
}
