import 'package:intl/intl.dart';

String formatPrice(double? amount) {
  if (amount == null) return "";
  NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
  String formattedNumber = formatter.format(amount);
  return "GH₵$formattedNumber";
}

String formatPriceWithoutCurrency(double? amount) {
  if (amount == null) return "";
  NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(amount);
}

String get currency => "GH₵";
