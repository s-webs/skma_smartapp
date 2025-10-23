import 'package:flutter/material.dart';
import '../../core/theme/brand_colors.dart';

class BrandButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  /// Иконка слева/справа (опционально)
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  final bool fullWidth;
  final double height;
  final double radius;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;

  const BrandButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = true,
    this.height = 63,
    this.radius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>();

    final bg = backgroundColor ?? brand?.main ?? theme.colorScheme.primary;
    final fg = foregroundColor ?? theme.colorScheme.onPrimary;

    final content = Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, color: fg),
          const SizedBox(width: 12),
        ],

        // Текст всегда занимает максимум, чтобы иконка справа «прижималась»
        Expanded(
          child: Text(
            label,
            textAlign: trailingIcon != null ? TextAlign.left : TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        if (trailingIcon != null) ...[
          const SizedBox(width: 12),
          Icon(trailingIcon, color: fg),
        ],
      ],
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: bg.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: (onPressed != null && !isLoading) ? onPressed : null,
            child: Padding(
              padding: padding,
              child: Center(
                child: isLoading
                    ? SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor: AlwaysStoppedAnimation(fg),
                        ),
                      )
                    : content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
