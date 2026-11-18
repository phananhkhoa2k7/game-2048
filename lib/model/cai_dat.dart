import 'doi_tuong_quan_sat.dart';

/// Cai dat chung cua ung dung (bat/tat nhac nen va am thanh).
class CaiDat extends DoiTuongQuanSat {
  CaiDat._();
  static final CaiDat instance = CaiDat._();

  bool nhacNen = true;
  bool amThanh = true;

  void datNhacNen(bool v) {
    nhacNen = v;
    thongBao();
  }

  void datAmThanh(bool v) {
    amThanh = v;
    thongBao();
  }
}
