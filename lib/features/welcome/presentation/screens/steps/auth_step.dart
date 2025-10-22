import 'package:flutter/material.dart';
import '../../widgets/welcome_slide.dart';

class AuthStep extends StatelessWidget {
  const AuthStep({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeSlide(
      icon: Icons.qr_code_2_rounded,
      title: 'Отмечайся по QR',
      subtitle: 'Быстрая отметка рабочего времени прямо со входа.',
    );
  }
}
