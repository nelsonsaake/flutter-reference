import 'package:flutter/material.dart';
import 'package:semper_web/archetypes/font_sizes.dart';
import 'package:semper_web/extensions/text.dart';

class PMobile extends StatelessWidget {
  final String p;
  final TextAlign align;

  const PMobile(
    this.p, {
    Key? key,
    this.align = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(p).size(FontSizes.mobileParagraph).align(align);
  }
}
