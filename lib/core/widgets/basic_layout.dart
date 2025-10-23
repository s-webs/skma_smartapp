// core/widgets/basic_layout.dart
import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BasicLayout extends StatelessWidget {
  const BasicLayout({
    super.key,
    required this.body,
    this.currentIndex = 0,
    required this.onTabSelected,
    this.onMenuPressed,
    this.onNotificationsPressed,
    this.onSettingsPressed,
    this.onAvatarPressed,
    this.notifications = 0,
    this.avatar,
  });

  /// Контент экрана
  final Widget body;

  /// Индекс выбранной вкладки: 0..3 (лево 2 и право 2, аватар не таб)
  final int currentIndex;

  /// Колбек при тапе по иконке нижнего бара
  final ValueChanged<int> onTabSelected;

  /// Экшены верхней панели
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onSettingsPressed;

  /// Тап по аватару
  final VoidCallback? onAvatarPressed;

  /// Количество уведомлений для бэйджа
  final int notifications;

  /// Картинка аватара (если null — иконка)
  final ImageProvider? avatar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>()!;
    final main = brand?.main ?? const Color(0xFF7A34F4);

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [brand.bgPrimary, brand.bgHalftone],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // BODY
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 72, 16, 120),
                  child: body,
                ),
              ),

              // TOP BAR (pill)
              Positioned(
                left: 10,
                right: 10,
                top: 10,
                child: _TopBar(
                  color: main,
                  notifications: notifications,
                  onMenuPressed: onMenuPressed,
                  onNotificationsPressed: onNotificationsPressed,
                  onSettingsPressed: onSettingsPressed,
                ),
              ),

              // BOTTOM BAR с аватаром
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _BottomBar(
                  color: main,
                  selected: currentIndex,
                  onTap: onTabSelected,
                  onAvatarPressed: onAvatarPressed,
                  avatar: avatar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.color,
    required this.notifications,
    this.onMenuPressed,
    this.onNotificationsPressed,
    this.onSettingsPressed,
  });

  final Color color;
  final int notifications;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 4),
          IconButton(
            onPressed: onMenuPressed,
            icon: Icon(PhosphorIconsRegular.list),
            color: Colors.white,
            splashRadius: 22,
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onNotificationsPressed,
                icon: Icon(PhosphorIconsRegular.bell),
                color: Colors.white,
                splashRadius: 22,
              ),
              if (notifications > 0)
                Positioned(
                  right: 2,
                  bottom: 6,
                  child: _Badge(count: notifications),
                ),
            ],
          ),
          IconButton(
            onPressed: onSettingsPressed,
            icon: Icon(PhosphorIconsRegular.gear),
            color: Colors.white,
            splashRadius: 22,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final text = count > 99 ? '99+' : '$count';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          height: 1.0,
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.color,
    required this.selected,
    required this.onTap,
    this.avatar,
    this.onAvatarPressed,
  });

  final Color color;
  final int selected;
  final ValueChanged<int> onTap;
  final ImageProvider? avatar;
  final VoidCallback? onAvatarPressed;

  static const _barHeight = 72.0;
  static const _avatarSize = 80.0;

  Color _iconColor(int index) =>
      selected == index ? Colors.white : Colors.white.withOpacity(.7);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: _barHeight + _avatarSize / 2 + 8,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // сам бар
            Container(
              height: _barHeight,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    // левая пара
                    _NavIcon(
                      icon: PhosphorIconsRegular.house,
                      color: _iconColor(0),
                      onTap: () => onTap(0),
                    ),
                    const SizedBox(width: 25),
                    _NavIcon(
                      icon: PhosphorIconsRegular.rss,
                      color: _iconColor(1),
                      onTap: () => onTap(1),
                    ),
                    const Spacer(),
                    // правая пара
                    _NavIcon(
                      icon: PhosphorIconsRegular.calendarDots,
                      color: _iconColor(2),
                      onTap: () => onTap(2),
                    ),
                    const SizedBox(width: 25),
                    _NavIcon(
                      icon: PhosphorIconsRegular.question,
                      color: _iconColor(3),
                      onTap: () => onTap(3),
                    ),
                  ],
                ),
              ),
            ),

            // аватар по центру с перекрытием
            Positioned(
              bottom: _barHeight - _avatarSize / 2,
              child: GestureDetector(
                onTap: onAvatarPressed,
                child: Container(
                  width: _avatarSize,
                  height: _avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.15),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundImage: avatar,
                        child: avatar == null
                            ? const Icon(Icons.person_outline, size: 36)
                            : null,
                      ),
                    ),
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

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      color: color,
      splashRadius: 26,
    );
  }
}
