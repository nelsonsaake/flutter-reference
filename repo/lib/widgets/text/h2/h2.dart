import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:semper_web/widgets/text/h2/h2_mobile.dart';
import 'package:semper_web/widgets/text/h2/h2_tablet_desktop.dart';

class H2 extends StatelessWidget {
  final String h2;

  const H2(this.h2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => H2Mobile(h2),
      tablet: (context) => H2TabletDesktop(h2),
    );
  }
}
