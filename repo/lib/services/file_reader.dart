import 'dart:async' show Future;

import 'package:flutter/services.dart' show rootBundle;

// filename as specified in pubspec
Future<String> readFile(String filename) async {
  return await rootBundle.loadString(filename);
}
