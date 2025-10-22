import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/language_option_button.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/generated/l10n.dart';
import 'package:skma_smartapp/app/localization/locale_provider.dart';

class ChooseLanguageStep extends ConsumerWidget {
  const ChooseLanguageStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>()!;
    final locale = ref.watch(appLocaleProvider);
    final notifier = ref.read(appLocaleProvider.notifier);

    final locales = S.delegate.supportedLocales;
    final order = const ['kk', 'ru', 'en'];
    final ordered = [
      for (final code in order) ...locales.where((l) => l.languageCode == code),
    ];

    String labelFor(Locale l) => switch (l.languageCode) {
      'kk' => 'Қазақ тілі',
      'ru' => 'Русский язык',
      'en' => 'English language',
      _    => l.languageCode,
    };

    void setLocale(Locale l) => notifier.setLocale(l);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text(
                S.of(context).pleaseChooseLanguage,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: brand.textSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: brand.bgHalftone,
              ),
              child: Icon(PhosphorIconsRegular.globe, size: 72, color: brand.main),
            ),
          ),
          const Spacer(),
          for (final l in ordered) ...[
            LanguageOptionButton(
              label: labelFor(l),
              selected: locale.languageCode == l.languageCode,
              onTap: () => setLocale(l),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
