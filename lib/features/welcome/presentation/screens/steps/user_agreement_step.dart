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

          // === Блок пользовательского соглашения ===
          Expanded(
            child: Container(
              // Тень + фон + скругление
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
              clipBehavior: Clip.antiAlias, // чтобы контент не выходил за рамки скругления
              child: Padding(
                padding: const EdgeInsets.all(10), // внутренний отступ 10px
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      // Текст локализован (подставь правильный ключ)
                      'lorem ipsum',
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
