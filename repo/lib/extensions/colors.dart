import 'package:flutter/material.dart';

extension AsColor on String {
  Color get asColor {
    String code = replaceAll("#", "0xFF");
    int intCode = int.tryParse(code) ?? 0;
    return Color(intCode);
  }
}
