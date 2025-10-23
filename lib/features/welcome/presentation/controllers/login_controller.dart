import 'dart:developer' as dev; // <-- логи
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import '../../data/auth_repository.dart';

final loginControllerProvider =
StateNotifierProvider.autoDispose<LoginController, AsyncValue<void>>(
      (ref) => LoginController(ref),
);

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController(this._ref) : super(const AsyncValue.data(null));
  final Ref _ref;

  Future<void> login({
    required String email,
    required String password,
    String deviceName = 'skma_app',
  }) async {
    dev.log('[LoginController] start', name: 'auth');
    dev.log('[LoginController] creds', name: 'auth', error: {
      'email': email,
      'deviceName': deviceName,
      // пароль специально не логируем
    });

    state = const AsyncValue.loading();
    dev.log('[LoginController] state -> loading', name: 'auth');

    try {
      dev.log('[LoginController] call repo.login()', name: 'auth');
      await _ref.read(authRepositoryProvider).login(
        email: email,
        password: password,
        deviceName: deviceName,
      );
      dev.log('[LoginController] login SUCCESS', name: 'auth');

      state = const AsyncValue.data(null);
      dev.log('[LoginController] state -> data(null)', name: 'auth');
    } catch (e, st) {
      dev.log('[LoginController] login ERROR: ${e.runtimeType}',
          name: 'auth', error: e, stackTrace: st);
      state = AsyncValue.error(e, st);
      dev.log('[LoginController] state -> error', name: 'auth');
    }
  }
}
