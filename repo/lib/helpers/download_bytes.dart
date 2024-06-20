import 'dart:typed_data';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

 downloadBytes(Uint8List bytes, String fileName) async {
  final Directory? downloadsDir = await getDownloadsDirectory();
  final filePath = p.join(downloadsDir?.path ?? "", fileName);
  final file = File(filePath);
  await file.writeAsBytes(bytes);
}

