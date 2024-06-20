import 'package:intl/intl.dart';

String formatNumber(int? number, [String def = ""]){
  if(number == null) return def;
  return NumberFormat("#,###").format(number);
}