import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/core/widgets/bottom_sheet_scaffold.dart';
import 'package:skma_smartapp/core/widgets/btn_center_fill.dart';
import 'package:skma_smartapp/generated/l10n.dart';

class LoginSheet extends StatefulWidget {
  const LoginSheet({super.key});

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  bool _obscure = true;

  InputDecoration _dec(BuildContext context, String label, {Widget? suffix}) {
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
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final brand = Theme.of(context).extension<BrandColors>()!;

    return BottomSheetScaffold(
      title: s.login,
      children: [
        TextField(
          decoration: _dec(context, s.email),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.username, AutofillHints.email],
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: _dec(
            context,
            s.password,
            suffix: IconButton(
              tooltip: 'Show',
              icon: Icon(
                _obscure ? PhosphorIconsRegular.eye : PhosphorIconsRegular.eyeSlash,
                color: brand.main,
              ),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
          obscureText: _obscure,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
        ),
        const SizedBox(height: 16),
        BtnCenterFill(text: s.login, onPressed: () {}),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(s.close),
        ),
      ],
    );
  }
}
