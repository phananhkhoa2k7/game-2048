import 'package:flutter/material.dart';

import '../../model/doi_tuong_quan_sat.dart';

/// Ve lai widget moi khi mot trong cac Model/Controller bao co thay doi.
class LangNghe extends StatefulWidget {
  final List<DoiTuongQuanSat> doiTuong;
  final Widget Function(BuildContext context) xayDung;

  const LangNghe({super.key, required this.doiTuong, required this.xayDung});

  @override
  State<LangNghe> createState() => _LangNgheState();
}

class _LangNgheState extends State<LangNghe> {
  void _capNhat() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (final d in widget.doiTuong) {
      d.themNguoiNghe(_capNhat);
    }
  }

  @override
  void dispose() {
    for (final d in widget.doiTuong) {
      d.xoaNguoiNghe(_capNhat);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.xayDung(context);
}
