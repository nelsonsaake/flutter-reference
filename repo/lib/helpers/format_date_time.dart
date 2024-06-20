import 'package:intl/intl.dart';

String formatTime(String? startStr) {
  if (startStr == null) return "";

  final start = DateTime.parse(startStr);
  final startDate = DateFormat("d MMM, y").format(start);
  final startTime = DateFormat("jm").format(start);

  return "$startDate - $startTime";
}
