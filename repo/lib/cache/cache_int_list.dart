import 'dart:convert';

import 'package:semper_web/cache/cache_with_write_encryption.dart';

class CacheIntList {
  final CacheWithWriteEncryption<String> _json;

  CacheIntList(String key) : _json = CacheWithWriteEncryption<String>(key);

  List<int>? _data;

  set(List<int>? v) {
    if (v == null) return;
    _data = v;
    _json.set(jsonEncode(v));
  }

  List<int>? get() {
    try {
      if (_data != null) return _data;

      final str = _json.get();
      if (str == null) return null;

      final v = jsonDecode(str);

      _data ??= v;
      return _data;
    } catch (e) {
      //..
    }
    return null;
  }
}
