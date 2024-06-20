import 'dart:convert';

import 'package:semper_web/cache/cache_with_write_encryption.dart';
import 'package:semper_web/dio_models/auth_details.dart';

class CacheAuth {
  final CacheWithWriteEncryption<String> _json;

  CacheAuth({String? key})
      : _json = CacheWithWriteEncryption<String>(key ?? "#9");

  AuthDetails? _authDetails;

  set authDetails(AuthDetails? v) {
    if (v == null) return;
    _authDetails = v;
    _json.set(jsonEncode(v.toJson()));
  }

  AuthDetails? get authDetails {
    try {
      if (_authDetails != null) return _authDetails;

      final str = _json.get();
      if (str == null) return null;

      final json = jsonDecode(str);
      final v = AuthDetails.fromJson(json);

      _authDetails ??= v;
      return _authDetails;
    } catch (e) {
      //...
    }
    return null;
  }
}
