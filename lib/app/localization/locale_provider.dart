import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skma_smartapp/generated/l10n.dart';

import '../di/global_providers.dart';
import '../../core/storage/hive_storage.dart';
import '../../core/storage/keys.dart';

class AppLocaleNotifier extends Notifier<Locale> {
  late final HiveStorage _storage;

  @override
  Locale build() {
    _storage = ref.read(hiveStorageProvider);

    final saved = _storage.settingsBox.get(StorageKeys.locale) as String?;
    final supported = S.delegate.supportedLocales;             // <— ТАК

    if (saved != null) {
      return supported.firstWhere(
            (l) => l.languageCode == saved,
        orElse: () => const Locale('en'),
      );
    }

    final deviceCode = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return supported.firstWhere(
          (l) => l.languageCode == deviceCode,
      orElse: () => const Locale('en'),
    );
  }

  Future<void> setLocale(Locale locale) async {
    if (state == locale) return;
    state = locale;
    await _storage.settingsBox.put(StorageKeys.locale, locale.languageCode);
  }
}

final appLocaleProvider =
NotifierProvider<AppLocaleNotifier, Locale>(AppLocaleNotifier.new);
