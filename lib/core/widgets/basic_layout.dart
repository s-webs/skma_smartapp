import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

import 'basic_top_bar.dart';
import 'basic_bottom_bar.dart';

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

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onSettingsPressed;

  final VoidCallback? onAvatarPressed;
  final int notifications;
  final ImageProvider? avatar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>();
    final main = brand?.main ?? const Color(0xFF7A34F4);

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              brand?.bgPrimary ?? const Color(0xFFF4EEFF),
              brand?.bgHalftone ?? const Color(0xFFEDE1FF),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  // отступы под верх/низ панели
                  padding: const EdgeInsets.fromLTRB(16, 72, 16, 120),
                  child: body,
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 10,
                child: BasicTopBar(
                  color: main,
                  notifications: notifications,
                  onMenuPressed: onMenuPressed,
                  onNotificationsPressed: onNotificationsPressed,
                  onSettingsPressed: onSettingsPressed,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BasicBottomBar(
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
