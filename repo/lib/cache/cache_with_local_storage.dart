import 'package:localstorage/localstorage.dart';

class CacheWithLocalStorage<T> {
  CacheWithLocalStorage(this.key)
      : assert(
          T == int || T == bool || T == double || T == String,
          'T must be int, bool, double, or String',
        );

  final String key;

  final LocalStorage _s = LocalStorage('cache.json');


  set(T? data) {
    switch (T) {
      case int:
      case bool:
      case double:
      case String:
        _s.setItem(
          key,
          data.toString(),
        );
    }
  }

  T? get() {
    final v = _s.getItem(key) ;
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
