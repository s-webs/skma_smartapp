import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

/// Индикатор прогресса-«таблетки»
/// [length] — сколько шагов всего
/// [index]  — текущий шаг (0..length-1)
class DotsIndicator extends StatelessWidget {
  final int length;
  final int index;

  /// Кастомизация
  final double activeWidth;
  final double inactiveWidth;
  final double height;
  final double spacing;
  final Duration duration;
  final Curve curve;
  final Color? activeColor;
  final Color? inactiveColor;

  const DotsIndicator({
    super.key,
    required this.length,
    required this.index,
    this.activeWidth = 140,
    this.inactiveWidth = 40,
    this.height = 12,
    this.spacing = 4,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOut,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>();

    final Color active = activeColor ?? brand?.main ?? theme.colorScheme.primary;
    final Color inactive =
        inactiveColor ?? (brand?.bgHalftone ?? theme.colorScheme.primary);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: duration,
          curve: curve,
          margin: EdgeInsets.symmetric(horizontal: spacing),
          height: height,
          width: isActive ? activeWidth : inactiveWidth,
          decoration: BoxDecoration(
            color: isActive ? active : inactive,
            borderRadius: BorderRadius.circular(height),
          ),
        );
      }),
    );
  }
}
