import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:semper_web/app_resources/app_fonts.dart';
import 'package:semper_web/app_resources/app_assets.dart';
import 'package:semper_web/app_resources/app_colors.dart';

// memoryImage
Future<pw.MemoryImage> pwMemoryImage(String image) async {
  final imageBundle = await rootBundle.load(image);
  return pw.MemoryImage(
    imageBundle.buffer.asUint8List(),
  );
}

// memoryImage
Future<pw.Font> pwMemoryFont(String font) async {
  final fontBundle = await rootBundle.load(font);
  return pw.Font.ttf(
    fontBundle.buffer.asByteData(),
  );
}

// write out pdf
Future pwSave(String path, pw.Document pdf) async {
  final file = File(path);
  await file.writeAsBytes(await pwBytes(pdf));
}

//  get bytes
Future<Uint8List> pwBytes(pw.Document pdf) {
  return pdf.save();
}

// colors
PdfColor pdfColor(Color c) {
  return PdfColor.fromInt(c.value);
}

// theme
Future<pw.PageTheme> pwPageTheme() async {
  final image = await pwMemoryImage(AppAssets.watermark);

  final f = await pwMemoryFont(AppFonts.nunitoRegular);
  final fbold = await pwMemoryFont(AppFonts.nunitoBold);

  final background = pw.Opacity(
    opacity: .1,
    child: pw.Container(
      decoration: pw.BoxDecoration(
        color: pdfColor(AppColors.cream),
        image: pw.DecorationImage(
          image: image,
          fit: pw.BoxFit.contain,
        ),
      ),
    ),
  );

  final theme = pw.ThemeData.withFont(
    base: f,
    bold: fbold,
  );

  final pageTheme = pw.PageTheme(
    margin: const pw.EdgeInsets.all(0),
    buildBackground: (context) => background,
    pageFormat: PdfPageFormat.a4,
    theme: theme,
  );

  return pageTheme;
}

const pwAlignStart = "start";
const pwAlignEnd = "end";
const pwAlignCenter = "center";

// get alignment
pw.MainAxisAlignment trMainAxisAlignment(String s) {
  switch (s.toLowerCase().trim()) {
    case pwAlignEnd:
      return pw.MainAxisAlignment.end;
    case pwAlignStart:
      return pw.MainAxisAlignment.start;
    case pwAlignCenter:
      return pw.MainAxisAlignment.center;
    default:
      return pw.MainAxisAlignment.start;
  }
}
