import 'package:flutter/material.dart';
import 'package:skma_smartapp/core/widgets/basic_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      body: const SizedBox.shrink(), // твой контент
      currentIndex: 0,
      onTabSelected: (i) { /* переключить страницу */ },
      onMenuPressed: () {},
      onNotificationsPressed: () {},
      onSettingsPressed: () {},
      onAvatarPressed: () {},
      notifications: 55,
      // avatar: NetworkImage('https://...'),
    );
  }
}
