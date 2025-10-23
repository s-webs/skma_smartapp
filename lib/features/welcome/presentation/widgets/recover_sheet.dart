import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/core/widgets/bottom_sheet_scaffold.dart';
import 'package:skma_smartapp/core/widgets/btn_center_fill.dart';
import 'package:skma_smartapp/generated/l10n.dart';

class RecoverSheet extends StatelessWidget {
  const RecoverSheet({super.key});

  InputDecoration _dec(BuildContext context, String label) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: brand.main.withOpacity(.35), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: brand.main, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetScaffold(
      title: S.of(context).recoverThePassword,
      children: [
        TextField(decoration: _dec(context, S.of(context).email)),
        const SizedBox(height: 16),
        BtnCenterFill(text: S.of(context).send, onPressed: () {}),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).close),
        ),
      ],
    );
  }
}
