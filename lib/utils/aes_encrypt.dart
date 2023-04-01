import 'package:encrypt/encrypt.dart';

class AESEncrypt {
  final encrypter = Encrypter(AES(Key.fromUtf8("r4u7x!A%D*G-KaNd")));
  final iv = IV.fromUtf8("cRfUjXn2r5u8x/A?");

  String encrypt(String txt) => encrypter.encrypt(txt, iv: iv).base64;

  String decrypt(String txt) => encrypter.decrypt64(txt, iv: iv);
}
