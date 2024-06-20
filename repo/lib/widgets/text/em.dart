import 'package:flutter/material.dart';
import 'package:semper_web/archetypes/font_sizes.dart';
import 'package:semper_web/extensions/text.dart';

class Em extends StatelessWidget {
  final String em;
  const Em(this.em, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(em).size(FontSizes.tabletEm).bold();
  }
}
