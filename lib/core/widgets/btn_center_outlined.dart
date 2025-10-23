import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

class BtnCenterOutlined extends StatelessWidget {
  const BtnCenterOutlined({
    super.key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.height = 63,
    this.radius = 15,
    this.borderWidth = 3,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
    this.textStyle,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  final double height;
  final double radius;
  final double borderWidth;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: enabled ? (onPressed ?? () {}) : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: brand.main, width: borderWidth),
          backgroundColor: brand.bgPrimary,
          foregroundColor: brand.main,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: contentPadding,
        ).copyWith(
          side: MaterialStateProperty.resolveWith((states) {
            final color = states.contains(MaterialState.disabled)
                ? brand.main.withOpacity(0.35)
                : brand.main;
            return BorderSide(color: color, width: borderWidth);
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled)
                ? brand.main.withOpacity(0.6)
                : brand.main;
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled)
                ? brand.bgPrimary
                : brand.bgPrimary;
          }),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ?? const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }
}
