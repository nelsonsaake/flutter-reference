import 'package:hive_flutter/hive_flutter.dart';

class CacheWithHive<T> {
  CacheWithHive(this.key)
      : assert(
          T == int || T == bool || T == double || T == String,
          'T must be int, bool, double, or String',
        );

  final String key;

  final _s = Hive.box('cache');

  set(T? data) {
    switch (T) {
      case int:
      case bool:
      case double:
      case String:
        _s.put(key, data.toString());
    }
  }

  T? get() {
    final v = _s.get(key);
    if (v == null) return null;
    switch (T) {
      case int:
        return int.tryParse(v) as T?;
      case bool:
        return bool.tryParse(v) as T?;
      case double:
        return double.tryParse(v) as T?;
      case String:
        return v as T?;
      default:
        return null;
    }
  }
}
