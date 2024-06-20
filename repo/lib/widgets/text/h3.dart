import 'package:flutter/material.dart';
import 'package:semper_web/archetypes/font_sizes.dart';
import 'package:semper_web/extensions/text.dart';

class H3 extends StatelessWidget {
  final String h3;
  const H3(this.h3, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(h3).size(FontSizes.tabletH3).green().weight(700);
  }
}
