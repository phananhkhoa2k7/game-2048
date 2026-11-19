import 'package:flutter/material.dart';

import '../../controller/quan_ly_tro_choi.dart';
import '../theme/kieu_chu.dart';
import '../thanh_phan/khung_man_hinh.dart';
import '../thanh_phan/lang_nghe.dart';
import '../thanh_phan/nut_vien_thuoc.dart';
import 'man_hinh_cai_dat.dart';
import 'man_hinh_gioi_thieu.dart';
import 'man_hinh_tro_choi.dart';

class ManHinhChinh extends StatelessWidget {
  final QuanLyTroChoi quanLy;
  const ManHinhChinh({super.key, required this.quanLy});

  void _mo(BuildContext context, Widget manHinh) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => manHinh));

  @override
  Widget build(BuildContext context) => KhungManHinh(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text('2048', style: KieuChu.trang(80, khoangChu: 4)),
            const SizedBox(height: 16),
            LangNghe(
              doiTuong: [quanLy],
              xayDung: (_) => Text('Best score: ${quanLy.diemCaoNhat}',
                  style: KieuChu.trang(16, khoangChu: 4)),
            ),
            const Spacer(),
            NutVienThuoc(
              nhan: 'Play',
              khiNhan: () {
                quanLy.batDau();
                _mo(context, ManHinhTroChoi(quanLy: quanLy));
              },
            ),
            const SizedBox(height: 28),
            NutVienThuoc(nhan: 'Setting', khiNhan: () => _mo(context, const ManHinhCaiDat())),
            const SizedBox(height: 28),
            NutVienThuoc(nhan: 'About', khiNhan: () => _mo(context, const ManHinhGioiThieu())),
            const Spacer(flex: 2),
            Text('- ' * 14, style: KieuChu.trang(16, khoangChu: 2)),
            const SizedBox(height: 8),
            Text(
              'Nhóm 3\nLập Trình Hướng Đối Tượng',
              textAlign: TextAlign.center,
              style: KieuChu.trang(15, khoangChu: 0.5),
            ),
          ],
        ),
      );
}
