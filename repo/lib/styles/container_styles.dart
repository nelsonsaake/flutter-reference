import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';

class ContainerStyles {
  static const borderRadiusValue = 15.0;

  static final borderRadius = BorderRadius.circular(borderRadiusValue);

  static const shadow = [
    BoxShadow(
      blurRadius: 4,
      offset: Offset(0, 2),
      color: Color.fromRGBO(0, 0, 0, 0.12),
    ),
  ];

  static const _borderColor = Color(0xFFDEDBDB);

  static const borderWidth = 1.0;

  static const borderSide = BorderSide(
    width: borderWidth,
    color: _borderColor,
  );

  static const rightBorder = Border(
    right: borderSide,
  );

  static const leftBorder = Border(
    left: borderSide,
  );

  static const bottomBorder = Border(
    bottom: borderSide,
  );

  static final border = Border.all(
    width: borderWidth,
    color: _borderColor,
  );

  static final borderSilver = Border.all(
    width: borderWidth,
    color: AppColors.silver,
  );

  static final borderGray = Border.all(
    width: borderWidth,
    color: AppColors.gray,
  );

  static final borderDark = Border.all(
    width: borderWidth,
    color: AppColors.dark,
  );

  static final borderGrayO1 = Border.all(
    width: borderWidth,
    color: AppColors.gray01,
  );

  static BoxDecoration get deco => BoxDecoration(
        color: AppColors.cream,
        border: border,
        boxShadow: shadow,
        borderRadius: borderRadius,
      );

  static BoxDecoration get decoFlat => BoxDecoration(
        color: AppColors.cream,
        border: border,
        borderRadius: borderRadius,
      );

  static BoxDecoration get decoGray => BoxDecoration(
        color: AppColors.gray01,
        border: border,
        boxShadow: shadow,
        borderRadius: borderRadius,
      );

  static BoxDecoration get decoGrayFlat => BoxDecoration(
        color: AppColors.gray01,
        border: border,
        borderRadius: borderRadius,
      );

  static BoxDecoration get decoFlatCircle => const BoxDecoration(
        color: AppColors.cream,
        shape: BoxShape.circle,
      );

  static BoxDecoration get rightBorderOnlyDeco => const BoxDecoration(
        border: rightBorder,
      );

  static BoxDecoration get leftBorderOnlyDeco => const BoxDecoration(
        border: leftBorder,
      );

  static BoxDecoration get borderOnlyDeco => BoxDecoration(
        border: border,
      );

  static BoxDecoration get bottomBorderOnlyDeco => const BoxDecoration(
        border: bottomBorder,
      );

  static BoxDecoration get shadowOnly => BoxDecoration(
        color: AppColors.cream,
        borderRadius: borderRadius,
        boxShadow: ContainerStyles.shadow,
      );
}
