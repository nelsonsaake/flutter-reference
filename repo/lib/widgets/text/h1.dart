import 'package:flutter/material.dart';
import 'package:semper_web/archetypes/font_sizes.dart';
import 'package:semper_web/extensions/text.dart';

class H1 extends StatelessWidget {
  final String h1;
  final TextAlign? align;

  const H1(this.h1, {Key? key, this.align}) : super(key: key);
  const H1.center(this.h1, {Key? key}) : align = TextAlign.center, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      h1,
      textAlign: align,
    ).size(FontSizes.tabletHeader).green().weight(600);
  }
}
