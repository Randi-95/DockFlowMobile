import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage{
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async{
      return await _storage.write(key: 'token', value: token);
  }

  static Future<String?> readToken() async{
    return await _storage.read(key: 'token');
  }

  static Future<void> saveUserId(String userId) async {
    return await _storage.write(key: 'user_id', value: userId);
  }

  static Future<String?> readUserId() async {
    return await _storage.read(key: 'user_id');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user_id');
  }
}