import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_strings.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/widgets/text/div.dart';

class ByLine extends StatelessWidget {
  const ByLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const byLine = "Powered by ${AppString.semper}, 2021";
    // "Powered by ${AppString.semper}, Inc. © 2021";
    return const Div(byLine).center().rem(0.9);
  }
}
