import 'package:flutter/material.dart';

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  final Color bgHalftone;   // EADDFF
  final Color bgPrimary;    // F5EFFF
  final Color textHeading;  // 11111B
  final Color textSecondary;// 9492B6
  final Color main;         // 853BFF
  final Color line;         // E2E2E2

  const BrandColors({
    required this.bgHalftone,
    required this.bgPrimary,
    required this.textHeading,
    required this.textSecondary,
    required this.main,
    required this.line,
  });

  /// Светлая палитра (из твоей картинки)
  static const BrandColors light = BrandColors(
    bgHalftone: Color(0xFFEADDFF),
    bgPrimary:  Color(0xFFF5EFFF),
    textHeading: Color(0xFF11111B),
    textSecondary: Color(0xFF9492B6),
    main:        Color(0xFF853BFF),
    line:        Color(0xFFE2E2E2),
  );

  /// На первое время можно оставить такой же сет для тёмной темы
  static const BrandColors dark = BrandColors(
    bgHalftone: Color(0xFF3C2F4F),
    bgPrimary:  Color(0xFF1A1625),
    textHeading: Color(0xFFF3F3F6),
    textSecondary: Color(0xFFB7B6CF),
    main:        Color(0xFF9C6DFF),
    line:        Color(0xFF3A3A3A),
  );

  @override
  BrandColors copyWith({
    Color? bgHalftone,
    Color? bgPrimary,
    Color? textHeading,
    Color? textSecondary,
    Color? main,
    Color? line,
  }) {
    return BrandColors(
      bgHalftone: bgHalftone ?? this.bgHalftone,
      bgPrimary: bgPrimary ?? this.bgPrimary,
      textHeading: textHeading ?? this.textHeading,
      textSecondary: textSecondary ?? this.textSecondary,
      main: main ?? this.main,
      line: line ?? this.line,
    );
  }

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      bgHalftone: Color.lerp(bgHalftone, other.bgHalftone, t)!,
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      textHeading: Color.lerp(textHeading, other.textHeading, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      main: Color.lerp(main, other.main, t)!,
      line: Color.lerp(line, other.line, t)!,
    );
  }
}
