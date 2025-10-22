import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'bootstrap.dart';
import 'app/app.dart';

Future<void> main() async {
  // инициализация (Hive и т.п.)
  final container = await bootstrap();

  runApp(
    // даём приложению уже подготовленный контейнер провайдеров
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
