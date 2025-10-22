import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skma_smartapp/generated/l10n.dart';

import '../../../../app/localization/locale_provider.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = S.of(context);
    final locale = ref.watch(appLocaleProvider);
    final notifier = ref.read(appLocaleProvider.notifier);

    final locales = S.delegate.supportedLocales;               // <— ТАК

    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).hello, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            Text(S.of(context).changelocale),
            const SizedBox(height: 8),
            DropdownButton<Locale>(
              value: locale,
              onChanged: (value) {
                if (value != null) notifier.setLocale(value);
              },
              items: locales.map((l) {
                final label = switch (l.languageCode) {
                  'en' => 'English',
                  'ru' => 'Русский',
                  'kk' => 'Қазақша',
                  _ => l.languageCode,
                };
                return DropdownMenuItem(value: l, child: Text(label));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
