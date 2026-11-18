import 'package:flutter/material.dart';

class LopPhu extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? khiNhanNen;
  const LopPhu({super.key, required this.children, this.khiNhanNen});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: khiNhanNen,
        child: Container(
          color: Colors.black54,
          alignment: Alignment.center,
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      );
}
