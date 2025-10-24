import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = Theme.of(context).extension<BrandColors>()!;
    final text = theme.textTheme;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: brand.main,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      child: Icon(PhosphorIconsRegular.user),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Ivanov Ivan Ivanovich',
                        style: TextStyle(color: brand.bgPrimary, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Divider(height: 1, color: brand.main),
            ),
            SizedBox(height: 15),
            // Items
            Expanded(
              child: ListView(
                children: [
                  _Tile(
                    icon: PhosphorIconsRegular.house,
                    title: 'Главная',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  _Tile(
                    icon: PhosphorIconsRegular.userCircle,
                    title: 'Профиль',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  _Tile(
                    icon: PhosphorIconsRegular.gear,
                    title: 'Настройки',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  _Tile(
                    icon: PhosphorIconsRegular.info,
                    title: 'О приложении',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: brand.main,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'v1.0.0',
                    style: text.bodySmall?.copyWith(color: brand.bgPrimary),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final radius = BorderRadius.circular(8);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListTile(
        onTap: onTap,
        dense: true,
        title: Text(
          title,
          style: TextStyle(
            color: brand.main,
            fontSize: 14,
          ),
        ),
        trailing: Icon(icon, color: brand.main, size: 20),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: selected ? const Color(0xFF2F80ED) : brand.main, // синяя рамка при selected
            width: 2,
          ),
        ),
        tileColor: brand.bgPrimary,
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
    );
  }
}
