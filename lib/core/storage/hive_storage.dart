import 'package:hive_flutter/hive_flutter.dart';
import 'keys.dart';

class HiveStorage {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(StorageKeys.settingsBox);
  }

  Box get settingsBox => Hive.box(StorageKeys.settingsBox);
}