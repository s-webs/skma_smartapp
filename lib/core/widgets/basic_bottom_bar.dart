import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'nav_icon.dart';

class BasicBottomBar extends StatelessWidget {
  const BasicBottomBar({
    super.key,
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
                    NavIcon(
                      icon: PhosphorIconsRegular.house,
                      color: _iconColor(0),
                      onTap: () => onTap(0),
                    ),
                    const SizedBox(width: 25),
                    NavIcon(
                      icon: PhosphorIconsRegular.rss,
                      color: _iconColor(1),
                      onTap: () => onTap(1),
                    ),
                    const Spacer(),
                    NavIcon(
                      icon: PhosphorIconsRegular.calendarDots,
                      color: _iconColor(2),
                      onTap: () => onTap(2),
                    ),
                    const SizedBox(width: 25),
                    NavIcon(
                      icon: PhosphorIconsRegular.question,
                      color: _iconColor(3),
                      onTap: () => onTap(3),
                    ),
                  ],
                ),
              ),
            ),
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
