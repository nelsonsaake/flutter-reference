import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';

import 'container_styles.dart';

class ReportContainerStyles {
  static const borderRadiusValue = 15.0;

  // optical correction
  static const borderedPhotoBorderRadiusValue = borderRadiusValue - 2;

  static final borderedPhotoBorderRadius =
      BorderRadius.circular(borderedPhotoBorderRadiusValue);

  static final singleBorderedPhotoBorderRadius =
      borderedPhotoBorderRadius.topLeft;

  static double get borderWidth => 2.0;

  static Color get borderColor => AppColors.dark;

  static Border get border => Border.all(
        color: AppColors.dark,
        width: borderWidth,
        style: BorderStyle.solid,
      );

  static BoxDecoration get decoFlat => BoxDecoration(
        color: Colors.transparent,
        border: border,
        borderRadius: ContainerStyles.borderRadius,
      );

  static BorderSide get borderSide => border.right;
}
