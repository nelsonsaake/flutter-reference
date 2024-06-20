import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:download/download.dart';

void downloadBytesWebv1(Uint8List bytes, String fileName) {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  // ignore: unused_local_variable
  final anchor = html.AnchorElement(href: url)
    ..target = 'blank'
    ..download = fileName
    ..click();

  html.Url.revokeObjectUrl(url);
}

downloadBytesWeb(Uint8List bytes, String fileName) async {
  final stream = Stream.fromIterable(bytes.toList());
  download(stream, fileName);
}
