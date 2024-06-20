import 'package:get_storage/get_storage.dart';

class CacheWithGetStorage<T> {
  CacheWithGetStorage(this.key)
      : assert(
          T == int || T == bool || T == double || T == String,
          'T must be int, bool, double, or String',
        ) {
    init();
  }

  final String key;

  static bool _isInit = false;

  static Future _initGetStorage() async {
    _isInit = await GetStorage.init();
  }

  static Future init() async {
    if (_isInit) return;
    await _initGetStorage();
  }

  GetStorage? get _box {
    if (!_isInit) {
      init();
      return null;
    }
    return GetStorage();
  }

  set(T? data) {
    switch (T) {
      case int:
      case bool:
      case double:
      case String:
        _box?.write(
          key,
          data.toString(),
        );
    }
  }

  T? get() {
    final v = _box?.read(key);
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
