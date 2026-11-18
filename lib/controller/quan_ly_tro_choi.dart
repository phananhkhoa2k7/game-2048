import '../model/bang_dau.dart';
import '../model/doi_tuong_quan_sat.dart';
import '../model/huong_di.dart';
import '../model/trang_thai_tro_choi.dart';

/// Controller: nhan thao tac tu View, cap nhat Model, roi bao View ve lai.
class QuanLyTroChoi extends DoiTuongQuanSat {
  final BangDau bangDau = BangDau();
  TrangThaiTroChoi trangThai = TrangThaiTroChoi.dangChoi;
  int diemHienTai = 0;
  int diemCaoNhat = 0;

  QuanLyTroChoi() {
    batDau();
  }

  bool get daDatO2048 => bangDau.giaTriLonNhat >= 2048;

  /// Bat dau / choi lai: bang moi voi hai o ngau nhien (diem cao nhat duoc giu lai).
  void batDau() {
    bangDau.khoiTaoBang();
    bangDau.sinhOSoNgauNhien();
    bangDau.sinhOSoNgauNhien();
    trangThai = TrangThaiTroChoi.dangChoi;
    _capNhatDiem();
    thongBao();
  }

  /// Tra ve true neu nuoc di hop le (bang co thay doi).
  bool diChuyen(HuongDi huong) {
    if (trangThai != TrangThaiTroChoi.dangChoi) return false;
    if (!bangDau.diChuyen(huong)) return false;

    bangDau.sinhOSoNgauNhien();
    _capNhatDiem();
    if (!bangDau.kiemTraXemCoTheDiChuyen()) {
      trangThai = TrangThaiTroChoi.ketThuc;
    }
    thongBao();
    return true;
  }

  void doiTamDung() {
    if (trangThai == TrangThaiTroChoi.dangChoi) {
      trangThai = TrangThaiTroChoi.tamDung;
    } else if (trangThai == TrangThaiTroChoi.tamDung) {
      trangThai = TrangThaiTroChoi.dangChoi;
    } else {
      return;
    }
    thongBao();
  }

  void _capNhatDiem() {
    diemHienTai = bangDau.tinhTongCacSo();
    if (diemHienTai > diemCaoNhat) diemCaoNhat = diemHienTai;
  }
}
