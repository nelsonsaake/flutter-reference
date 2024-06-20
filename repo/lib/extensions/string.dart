import 'dart:io';

extension SetNullable on String {
  Future<bool> isDir() {
    return Directory(this).exists();
  }

  bool isDirSync() {
    return Directory(this).existsSync();
  }

  Future<bool> isFile() {
    return File(this).exists();
  }

  bool isFileSync() {
    return File(this).existsSync();
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
}
