import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'tiles.dart';
import 'tiles_config.dart';

class Tile extends StatelessWidget {
  final Widget? child;

  const Tile({super.key, this.child, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double width = 450.0;
        double height = this.height ?? 150.0;

        final config = TilesConfig.maybeOf(context);
        final configSpacing = config?.spacing;
        final spacing = configSpacing ?? Tiles.spacing;
        int count = config?.count ?? 2;

        double widgetWidth = sizingInformation.localWidgetSize.width;
        double fullWidth = widgetWidth;

        if (sizingInformation.isDesktop) {
          width = (fullWidth - (spacing * (count - 1))) / (count);
        } else if (sizingInformation.isMobile) {
          width = fullWidth;
        } else {
          if (count > 2) {
            count--;
            width = (fullWidth - (spacing * (count - 1))) / (count);
          } else {
            width = fullWidth;
          }
        }

        return SizedBox(
          width: width,
          height: height,
          child: child,
        );
      },
    );
  }
}
