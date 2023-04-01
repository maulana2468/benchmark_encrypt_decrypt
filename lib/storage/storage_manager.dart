import 'package:benchmark_encrypt_decrypt/utils/aes_encrypt.dart';
import 'package:get_storage/get_storage.dart';

class StorageManager {
  final _storage1 = GetStorage("storage1");
  final _storage2 = GetStorage("storage2");
  final _aesEncrypt = AESEncrypt();

  Future<void> deleteAll() async {
    for (var i = 0; i < 5; i++) {
      await _storage1.remove(i.toString());
      await _storage2.remove(i.toString());
    }
  }

  //* READ
  dynamic getData(String nameLoc) {
    return _storage1.read(nameLoc);
  }

  dynamic getDataEncrypt(String nameLoc) {
    return _aesEncrypt.decrypt(_storage2.read(nameLoc));
  }

  //* WRITE
  Future<void> saveData(String nameLoc, String value) async {
    await _storage1.write(nameLoc, value);
  }

  Future<void> saveDataEncrypt(String nameLoc, String value) async {
    await _storage2.write(nameLoc, _aesEncrypt.encrypt(value));
  }
}
