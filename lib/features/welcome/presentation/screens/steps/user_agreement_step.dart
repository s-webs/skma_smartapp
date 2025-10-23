import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/generated/l10n.dart';

class UserAgreementStep extends ConsumerWidget {
  const UserAgreementStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>()!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text(
                S.of(context).userAgreement,
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      // Текст соглашения
                      '1.10. Политика конфиденциальности – документ, регулирующий цели, способы и порядок получения, обработки и хранения информации о Пользователе для предоставления доступа к Мобильному приложению, заключения настоящего Соглашения, а также для заключения и исполнения Договора аренды ТС. Политика конфиденциальности размещена в Мобильном приложении и на Интернет-сайте. 1.11. Регистрация Пользователя – совершение Пользователем и Компанией определенного в настоящем Соглашении набора действий, направленного на создание в Мобильном приложении Учетной записи Пользователя с целью его идентификации среди других Пользователей Мобильного приложения и получения Пользователем доступа к функционалу Мобильного приложения. Контент, вся информация о Пользователе, Учетной записи Пользователя, зарегистрированного в мобильном приложении «SKMA SmartApp», автоматически',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: brand.textHeading,
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
