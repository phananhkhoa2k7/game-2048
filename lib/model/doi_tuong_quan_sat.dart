typedef NguoiNghe = void Function();

/// Co che quan sat don gian (Observer): View dang ky de duoc bao khi Model/Controller doi.
class DoiTuongQuanSat {
  final List<NguoiNghe> _dsNguoiNghe = [];

  void themNguoiNghe(NguoiNghe f) => _dsNguoiNghe.add(f);
  void xoaNguoiNghe(NguoiNghe f) => _dsNguoiNghe.remove(f);

  void thongBao() {
    for (final f in List.of(_dsNguoiNghe)) {
      f();
    }
  }
}
