import 'package:flutter/material.dart';
import 'package:semper_web/archetypes/font_sizes.dart';
import 'package:semper_web/extensions/text.dart';

class PTabletDesktop extends StatelessWidget {
  final String p;
  final TextAlign align;

  const PTabletDesktop(
    this.p, {
    Key? key,
    this.align = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(p).size(FontSizes.tabletBody).align(align);
  }
}
