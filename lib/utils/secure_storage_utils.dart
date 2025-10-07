import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _getIosOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await _storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }
  
  static Future<void> readData({
    required String key,
  }) async {
    await _storage.read(
      key: key,
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  
  static Future<void> deleteAllData({
    required String key,
    required String value,
  }) async {
    await _storage.deleteAll(
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }
}
