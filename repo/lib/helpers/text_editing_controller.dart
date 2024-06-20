import 'package:flutter/material.dart';

extension SetNullableText on TextEditingController {
  void setNullableText(String? text) {
    this.text = text ?? this.text;
  }
}
