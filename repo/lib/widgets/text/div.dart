import 'package:flutter/material.dart';
import 'package:semper_web/archetypes/font_sizes.dart';
import 'package:semper_web/app_resources/app_colors.dart';

TextStyle divStyle = const Div("").style ?? const TextStyle();

const div = Div("");

class Div extends Text {
  const Div(
    String? div, {
    Key? key,
  }) : super(
          div ?? "",
          key: key,
          style: const TextStyle(
            fontSize: FontSizes.tabletBody,
            color: AppColors.textLight,
            fontWeight: FontWeight.w400,
          ),
        );
}
