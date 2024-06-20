import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius = 0.95;
  final double? widthFactor;

  const Line({
    Key? key,
    double width = 48.24,
    this.height = 3.78,
    this.color = const Color(0XFFC64756),
    this.widthFactor,
  })  : width = (widthFactor == null) ? width : double.infinity,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget line = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    if (widthFactor != null) {
      line = FractionallySizedBox(
        widthFactor: widthFactor,
        child: line,
      );
    }

    return line;
  }
}

