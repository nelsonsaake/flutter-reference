import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double x;
  final double y;

  const Space(double space, {super.key})
      : x = space,
        y = space;

  const Space.y(double space, {super.key})
      : x = 0,
        y = space;

  const Space.x(double space, {super.key})
      : x = space,
        y = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: y,
      width: x,
    );
  }
}
