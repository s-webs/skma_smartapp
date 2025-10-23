import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/core/widgets/bottom_sheet_scaffold.dart';
import 'package:skma_smartapp/core/widgets/btn_center_fill.dart';
import 'package:skma_smartapp/generated/l10n.dart';
import '../controllers/login_controller.dart';
import 'dart:developer' as dev;

class LoginSheet extends ConsumerStatefulWidget {
  const LoginSheet({super.key});

  @override
  ConsumerState<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends ConsumerState<LoginSheet> {
  bool _obscure = true;
  late final TextEditingController _emailC;
  late final TextEditingController _passC;

  @override
  void initState() {
    super.initState();
    _emailC = TextEditingController();
    _passC = TextEditingController();
  }

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

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

  Future<void> _onLogin() async {
    final email = _emailC.text.trim();
    final password = _passC.text;

    dev.log('[LoginSheet] tap LOGIN', name: 'auth');

    if (email.isEmpty || password.isEmpty) {
      dev.log('[LoginSheet] validation failed: empty fields', name: 'auth');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    try {
      dev.log('[LoginSheet] call controller.login()', name: 'auth', error: {
        'email': email,
        'deviceName': 'skma_app',
      });

      await ref.read(loginControllerProvider.notifier).login(
        email: email,
        password: password,
        deviceName: 'skma_app',
      );
    } catch (e, st) {
      // на случай непойманных ошибок выше
      dev.log('[LoginSheet] unexpected error while login()',
          name: 'auth', error: e, stackTrace: st);
    }

    final state = ref.read(loginControllerProvider);
    dev.log(
      '[LoginSheet] state after login -> '
          '${state.hasError ? 'error' : state.isLoading ? 'loading' : 'data'}',
      name: 'auth',
    );

    if (state.hasError) {
      final msg = state.error?.toString() ?? 'Login failed';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    }

    if (!mounted) return;
    context.goNamed('home');
  }


  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final brand = Theme.of(context).extension<BrandColors>()!;
    final state = ref.watch(loginControllerProvider);
    final isLoading = state.isLoading;

    return BottomSheetScaffold(
      title: s.login,
      children: [
        TextField(
          controller: _emailC,
          decoration: _dec(context, s.email),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.username, AutofillHints.email],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passC,
          decoration: _dec(
            context,
            s.password,
            suffix: IconButton(
              tooltip: _obscure ? 'Show' : 'Hide',
              icon: Icon(
                _obscure ? PhosphorIconsRegular.eye : PhosphorIconsRegular.eyeSlash,
                color: brand.main,
              ),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
          obscureText: _obscure,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => isLoading ? null : _onLogin(),
          autofillHints: const [AutofillHints.password],
        ),
        const SizedBox(height: 16),
        BtnCenterFill(
          text: isLoading ? 'Loading' : s.login,
          onPressed: isLoading ? null : _onLogin,
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(s.close),
        ),
      ],
    );
  }
}
