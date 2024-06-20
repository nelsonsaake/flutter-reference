import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:semper_web/widgets/text/p/p_mobile.dart';
import 'package:semper_web/widgets/text/p/p_tablet_desktop.dart';

class P extends StatelessWidget {
  final String p;
  final TextAlign align;

  const P(
    this.p, {
    Key? key,
    this.align = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => PMobile(p, align: align),
      tablet: (context) => PTabletDesktop(p, align: align),
    );
  }
}
