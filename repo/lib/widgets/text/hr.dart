import 'package:flutter/material.dart';
import 'package:semper_web/widgets/text/line.dart';

class Hr extends StatelessWidget {
  const Hr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Line(
      widthFactor: 0.9,
      height: 0.47,
      color: Color(0xFF5E5C5C),
    );
  }
}
