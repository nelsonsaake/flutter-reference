import 'package:semper_web/cache/cache_with_session_storage.dart';

class CacheWithWriteEncryptionCore<T> extends CacheWithSessionStorage<T> {
  CacheWithWriteEncryptionCore(super.key)
      : assert(
          T == int || T == bool || T == double || T == String,
          'T must be int, bool, double, or String',
        );
}