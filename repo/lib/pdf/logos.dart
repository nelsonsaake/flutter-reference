import 'package:pdf/widgets.dart' as pw;
import 'package:semper_web/pdf/utils.dart';
import 'package:semper_web/pdf/widgets.dart';
import 'package:semper_web/app_resources/app_assets.dart';
import 'package:semper_web/app_resources/app_colors.dart';

Future<pw.Widget> pwSemperLogo() async {
  return pw.Column(children: [
    // logo
    await pwImage(
      AppAssets.logo,
      height: 30,
    ),

    // spacing
    pwSpace(8),

    // app name
    pwText(
      "Semper",
      color: pdfColor(AppColors.green),
      weight: pw.FontWeight.bold,
    ),
  ]);
}
