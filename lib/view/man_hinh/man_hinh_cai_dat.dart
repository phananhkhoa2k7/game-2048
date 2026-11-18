import 'package:flutter/material.dart';

import '../../model/cai_dat.dart';
import '../theme/kieu_chu.dart';
import '../thanh_phan/khung_man_hinh.dart';
import '../thanh_phan/lang_nghe.dart';
import '../thanh_phan/thanh_quay_lai.dart';

class ManHinhCaiDat extends StatelessWidget {
  const ManHinhCaiDat({super.key});

  Widget _hang(String nhan, bool giaTri, ValueChanged<bool> khiDoi) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        child: Row(
          children: [
            Expanded(child: Text(nhan, style: KieuChu.trang(26))),
            Switch(value: giaTri, onChanged: khiDoi),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final caiDat = CaiDat.instance;
    return KhungManHinh(
      child: LangNghe(
        doiTuong: [caiDat],
        xayDung: (_) => Column(
          children: [
            const ThanhQuayLai(tieuDe: 'Setting'),
            const SizedBox(height: 40),
            _hang('Music :', caiDat.nhacNen, caiDat.datNhacNen),
            _hang('Sound :', caiDat.amThanh, caiDat.datAmThanh),
          ],
        ),
      ),
    );
  }
}
