import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:skma_smartapp/generated/l10n.dart';
import 'package:skma_smartapp/core/widgets/btn_center_fill.dart';
import 'package:skma_smartapp/core/widgets/btn_center_outlined.dart';
import 'package:skma_smartapp/features/welcome/presentation/widgets/login_sheet.dart';
import 'package:skma_smartapp/features/welcome/presentation/widgets/register_sheet.dart';
import 'package:skma_smartapp/features/welcome/presentation/widgets/recover_sheet.dart';

class AuthStep extends ConsumerWidget {
  const AuthStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    void _openSheet(Widget child) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => child,
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40),
          // Шапка
          Container(
            height: 140,
            color: brand.main,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/skma_smart_app_logo.png', width: 245),
              ],
            ),
          ),

          const Spacer(),

          // Кнопки
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BtnCenterFill(
                  text: S.of(context).login,
                  onPressed: () => _openSheet(const LoginSheet()),
                ),
                const SizedBox(height: 16),
                BtnCenterOutlined(
                  text: S.of(context).register,
                  onPressed: () => _openSheet(const RegisterSheet()),
                ),
                const SizedBox(height: 12),
                BtnCenterOutlined(
                  text: S.of(context).recoverThePassword,
                  onPressed: () => _openSheet(const RecoverSheet()),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
