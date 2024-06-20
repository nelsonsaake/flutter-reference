import 'package:flutter/material.dart';
import 'package:semper_web/archetypes/font_sizes.dart';
import 'package:semper_web/extensions/column.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/widgets/text/line.dart';

class H2TabletDesktop extends StatelessWidget {
  final String h2;

  const H2TabletDesktop(this.h2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(h2).green().weight(700).center().size(FontSizes.tabletHeader),
        const Line(width: 100),
      ],
    ).spacing(3);
  }
}
