import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'dart:typed_data';

String bytesToString(Uint8List bytes){
  return base64.encode(bytes);
}

Uint8List stringToBytes(String string){
  return base64.decode(string);
}

String encrypt(String plainText) {
  final Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
  return bytesToString(encrypted.bytes);
}

String decrypt(String encryptedText) {
  final Encrypted encrypted = Encrypted(stringToBytes(encryptedText));
  return encrypter.decrypt(encrypted, iv: iv);
}

Encrypter get encrypter => Encrypter(AES(key));

const secretKey = '95627fa3-d8c3-4c0f-ba5e-f74792ad';
Key get key => Key.fromUtf8(secretKey);

const initializationVector = "6e3a68a7-8f6b-40";
IV get iv => IV.fromUtf8(initializationVector);






