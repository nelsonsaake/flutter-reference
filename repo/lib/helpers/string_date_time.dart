DateTime? stringToDateTime(String? s) {
  try {
    return DateTime.parse(s!);
  } catch (e) {
    return null;
  }
}

String dateTimeToString(DateTime dt) {
  return dt.toUtc().toIso8601String();
}
