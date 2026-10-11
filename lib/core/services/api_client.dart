import 'dart:async';

import 'package:dio/dio.dart';

import 'secure_storage_service.dart';

/// Shared Dio client for every Real*Repository. Scoped to the driver actor
/// (`/api/v1/driver`) since that's the only backend surface this app talks
/// to. Attaches the stored bearer token to every request.
///
/// On a 401 it only broadcasts [onUnauthorized] rather than clearing the
/// session itself — [RealAuthRepository] is the sole owner of the session
/// stream, so it has to be the one to both clear storage and emit the
/// logout; clearing storage from here too would leave that stream (and the
/// router redirect that watches it) never finding out.
class ApiClient {
  ApiClient(this._secureStorage)
      : dio = Dio(BaseOptions(
          baseUrl: '$_normalizedRoot/api/v1/driver',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        )) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final session = await _secureStorage.readSession();
          if (session != null) {
            options.headers['Authorization'] = 'Bearer ${session.$1}';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            _unauthorizedController.add(null);
          }
          handler.next(error);
        },
      ),
    );
  }

  static const _root = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.1.12:8000/',
  );

  // A trailing slash on _root (easy to paste in by accident, e.g. straight
  // from a browser address bar) would otherwise double up with the leading
  // slash below and produce ".../8000//api/v1/driver/...".
  static final String _normalizedRoot = _root.endsWith('/') ? _root.substring(0, _root.length - 1) : _root;

  final SecureStorageService _secureStorage;
  final Dio dio;
  final StreamController<void> _unauthorizedController = StreamController<void>.broadcast();

  Stream<void> get onUnauthorized => _unauthorizedController.stream;

  void dispose() => _unauthorizedController.close();
}
