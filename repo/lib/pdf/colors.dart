import 'package:pdf/pdf.dart';

PdfColor _c(String color) {
  return PdfColor.fromHex(color);
}

class PdfColors2 {
  static final green = _c("00965E");
  static final red = _c("D32F2F");
  static final blue = _c("2962FF");
  static final gold = _c("DAA520");
  static final darkBrown = _c("654321");
  static final darkCoffee = _c("4B3621");
  static final dark = _c("333333");
}
