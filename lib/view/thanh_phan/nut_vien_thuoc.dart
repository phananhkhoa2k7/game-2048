import 'package:flutter/material.dart';

import '../dich_vu_am_thanh.dart';
import '../theme/kieu_chu.dart';
import '../theme/mau_sac.dart';

class NutVienThuoc extends StatelessWidget {
  final String nhan;
  final IconData? bieuTuong;
  final VoidCallback? khiNhan;
  final double rong, cao, coChu;

  const NutVienThuoc({
    super.key,
    required this.nhan,
    this.bieuTuong,
    this.khiNhan,
    this.rong = 240,
    this.cao = 60,
    this.coChu = 30,
  });

  @override
  Widget build(BuildContext context) {
    final nhan_ = khiNhan;
    return SizedBox(
      width: rong,
      height: cao,
      child: Material(
        color: MauSac.nut,
        shape: const StadiumBorder(side: BorderSide(color: Colors.black)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          // Nut khong co hanh dong (nhan "Game Over") thi im lang.
          onTap: nhan_ == null
              ? null
              : () {
                  DichVuAmThanh.phatClick();
                  nhan_();
                },
          child: Center(
            child: bieuTuong != null
                ? Icon(bieuTuong, color: Colors.white, size: coChu)
                : Text(nhan, style: KieuChu.trang(coChu)),
          ),
        ),
      ),
    );
  }
}
