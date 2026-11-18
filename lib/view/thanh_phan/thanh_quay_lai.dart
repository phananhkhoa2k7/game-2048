import 'package:flutter/material.dart';

import '../dich_vu_am_thanh.dart';
import '../theme/kieu_chu.dart';

class ThanhQuayLai extends StatelessWidget {
  final String tieuDe;
  const ThanhQuayLai({super.key, required this.tieuDe});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () {
              DichVuAmThanh.phatClick();
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
          Text(tieuDe, style: KieuChu.trang(32)),
        ],
      );
}
