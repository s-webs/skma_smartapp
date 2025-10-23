import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

class BtnCenterFill extends StatelessWidget {
  const BtnCenterFill({
    super.key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.height = 63,
    this.radius = 15,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
    this.textStyle,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  final double height;
  final double radius;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? (onPressed ?? () {}) : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: brand.main,
          foregroundColor: brand.bgHalftone,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: contentPadding,
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return brand.main.withOpacity(0.35);
            }
            return brand.main;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return brand.bgHalftone.withOpacity(0.8);
            }
            return brand.bgHalftone;
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
