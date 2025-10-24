import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/theme/brand_colors.dart';

import 'basic_top_bar.dart';
import 'basic_bottom_bar.dart';
import 'app_sidebar.dart';

class BasicLayout extends StatefulWidget {
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
  State<BasicLayout> createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _handleMenuPressed() {
    // Сначала даём шанс внешнему обработчику (если он есть),
    // затем гарантированно открываем Drawer.
    widget.onMenuPressed?.call();
    _openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<BrandColors>();
    final main = brand?.main ?? const Color(0xFF7A34F4);

    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: AppSidebar(
        onClose: () => Navigator.of(context).pop(),
      ),
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
                  padding: const EdgeInsets.fromLTRB(16, 72, 16, 120),
                  child: widget.body,
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 10,
                child: BasicTopBar(
                  color: main,
                  notifications: widget.notifications,
                  onMenuPressed: _handleMenuPressed,
                  onNotificationsPressed: widget.onNotificationsPressed,
                  onSettingsPressed: widget.onSettingsPressed,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BasicBottomBar(
                  color: main,
                  selected: widget.currentIndex,
                  onTap: widget.onTabSelected,
                  onAvatarPressed: widget.onAvatarPressed,
                  avatar: widget.avatar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
