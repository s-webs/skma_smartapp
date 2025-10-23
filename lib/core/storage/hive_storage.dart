import 'package:hive_flutter/hive_flutter.dart';
import 'keys.dart';

class HiveStorage {
  Future<void> init() async {
    await Hive.initFlutter();
    await _ensureBoxOpened(StorageKeys.settingsBox);
    await _ensureBoxOpened(StorageKeys.authBox); // ВАЖНО: бокс для токена
  }

  Future<void> _ensureBoxOpened(String name) async {
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox(name);
    }
  }

  Box get settingsBox => Hive.box(StorageKeys.settingsBox);
  Box get authBox     => Hive.box(StorageKeys.authBox);
}
