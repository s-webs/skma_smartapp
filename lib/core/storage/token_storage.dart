import 'package:hive_flutter/hive_flutter.dart';
import 'keys.dart';

class TokenStorage {
  static bool get _isOpen => Hive.isBoxOpen(StorageKeys.authBox);

  static String? read(String key) {
    if (!_isOpen) return null; // не падаем в интерсепторе до init()
    final v = Hive.box(StorageKeys.authBox).get(key);
    return v is String ? v : null;
  }

  static Future<void> write(String key, String token) async {
    if (!_isOpen) await Hive.openBox(StorageKeys.authBox);
    await Hive.box(StorageKeys.authBox).put(key, token);
  }

  static Future<void> clear(String key) async {
    if (_isOpen) {
      await Hive.box(StorageKeys.authBox).delete(key);
    }
  }
}
