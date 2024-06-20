import 'package:flutter/material.dart';

const _borderWidth = 0.5;
const _borderRadius = 10.0;
const _borderColor = Colors.black12;

extension WidgetBorder on Widget {

  Border border(){
    return Border.all(
      color: _borderColor,
      width: _borderWidth,
    );
  }

  BorderRadius borderRadius() {
  return const BorderRadius.all(
      Radius.circular(_borderRadius),
    );
  }

  Widget withBorder() {
    BoxDecoration decoration() {
      return BoxDecoration(
        border: border(),
        borderRadius: borderRadius(),
      );
    }

    return Container(
      decoration: decoration(),
      child: this,
    );
  }
}
