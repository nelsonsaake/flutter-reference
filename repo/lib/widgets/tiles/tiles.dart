import 'package:flutter/material.dart';

import 'tiles_config.dart';

class Tiles extends StatelessWidget {
  final List<Widget>? children;

  const Tiles({super.key, this.children});

  static const spacing = 32.0;

  @override
  Widget build(BuildContext context) {
    final spacing = TilesConfig.maybeOf(context)?.spacing ?? Tiles.spacing;
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children ?? [],
      ),
    );
  }
}
