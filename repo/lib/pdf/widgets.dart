import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:semper_web/pdf/colors.dart';
import 'package:semper_web/pdf/utils.dart';
import 'package:semper_web/app_resources/app_colors.dart';

Future<List<pw.Widget>> syncls(List<FutureOr<pw.Widget>>? children) async {
  List<pw.Widget> ls = [];

  if (children == null) {
    return ls;
  }

  for (var w in children) {
    ls.add(await w);
  }

  return ls;
}

// pdf text
pw.Widget pwText(
  String text, {
  PdfColor? color,
  pw.Alignment alignment = pw.Alignment.center,
  pw.FontWeight weight = pw.FontWeight.normal,
  double? size,
}) {
  return pw.Align(
    alignment: alignment,
    child: pw.Text(
      text,
      style: pw.TextStyle(
        color: color ?? PdfColors2.dark,
        fontWeight: weight,
        fontSize: size,
      ),
    ),
  );
}

// pdf image
Future<pw.Widget> pwImage(
  String image, {
  final pw.BoxFit fit = pw.BoxFit.contain,
  final pw.Alignment alignment = pw.Alignment.center,
  final double? width,
  final double? height,
  final double? dpi,
}) async {
  return pw.Center(
    child: pw.Image(
      await pwMemoryImage(image),
      alignment: alignment,
      dpi: dpi,
      fit: fit,
      width: width,
      height: height,
    ),
  );
}

// horizontal rule / line
pw.Widget pwHr({color, double? opacity, double? thickness}) {
  if (color is Color) color = pdfColor(color);
  if (color is! Color && color is! PdfColor) color = null;
  return pw.Opacity(
    opacity: opacity ?? .3,
    child: pw.Divider(
      color: color ?? pdfColor(AppColors.textLighter),
      thickness: thickness ?? .5,
    ),
  );
}

// spacing
pw.Widget pwSpace(double spacing) {
  return pw.SizedBox.square(dimension: spacing);
}

// SECTION

// page padding
const horizontalPagePadding = 64.0;

// section name and value
pw.Widget pwSectionNameValue(
  String name,
  String value, {
  bool alignEnd = false,
  bool hasDarkBackground = false,
}) {
  final color = hasDarkBackground ? pdfColor(Colors.white) : null;

  return pw.Padding(
    //...
    padding: const pw.EdgeInsets.symmetric(
      horizontal: horizontalPagePadding,
    ),

    child: pw.Row(
      //...
      mainAxisAlignment:
          alignEnd ? pw.MainAxisAlignment.end : pw.MainAxisAlignment.start,

      children: [
        //...
        pwText("$name:", color: color, weight: pw.FontWeight.bold, size: 10),

        pwSpace(8),

        pwText(value, color: color),
      ],
    ),
  );
}

// section title
pw.Widget pwSectionTitle(String name, {String align = pwAlignStart}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(
      horizontal: horizontalPagePadding,
    ),
    child: pw.Row(
      mainAxisAlignment: trMainAxisAlignment(align),
      children: [
        pwText(
          name,
          color: pdfColor(AppColors.green),
          weight: pw.FontWeight.bold,
        ),
      ],
    ),
  );
}

// section row
Future<pw.Widget> pwSectionRow({
  List<FutureOr<pw.Widget>>? children,
  bool alignEnd = false,
}) async {
  // ls
  List<pw.Widget> ls = await syncls(children);

  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(
      horizontal: horizontalPagePadding,
    ),
    child: pw.Row(
      mainAxisAlignment:
          alignEnd ? pw.MainAxisAlignment.end : pw.MainAxisAlignment.start,
      children: ls,
    ),
  );
}

//  section divideer
pw.Widget pwSectionHr() {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(
      horizontal: horizontalPagePadding,
    ),
    child: pwHr(),
  );
}

// END SECTION

// add page
Future<pw.Document> addPage(
  pw.Document pdf,
  List<FutureOr<pw.Widget>> children,
) async {
  // ls
  List<pw.Widget> ls = await syncls(children);

  // theme
  final theme = await pwPageTheme();

  // add page
  pdf.addPage(
    pw.Page(
      pageTheme: theme,
      build: (pw.Context context) {
        return pw.Column(
          children: ls,
        );
      },
    ),
  );

  return pdf;
}
