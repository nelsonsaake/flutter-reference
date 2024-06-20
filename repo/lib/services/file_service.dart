import 'dart:io';

import 'package:flutter/foundation.dart';

class FileService {
  String _makeErrorMessage(String msg, dynamic error) {
    final errMsgBuf = StringBuffer();

    debugPrint("$msg:");
    if (error is FileSystemException) {
      debugPrint("path: ${error.path}");
      debugPrint(error.message);
      debugPrint(error.osError?.message);
      errMsgBuf.writeln(error.osError?.message);
    } else {
      debugPrint(error);
      errMsgBuf.writeln("something went wrong");
    }

    return errMsgBuf.toString();
  }

  bool doesFileExists(String path) {
    return File(path).existsSync();
  }

  void createFileIfNotExists(String path) {
    try {
      if (!doesFileExists(path)) File(path).createSync(recursive: true);
    } catch (e) {
      throw _makeErrorMessage("error creating file...", e);
    }
  }

  void updateFile(String path, String content) {
    try {
      File(path).writeAsStringSync(content);
    } catch (e) {
      throw _makeErrorMessage("error updating file...", e);
    }
  }

  String readFile(String path) {
    String content = "";
    try {
      content = File(path).readAsStringSync();
    } catch (e) {
      throw _makeErrorMessage("error reading file...", e);
    }
    return content;
  }
}
