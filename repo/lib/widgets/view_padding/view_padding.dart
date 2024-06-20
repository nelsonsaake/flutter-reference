import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ViewPaddingBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    EdgeInsets padding,
  ) builder;

  const ViewPaddingBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      EdgeInsets padding = sizingInfo.isDesktop
          ? const EdgeInsets.all(64).copyWith(top: 32)
          : const EdgeInsets.all(16).copyWith(top: 32);
      return builder(context, padding);
    });
  }
}

class ViewPadding extends StatelessWidget {
  final Widget? child;
  const ViewPadding({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ViewPaddingBuilder(builder: (context, padding) {
      return Container(
        padding: padding,
        child: child,
      );
    });
  }
}
