import 'package:flutter/material.dart';
import '../../../../core/theme/brand_colors.dart';

class WelcomeSlide extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? bottom;

  const WelcomeSlide({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: brand.bgHalftone,              // было: primary.withOpacity(.08)
            ),
            child: Icon(icon, size: 80, color: brand.main), // было: colorScheme.primary
          ),
          const SizedBox(height: 28),

          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: brand.textHeading,              // чёткий цвет заголовка
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: brand.textSecondary,            // вторичный текст
              height: 1.4,
            ),
          ),

          if (bottom != null) ...[
            const SizedBox(height: 16),
            bottom!,
          ],
        ],
      ),
    );
  }
}
