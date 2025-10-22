import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/storage/hive_storage.dart';

/// Базовый URL можно позже вынести в env/flavors
final baseUrlProvider = Provider<String>((_) => 'https://api.example.com');

/// Простой Dio без лишних деталей (пока не используем)
final dioProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
  ));
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  return dio;
});

/// Провайдер хранилища
final hiveStorageProvider = Provider<HiveStorage>((_) => HiveStorage());
