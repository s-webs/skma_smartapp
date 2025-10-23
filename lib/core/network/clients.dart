import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dio_factory.dart';
import '../constants/api_hosts.dart';
import '../storage/keys.dart';

final authDioProvider =
Provider((ref) => buildDio(ApiHosts.auth, tokenKey: StorageKeys.authToken));
