import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheWithSharedPreferences<T> {
  final String key;

  CacheWithSharedPreferences(this.key)
      : assert(
          T == int || T == bool || T == double || T == String,
          'T must be int, bool, double, or String',
        );

  SharedPreferences? _s;

  initSharedPreferences() async {
    try {
      _s = await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint("error initializing shared preferences: $e");
    }
  }

  SharedPreferences? get s {
    if (_s == null) initSharedPreferences();
    return _s;
  }

  T? _data;

  _set(T? v) async {
    switch (T) {
      case int:
        s?.setInt(key, v as int);
        break;
      case bool:
        s?.setBool(key, v as bool);
        break;
      case double:
        s?.setDouble(key, v as double);
        break;
      case String:
        s?.setString(key, v as String);
        break;
    }
  }

  set(T? v) {
    try {
      if (v == null) return;
      _data = v;
      _set(v);
    } catch (e) {
      debugPrint("error setting '$key' to '$v': $e");
    }
  }

  T? _get() {
    T? data;
    switch (T) {
      case int:
      case bool:
      case double:
      case String:
        data = s?.get(key) as T;
    }
    return data;
  }

  T? get() {
    try {
      if (_data == null) {
        set(_get());
      }
    } catch (e) {
      debugPrint("error getting '$key': $e");
    }
    return _data;
  }
}
