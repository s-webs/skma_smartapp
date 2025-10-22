import 'package:flutter/material.dart';
import 'brand_colors.dart';

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF853BFF)),
    );

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFFF5EFFF), // bgPrimary
      dividerColor: const Color(0xFFE2E2E2),            // line
      textTheme: base.textTheme.copyWith(
        // Основной текст чёрный, второстепенный — secondary
        bodyLarge:   base.textTheme.bodyLarge?.copyWith(color: const Color(0xFF11111B)),
        bodyMedium:  base.textTheme.bodyMedium?.copyWith(color: const Color(0xFF11111B)),
        bodySmall:   base.textTheme.bodySmall?.copyWith(color: const Color(0xFF9492B6)),
        titleLarge:  base.textTheme.titleLarge?.copyWith(color: const Color(0xFF11111B)),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(color: const Color(0xFF11111B)),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        BrandColors.light,
      ],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Color(0xFF11111B),
      ),
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF9C6DFF),
        brightness: Brightness.dark,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF1A1625),
      dividerColor: const Color(0xFF3A3A3A),
      extensions: const <ThemeExtension<dynamic>>[
        BrandColors.dark,
      ],
    );
  }
}
