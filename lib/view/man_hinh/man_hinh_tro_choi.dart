import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/quan_ly_tro_choi.dart';
import '../../model/cai_dat.dart';
import '../../model/huong_di.dart';
import '../../model/trang_thai_tro_choi.dart';
import '../dich_vu_am_thanh.dart';
import '../theme/kieu_chu.dart';
import '../theme/mau_sac.dart';
import '../thanh_phan/bang_dau_view.dart';
import '../thanh_phan/lang_nghe.dart';
import '../thanh_phan/lop_phu.dart';
import '../thanh_phan/nut_vien_thuoc.dart';

class ManHinhTroChoi extends StatefulWidget {
  final QuanLyTroChoi quanLy;
  const ManHinhTroChoi({super.key, required this.quanLy});

  @override
  State<ManHinhTroChoi> createState() => _ManHinhTroChoiState();
}

class _ManHinhTroChoiState extends State<ManHinhTroChoi> {
  final _focus = FocusNode();
  QuanLyTroChoi get _ql => widget.quanLy;

  static final Map<LogicalKeyboardKey, HuongDi> _phim = {
    LogicalKeyboardKey.arrowUp: HuongDi.len,
    LogicalKeyboardKey.keyW: HuongDi.len,
    LogicalKeyboardKey.arrowDown: HuongDi.xuong,
    LogicalKeyboardKey.keyS: HuongDi.xuong,
    LogicalKeyboardKey.arrowLeft: HuongDi.trai,
    LogicalKeyboardKey.keyA: HuongDi.trai,
    LogicalKeyboardKey.arrowRight: HuongDi.phai,
    LogicalKeyboardKey.keyD: HuongDi.phai,
  };

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _diChuyen(HuongDi huong) {
    if (!_ql.diChuyen(huong)) return;
    if (_ql.trangThai == TrangThaiTroChoi.ketThuc) {
      DichVuAmThanh.phatThua();
    } else {
      DichVuAmThanh.phatClick();
    }
  }

  KeyEventResult _khiNhanPhim(FocusNode node, KeyEvent e) {
    if (e is KeyUpEvent) return KeyEventResult.ignored;
    if (e.logicalKey == LogicalKeyboardKey.escape) {
      if (e is KeyDownEvent) _ql.doiTamDung();
      return KeyEventResult.handled;
    }
    final huong = _phim[e.logicalKey];
    if (huong == null) return KeyEventResult.ignored;
    if (e is KeyDownEvent) _diChuyen(huong);
    return KeyEventResult.handled;
  }

  void _khiVuot(DragEndDetails d) {
    final v = d.velocity.pixelsPerSecond;
    if (v.distance < 200) return;
    _diChuyen(v.dx.abs() > v.dy.abs()
        ? (v.dx > 0 ? HuongDi.phai : HuongDi.trai)
        : (v.dy > 0 ? HuongDi.xuong : HuongDi.len));
  }

  Widget _noiDung() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: NutVienThuoc(
              nhan: '',
              bieuTuong: Icons.pause,
              rong: 90,
              cao: 44,
              coChu: 26,
              khiNhan: _ql.doiTamDung,
            ),
          ),
          const SizedBox(height: 8),
          Text('Best score: ${_ql.diemCaoNhat}', style: KieuChu.trang(20, khoangChu: 3)),
          const SizedBox(height: 14),
          Text('Score: ${_ql.diemHienTai}', style: KieuChu.trang(20, khoangChu: 3)),
          const SizedBox(height: 14),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: _ql.bangDau.soCot / _ql.bangDau.soDong, // 4x4 -> o vuong
                child: BangDauView(bangDau: _ql.bangDau),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: MauSac.vang,
        body: Focus(
          focusNode: _focus,
          autofocus: true,
          onKeyEvent: _khiNhanPhim,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanEnd: _khiVuot,
            child: LangNghe(
              doiTuong: [_ql, CaiDat.instance],
              xayDung: (context) {
                final trangThai = _ql.trangThai;
                return Stack(
                  children: [
                    SafeArea(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Padding(padding: const EdgeInsets.all(20), child: _noiDung()),
                        ),
                      ),
                    ),
                    if (trangThai == TrangThaiTroChoi.tamDung)
                      Positioned.fill(
                        child: LopPhu(
                          khiNhanNen: _ql.doiTamDung,
                          children: [
                            NutVienThuoc(
                                nhan: 'Paused', rong: 300, cao: 110, coChu: 40, khiNhan: _ql.doiTamDung),
                            const SizedBox(height: 20),
                            NutVienThuoc(nhan: 'Menu', khiNhan: () => Navigator.pop(context)),
                          ],
                        ),
                      ),
                    if (trangThai == TrangThaiTroChoi.ketThuc)
                      Positioned.fill(
                        child: LopPhu(
                          children: [
                            const NutVienThuoc(nhan: 'Game Over', rong: 300, cao: 110, coChu: 36),
                            const SizedBox(height: 20),
                            NutVienThuoc(nhan: 'Retry', khiNhan: _ql.batDau),
                            const SizedBox(height: 16),
                            NutVienThuoc(nhan: 'Menu', khiNhan: () => Navigator.pop(context)),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );
}
