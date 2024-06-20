import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Uint8List? getBytes(FilePickerResult? v) {
  return v?.files.first.bytes;
}

String getBase64(FilePickerResult v) {
  return base64Encode(v.files.first.bytes ?? []);
}

String? getPath(FilePickerResult? v) {
  return v?.files.first.path;
}

String? getName(FilePickerResult? v) {
  return v?.files.first.name;
}
