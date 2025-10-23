import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skma_smartapp/features/welcome/data/auth_repository.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  @override
  void initState() {
    super.initState();
    // Проверяем авторизацию сразу после монтирования
    Future.microtask(() async {
      final ok = await ref.read(authRepositoryProvider).checkAuth();
      if (!mounted) return;
      if (ok) {
        context.goNamed('home');
      } else {
        context.goNamed('welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
