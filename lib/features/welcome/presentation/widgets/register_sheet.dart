import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/core/widgets/bottom_sheet_scaffold.dart';
import 'package:skma_smartapp/core/widgets/btn_center_fill.dart';
import 'package:skma_smartapp/generated/l10n.dart';

class RegisterSheet extends StatefulWidget {
  const RegisterSheet({super.key});

  @override
  State<RegisterSheet> createState() => _RegisterSheetState();
}

class _RegisterSheetState extends State<RegisterSheet> {
  bool _obscure1 = true;
  bool _obscure2 = true;
  String? _gender; // 'male' | 'female'

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
      title: s.register,
      children: [
        TextField(
          decoration: _dec(context, s.fullName),
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
        ),
        const SizedBox(height: 12),

        // Email
        TextField(
          decoration: _dec(context, s.email),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
        ),
        const SizedBox(height: 12),

        // Пол (муж/жен)
        DropdownButtonFormField<String>(
          value: _gender,
          items: [
            DropdownMenuItem(value: 'male', child: Text(S.of(context).male)),
            DropdownMenuItem(value: 'female', child: Text(S.of(context).female)),
          ],
          onChanged: (v) => setState(() => _gender = v),
          decoration: _dec(context, S.of(context).chooseYourGender),
        ),
        const SizedBox(height: 12),

        // Пароль
        TextField(
          decoration: _dec(
            context,
            s.password,
            suffix: IconButton(
              tooltip: 'Show',
              icon: Icon(
                _obscure1 ? PhosphorIconsRegular.eye : PhosphorIconsRegular.eyeSlash,
                color: brand.main,
              ),
              onPressed: () => setState(() => _obscure1 = !_obscure1),
            ),
          ),
          obscureText: _obscure1,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.newPassword],
        ),
        const SizedBox(height: 12),

        // Повтор пароля
        TextField(
          decoration: _dec(
            context,
            s.repeatPassword,
            suffix: IconButton(
              tooltip: 'Show',
              icon: Icon(
                _obscure2 ? PhosphorIconsRegular.eye : PhosphorIconsRegular.eyeSlash,
                color: brand.main,
              ),
              onPressed: () => setState(() => _obscure2 = !_obscure2),
            ),
          ),
          obscureText: _obscure2,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.newPassword],
        ),
        const SizedBox(height: 16),

        BtnCenterFill(text: s.register, onPressed: () {
          // TODO: использовать _gender, значения полей и т.д.
        }),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(s.close),
        ),
      ],
    );
  }
}
