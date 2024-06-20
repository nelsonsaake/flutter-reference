import 'package:flutter/material.dart';
import 'package:semper_web/styles/input_styles.dart';
import 'container_styles.dart';

class ButtonStyles {
   static RoundedRectangleBorder get rounded => RoundedRectangleBorder(
        borderRadius: InputStyles.borderRadius,
      );

  static RoundedRectangleBorder get roundedlg => RoundedRectangleBorder(
        borderRadius: ContainerStyles.borderRadius,
      );

  static RoundedRectangleBorder get roundedZero => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      );

  static BorderSide get border => ContainerStyles.borderSide;
}
