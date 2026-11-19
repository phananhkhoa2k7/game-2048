import 'package:flutter/material.dart';

import '../theme/kieu_chu.dart';
import '../thanh_phan/khung_man_hinh.dart';
import '../thanh_phan/thanh_quay_lai.dart';

class ManHinhGioiThieu extends StatelessWidget {
  const ManHinhGioiThieu({super.key});

  static const thanhVien = [
    'Bùi Anh Hùng – 25103033',
    'Phan Anh Khoa – 25103039',
    'Phạm Công Tín – 25103094',
    'Phạm Hùng Dũng – 25103113',
  ];

  @override
  Widget build(BuildContext context) => KhungManHinh(
        child: Column(
          children: [
            const ThanhQuayLai(tieuDe: 'About'),
            const Spacer(),
            Text('Dự án học phần:', style: KieuChu.trang(22)),
            const SizedBox(height: 8),
            Text('Lập Trình Hướng Đối Tượng',
                textAlign: TextAlign.center, style: KieuChu.trang(26)),
            const SizedBox(height: 40),
            Text('NHÓM 3', style: KieuChu.trang(30, khoangChu: 3)),
            const SizedBox(height: 16),
            for (final tv in thanhVien)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(tv, style: KieuChu.trang(20, khoangChu: 1)),
              ),
            const Spacer(flex: 2),
          ],
        ),
      );
}
