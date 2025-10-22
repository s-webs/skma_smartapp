import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

class LanguageOptionButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  const LanguageOptionButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon = PhosphorIconsRegular.translate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>()!;

    final Color border = brand.main;
    final Color bg = selected ? brand.main : brand.bgHalftone;
    final Color fg = selected ? theme.colorScheme.onPrimary : brand.textHeading;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              Icon(icon, color: fg, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
