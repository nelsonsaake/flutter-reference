import 'package:semper_web/cache/cache_with_write_encryption_core.dart';
import 'package:semper_web/encryption/encryption.dart';

class CacheWithWriteEncryption<T>{
  final CacheWithWriteEncryptionCore<String> cache;
  
  CacheWithWriteEncryption(String key): cache = CacheWithWriteEncryptionCore<String>(key);

  set(T? data){
     switch (T) {
      case int:
      case bool:
      case double:
      case String:
        cache.set(
          encrypt(
            data.toString(),
          )
        );
    }
  }
  
  T? get(){
    final data = cache.get();
    
    if(data == null) return null;
    
    final v = decrypt(data); 
          
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
