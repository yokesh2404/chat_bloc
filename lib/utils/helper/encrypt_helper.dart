import 'package:encrypt/encrypt.dart';
import 'package:state_management/utils/contants/encryption_keys.dart';

class EncryptHelper {
  static Encrypted? encrypted;
  static var decrypted;
  static encryptAES(plainText) {
    final key = Key.fromUtf8(EncryptionKeys.encryptionKey);
    final iv = IV.fromBase64(EncryptionKeys.encryptionIV);
    final encrypter = Encrypter(AES(
      key,
    ));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted!.base64;
  }

  static decryptAES(plainText) {
    final key = Key.fromUtf8(EncryptionKeys.encryptionKey);
    final iv = IV.fromBase64(EncryptionKeys.encryptionIV);
    final encrypter = Encrypter(AES(
      key,
    ));
    decrypted = encrypter.decrypt64(plainText, iv: iv);
    return decrypted;
  }
}
