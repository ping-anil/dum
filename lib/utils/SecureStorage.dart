import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _secureStorage = FlutterSecureStorage();

  static Future saveMnemonic(String password, String mnemonic) async{
    await _secureStorage.write(key: password, value: mnemonic);
    await _secureStorage.write(key: "keySaved", value: "yes");
  }

  static void clearStorage() async{
    await _secureStorage.deleteAll();
  }

  static Future<String?> getSavedMnemonic(String key) async =>
      await _secureStorage.read(key: key);

  static Future<bool> doesHaveMnemonic() async{
    String? mnemonicSaved = await getSavedMnemonic("keySaved");
    if(mnemonicSaved.toString() == "yes"){
      return true;
    }else{
      return false;
    }
  }


}
