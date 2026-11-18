import 'dart:math';

import 'huong_di.dart';
import 'o_so.dart';

/// Bang choi (mac dinh 4x4) va luat truot / gop o.
/// Cac OSo duoc di chuyen that su tren luoi (giu nguyen id) de View lam hieu ung truot.
class BangDau {
  final int soDong;
  final int soCot;
  final Random _random;
  late List<List<OSo>> luoi;

  /// Cac o vua bi gop vao o khac trong nuoc di gan nhat (chi de ve hieu ung truot).
  final List<OSo> cacOBiGop = [];

  BangDau({this.soDong = 4, this.soCot = 4, Random? random})
      : _random = random ?? Random() {
    khoiTaoBang();
  }

  void khoiTaoBang() {
    cacOBiGop.clear();
    luoi = List.generate(
      soDong,
      (i) => List.generate(soCot, (j) => OSo(dong: i, cot: j)),
    );
  }

  /// Cac o co so de View ve (o bi gop nam truoc de duoc ve phia duoi).
  List<OSo> get cacOCoSo => [
        ...cacOBiGop,
        for (final dong in luoi)
          for (final o in dong)
            if (!o.laTrong()) o
      ];

  /// Sinh o 2 (90%) hoac 4 (10%) o mot vi tri trong ngau nhien.
  void sinhOSoNgauNhien() {
    final danhSachOSoTrong = <OSo>[
      for (final dong in luoi)
        for (final o in dong)
          if (o.laTrong()) o
    ];
    if (danhSachOSoTrong.isEmpty) return;
    final oChon = danhSachOSoTrong[_random.nextInt(danhSachOSoTrong.length)];
    oChon.giaTri = _random.nextInt(100) < 90 ? 2 : 4;
    oChon.moi = true;
  }

  /// Diem = tong cac so tren bang.
  int tinhTongCacSo() {
    int tong = 0;
    for (final dong in luoi) {
      for (final o in dong) {
        tong += o.giaTri;
      }
    }
    return tong;
  }

  int get giaTriLonNhat {
    int lon = 0;
    for (final dong in luoi) {
      for (final o in dong) {
        if (o.giaTri > lon) lon = o.giaTri;
      }
    }
    return lon;
  }

  /// Truot + gop theo huong. Tra ve true neu bang co thay doi.
  bool diChuyen(HuongDi huong) {
    cacOBiGop.clear();
    for (final dong in luoi) {
      for (final o in dong) {
        o.moi = false;
      }
    }

    final ngang = huong == HuongDi.trai || huong == HuongDi.phai;
    final soDuong = ngang ? soDong : soCot;
    final capGop = <(OSo, OSo)>[]; // (o bi gop, o giu lai)
    var coThayDoi = false;

    for (int i = 0; i < soDuong; i++) {
      final toaDo = _layToaDo(huong, i);
      final hang = [for (final (r, c) in toaDo) luoi[r][c]];
      final ketQua = donVaGopHang(hang, capGop);

      for (int k = 0; k < toaDo.length; k++) {
        final (r, c) = toaDo[k];
        final o = ketQua[k];
        if (!o.laTrong() && (o.dong != r || o.cot != c)) coThayDoi = true;
        o.dong = r;
        o.cot = c;
        luoi[r][c] = o;
      }
    }

    // O bi gop truot toi vi tri cua o giu lai.
    for (final (biGop, giu) in capGop) {
      biGop.dong = giu.dong;
      biGop.cot = giu.cot;
      cacOBiGop.add(biGop);
    }
    return coThayDoi || capGop.isNotEmpty;
  }

  /// Toa do cac o cua mot hang/cot, xep tu canh ma cac o se don ve.
  List<(int, int)> _layToaDo(HuongDi huong, int chiSo) => switch (huong) {
        HuongDi.trai => [for (int j = 0; j < soCot; j++) (chiSo, j)],
        HuongDi.phai => [for (int j = soCot - 1; j >= 0; j--) (chiSo, j)],
        HuongDi.len => [for (int i = 0; i < soDong; i++) (i, chiSo)],
        HuongDi.xuong => [for (int i = soDong - 1; i >= 0; i--) (i, chiSo)],
      };

  /// Don cac o co so ve dau hang, gop hai o ke nhau bang nhau (moi o chi gop 1 lan).
  /// Tra ve hang moi (cung do dai); cac cap gop duoc ghi vao [capGop].
  List<OSo> donVaGopHang(List<OSo> hang, List<(OSo, OSo)> capGop) {
    final coSo = hang.where((o) => !o.laTrong()).toList();
    final ketQua = <OSo>[];

    int index = 0;
    while (index < coSo.length) {
      final o = coSo[index];
      if (index + 1 < coSo.length && o.giaTri == coSo[index + 1].giaTri) {
        o.giaTri *= 2;
        capGop.add((coSo[index + 1], o));
        ketQua.add(o);
        index += 2;
      } else {
        ketQua.add(o);
        index++;
      }
    }
    while (ketQua.length < hang.length) {
      ketQua.add(OSo());
    }
    return ketQua;
  }

  bool kiemTraXemCoTheDiChuyen() {
    for (int i = 0; i < soDong; i++) {
      for (int j = 0; j < soCot; j++) {
        if (luoi[i][j].laTrong()) return true;
        if (j + 1 < soCot && luoi[i][j].giaTri == luoi[i][j + 1].giaTri) return true;
        if (i + 1 < soDong && luoi[i][j].giaTri == luoi[i + 1][j].giaTri) return true;
      }
    }
    return false;
  }

  bool soSanhVoi(BangDau bangKhac) {
    for (int i = 0; i < soDong; i++) {
      for (int j = 0; j < soCot; j++) {
        if (luoi[i][j].giaTri != bangKhac.luoi[i][j].giaTri) return false;
      }
    }
    return true;
  }

  BangDau saoChep() {
    final bangMoi = BangDau(soDong: soDong, soCot: soCot);
    for (int i = 0; i < soDong; i++) {
      for (int j = 0; j < soCot; j++) {
        bangMoi.luoi[i][j].giaTri = luoi[i][j].giaTri;
      }
    }
    return bangMoi;
  }
}
