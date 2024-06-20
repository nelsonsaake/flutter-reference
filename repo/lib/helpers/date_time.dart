import 'package:intl/intl.dart';

DateTime get now => DateTime.now();

DateTime? toDate(String? str) {
  if (str == null) return null;
  return DateTime.parse(str);
}

bool isDatePast(DateTime date) {
  return date.isBefore(now);
}

DateTime? maybeDate(String? date) {
  return DateTime.tryParse(date ?? "");
}

bool isDateStringPast(String? date) {
  return maybeDate(date)?.isBefore(now) ?? false;
}

String dateVerb(DateTime? date, String past, String future) {
  if (date == null) return "";
  if (date.isBefore(now)) return past;
  return future;
}

String formatDateTime(DateTime? dateTime, [String separator = ", "]) {
  if (dateTime == null) return "";

  final date = DateFormat("d MMM, y").format(dateTime);
  final time = DateFormat("jm").format(dateTime).toLowerCase();

  return "$date$separator$time";
}

String formatDateTimeString(String? dateTimeStr) {
  if (dateTimeStr == null) return "";
  return formatDateTime(DateTime.parse(dateTimeStr), ". ");
}

final DateTime firstValidDate = DateTime(2000);

bool isValidDateString(String? v) {
  if (v == null) return false;

  final d = DateTime.tryParse(v);
  if (d == null) return false;

  return d.isAfter(firstValidDate);
}
