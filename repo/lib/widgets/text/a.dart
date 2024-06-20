import 'package:flutter/material.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/widgets/text/div.dart';

class A extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const A(
    this.label, {
    Key? key,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Div(label).green().color(color),
    );
  }
}
