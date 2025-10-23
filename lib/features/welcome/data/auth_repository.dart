import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:skma_smartapp/core/constants/endpoints_auth.dart';
import 'package:skma_smartapp/core/network/clients.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// добавь это:
import 'package:skma_smartapp/core/storage/token_storage.dart';
import 'package:skma_smartapp/core/storage/keys.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(authDioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  AuthRepository(this._dio);
  final Dio _dio;

  Future<String> login({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    final url = '${_dio.options.baseUrl}${EndpointsAuth.login}';
    dev.log('[AuthRepository] POST $url', name: 'auth');

    try {
      final res = await _dio.post(
        EndpointsAuth.login,
        data: {
          'email': email,
          'password': password,
          'device_name': deviceName,
        },
        options: Options(responseType: ResponseType.plain),
      );

      final token = (res.data as String).trim();
      dev.log('[AuthRepository] SUCCESS token len=${token.length}', name: 'auth');

      // ✅ Сохраняем токен
      await TokenStorage.write(StorageKeys.authToken, token);

      return token;
    } on DioException catch (e, st) {
      dev.log('[AuthRepository] DIO ERROR',
        name: 'auth',
        error: {
          'uri': e.requestOptions.uri.toString(),
          'type': e.type.name,
          'status': e.response?.statusCode,
          'data': e.response?.data,
          'inner': e.error?.toString(),
          'message': e.message,
        },
        stackTrace: st,
      );
      final msg = _laravelMessage(e) ?? _networkMessage(e) ?? 'Login failed';
      throw Exception(msg);
    } catch (e, st) {
      dev.log('[AuthRepository] UNKNOWN ERROR', name: 'auth', error: e, stackTrace: st);
      throw Exception('Login failed');
    }
  }

  /// ✅ Проверяем валидность текущего токена: если 200 на /me — авторизованы.
  /// Если 401 — чистим токен и возвращаем false.
  Future<bool> checkAuth() async {
    final token = TokenStorage.read(StorageKeys.authToken);
    if (token == null || token.isEmpty) {
      dev.log('[AuthRepository] checkAuth: no token', name: 'auth');
      return false;
    }
    try {
      final res = await _dio.get(EndpointsAuth.me);
      dev.log('[AuthRepository] checkAuth OK (${res.statusCode})', name: 'auth');
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        dev.log('[AuthRepository] checkAuth 401 -> clear token', name: 'auth');
        await TokenStorage.clear(StorageKeys.authToken);
      } else {
        dev.log('[AuthRepository] checkAuth dio error ${e.type}', name: 'auth');
      }
      return false;
    } catch (e) {
      dev.log('[AuthRepository] checkAuth unknown error: $e', name: 'auth');
      return false;
    }
  }

  String? _laravelMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['errors'] is Map) {
      final errs = (data['errors'] as Map).cast<String, dynamic>();
      if (errs.isNotEmpty) {
        final first = errs.values.first;
        if (first is List && first.isNotEmpty) return first.first.toString();
      }
    }
    if (data is Map && data['message'] is String) return data['message'] as String;
    if (data is String && data.isNotEmpty) return data; // иногда приходит строка
    return null;
  }

  String? _networkMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Network error. Check API host.';
      default:
        return null;
    }
  }
}
