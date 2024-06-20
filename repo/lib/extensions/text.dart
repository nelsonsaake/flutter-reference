import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semper_web/app_resources/app_colors.dart';

extension TextExt on Text {
  Text copyWith({
    TextStyle? style,
    TextAlign? align,
    bool? softWrap,
    int? maxLines,
  }) {
    return Text(
      data ?? "",
      style: style ?? this.style,
      textAlign: align ?? textAlign,
      softWrap: softWrap,
      maxLines: maxLines,
    );
  }

  TextStyle get style {
    return this.style ?? const TextStyle();
  }

  Text bold() {
    return copyWith(
      style: style.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Text green() {
    return copyWith(
      style: style.copyWith(color: AppColors.green),
    );
  }

  Text red() {
    return copyWith(
      style: style.copyWith(color: AppColors.red),
    );
  }

  Text blue() {
    return copyWith(
      style: style.copyWith(color: AppColors.blue),
    );
  }

  Text cream() {
    return copyWith(
      style: style.copyWith(color: AppColors.cream),
    );
  }

  Text colorLight() {
    return copyWith(
      style: style.copyWith(color: AppColors.textLight),
    );
  }

  Text dark() {
    return color(AppColors.textDark);
  }

  Text link() {
    return color(Colors.blueAccent);
  }

  Text darker() {
    return color(AppColors.dark);
  }

  Text size(double? s) {
    return copyWith(
      style: style.copyWith(fontSize: s),
    );
  }

  Text color(c) {
    Color? cc = style.color;

    if (c is Color || c is Color?) {
      cc = c;
    } else if (c is int) {
      cc = Color(c);
    }

    return copyWith(
      style: style.copyWith(color: cc),
    );
  }

  Text white() {
    return color(Colors.white);
  }

  Text black() {
    return color(Colors.black);
  }

  Text weight(fw) {
    var fw0 = FontWeight.normal;

    if (fw is FontWeight) {
      fw0 = fw;
    } else if (fw is int) {
      switch (fw) {
        case 100:
          fw0 = FontWeight.w100;
          break;
        case 200:
          fw0 = FontWeight.w200;
          break;
        case 300:
          fw0 = FontWeight.w300;
          break;
        case 400:
          fw0 = FontWeight.w400;
          break;
        case 500:
          fw0 = FontWeight.w500;
          break;
        case 600:
          fw0 = FontWeight.w600;
          break;
        case 700:
          fw0 = FontWeight.w700;
          break;
        case 800:
          fw0 = FontWeight.w800;
          break;
        case 900:
          fw0 = FontWeight.w900;
          break;
      }
    }

    return copyWith(
      style: style.copyWith(fontWeight: fw0),
    );
  }

  Text ellipsis({int? maxLines}) {
    return copyWith(
      maxLines: maxLines,
      style: style.copyWith(
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Text wrap() {
    return copyWith(
      softWrap: true,
    );
  }

  Text align(TextAlign align) {
    return copyWith(
      align: align,
    );
  }

  Text center() {
    return copyWith(
      align: TextAlign.center,
    );
  }

  Text left() {
    return copyWith(
      align: TextAlign.left,
    );
  }

  Text right() {
    return copyWith(
      align: TextAlign.right,
    );
  }

  Text justify() {
    return copyWith(
      align: TextAlign.justify,
    );
  }

  Text h(double lh) {
    return copyWith(
      style: style.copyWith(height: lh),
    );
  }

  Text italic() {
    return copyWith(
      style: style.copyWith(fontStyle: FontStyle.italic),
    );
  }

  Text rem(double ratio) {
    double? fs = style.fontSize;

    if (fs != null) {
      fs *= ratio;
      return size(fs);
    }

    return this;
  }

  Text letterSpacing(double sp) {
    return copyWith(
      style: style.copyWith(
        letterSpacing: sp,
        wordSpacing: sp * 2,
      ),
    );
  }

  Text wordSpacing(double sp) {
    return copyWith(
      style: style.copyWith(wordSpacing: sp),
    );
  }

  Text cursive() {
    return copyWith(
      style: style.copyWith(
        fontFamily: GoogleFonts.greatVibes().fontFamily,
      ),
    );
  }

  Text cursive2() {
    return copyWith(
      style: style.copyWith(
        fontFamily: GoogleFonts.sacramento().fontFamily,
      ),
    );
  }

  Text cursive3() {
    return copyWith(
      style: style.copyWith(
        fontFamily: GoogleFonts.stalemate().fontFamily,
      ),
    );
  }

  Text anton() {
    return copyWith(
      style: style.copyWith(
        fontFamily: GoogleFonts.anton().fontFamily,
      ),
    );
  }

  Text ff(String? f) {
    if (f == null) return this;

    return copyWith(
      style: style.copyWith(
        fontFamily: f,
      ),
    );
  }

  Text underline() {
    return copyWith(
      style: style.copyWith(
        decoration: TextDecoration.underline,
      ),
    );
  }
}
