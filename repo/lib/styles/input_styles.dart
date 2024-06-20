import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/widgets/text/div.dart';

class InputStyles {
   static final shadow = [
    BoxShadow(
      offset: const Offset(1, 1),
      blurRadius: 10,
      color: Colors.black.withOpacity(0.16),
    ),
  ];

  static final borderRadius = BorderRadius.circular(10.0);

  static const borderWidth = 4.0;

  static const borderWidthDisabled = 1.0;

  static final border = Border.all(
    color: Colors.transparent,
    width: borderWidth,
  );

  static final borderDisabled = Border.all(
    color: AppColors.textLighter,
    width: borderWidthDisabled,
  );

  static const focusColor = Color(0xff4AC99B);

  static final focusedBorder = Border.all(
    color: focusColor,
    width: borderWidth,
  );

  static const double height = 70.0;

  static final textStyle = const Div("").style?.copyWith(color: AppColors.text);

  static final labelTextStyle = const Div("").style;

  static final decoration = BoxDecoration(
    color: AppColors.cream,
    boxShadow: InputStyles.shadow,
    border: InputStyles.border,
    borderRadius: InputStyles.borderRadius,
  );

  static const constraints = BoxConstraints(
    maxWidth: double.maxFinite,
    minHeight: InputStyles.height,
  );
}
