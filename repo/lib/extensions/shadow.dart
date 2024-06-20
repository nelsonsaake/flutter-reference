import 'package:flutter/material.dart';

extension WidgetShadow on Widget {
  Widget withShadow() {
    const shadowColor = Colors.black12;

    const shadowBlurRadius = 5.0;

    const shadowOffset = Offset(-4.0, 2.0);

    BoxShadow boxShadow() {
      return const BoxShadow(
        color: shadowColor,
        offset: shadowOffset,
        blurRadius: shadowBlurRadius,
      );
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [boxShadow()],
      ),
      child: this,
    );
  }
}
