import 'package:semper_web/cache/cache_with_write_encryption.dart';

class Cache<T> extends CacheWithWriteEncryption<T> {
  Cache(super.key)
      : assert(
          T == int || T == bool || T == double || T == String,
          'T must be int, bool, double, or String',
        );
}
