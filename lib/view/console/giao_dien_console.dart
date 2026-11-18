import 'dart:io';

import '../../controller/quan_ly_tro_choi.dart';
import '../../model/huong_di.dart';
import '../../model/trang_thai_tro_choi.dart';
import '../giao_dien_tro_choi.dart';

class GiaoDienConsole implements GiaoDienTroChoi {
  @override
  void hienThi(QuanLyTroChoi quanLy) {
    final bang = quanLy.bangDau;
    final duongKe = '-' * (1 + bang.soCot * 7);

    print('Best Score: ${quanLy.diemCaoNhat}');
    print('Score: ${quanLy.diemHienTai}');
    print(duongKe);
    for (int i = 0; i < bang.soDong; i++) {
      String dongStr = '|';
      for (int j = 0; j < bang.soCot; j++) {
        final giaTri = bang.luoi[i][j].giaTri;
        final hienThiGiaTri = giaTri == 0 ? '.' : giaTri.toString();
        dongStr += '${hienThiGiaTri.padLeft(5)} |';
      }
      print(dongStr);
      print(duongKe);
    }
  }

  @override
  void chay(QuanLyTroChoi quanLy) {
    quanLy.batDau();

    while (true) {
      hienThi(quanLy);

      if (quanLy.trangThai == TrangThaiTroChoi.ketThuc) {
        print('Game Over! Khong con nuoc di hop le.');
        break;
      }

      stdout.write('Nhap huong di (w/a/s/d), r de choi lai, q de thoat: ');
      final dauVao = (stdin.readLineSync() ?? '').trim().toLowerCase();

      if (dauVao == 'q') {
        print('Thoat tro choi thanh cong.');
        break;
      }
      if (dauVao == 'r') {
        quanLy.batDau();
        continue;
      }

      final huong = switch (dauVao) {
        'w' => HuongDi.len,
        's' => HuongDi.xuong,
        'a' => HuongDi.trai,
        'd' => HuongDi.phai,
        _ => null,
      };
      if (huong == null) {
        print('Thong bao: Phim nhap khong hop le! Chi su dung w, a, s, d, r hoac q.');
        sleep(const Duration(seconds: 1));
        continue;
      }

      if (!quanLy.diChuyen(huong)) {
        print('Thong bao: Nuoc di khong hop le (khong the di chuyen theo huong nay)!');
        sleep(const Duration(seconds: 1));
      }
    }
  }
}
