import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'notification_badge.dart';

class BasicTopBar extends StatelessWidget {
  const BasicTopBar({
    super.key,
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
      height: 60,
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
                const SizedBox.shrink(),
              if (notifications > 0)
                Positioned(
                  right: 2,
                  bottom: 6,
                  child: NotificationBadge(count: notifications),
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
