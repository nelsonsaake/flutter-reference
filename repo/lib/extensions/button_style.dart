import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';

extension ButtonStyleExt on ButtonStyle {
  ButtonStyle bg(Color color) {
    return copyWith(
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all(color),
    );
  }

  ButtonStyle noPad() {
    return copyWith(
      padding: MaterialStateProperty.all(
        EdgeInsets.zero,
      ),
    );
  }

  ButtonStyle pd({double h = 0.0, double v = 0.0}) {
    return copyWith(
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: v, horizontal: h),
      ),
    );
  }

  ButtonStyle br(double rad) {
    return copyWith(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rad),
        ),
      ),
    );
  }

  ButtonStyle ms(double w, double h) {
    return copyWith(
      minimumSize: MaterialStateProperty.all(Size(w, h)),
    );
  }

  ButtonStyle size(double w, double h) {
    return copyWith(
      fixedSize: MaterialStateProperty.all(Size(w, h)),
    );
  }

  ButtonStyle maxSize(double w, double h) {
    return copyWith(
      maximumSize: MaterialStateProperty.all(Size(w, h)),
    );
  }

  ButtonStyle green() {
    return bg(AppColors.green);
  }

  ButtonStyle circle() {
    return copyWith(
      shape: MaterialStateProperty.all(const CircleBorder()),
    );
  }

  ButtonStyle border({Color color = Colors.transparent, double size = 0}) {
    return copyWith(
      side: MaterialStateProperty.all(
        BorderSide(
          color: color,
          width: size,
        ),
      ),
    );
  }

  ButtonStyle fgColor({Color color = Colors.transparent}) {
    return copyWith(
      foregroundColor: MaterialStateProperty.all(color),
    );
  }
}
