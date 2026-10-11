import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_client.dart';
import '../services/push_notification_service.dart';
import '../services/secure_storage_service.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(ref.watch(secureStorageProvider));
  ref.onDispose(client.dispose);
  return client;
});

final pushNotificationServiceProvider = Provider<PushNotificationService>((ref) {
  final service = PushNotificationService(ref.watch(apiClientProvider));
  ref.onDispose(service.dispose);
  // Fire-and-forget — Provider's own caching means this runs exactly once
  // per app lifetime, the first time anything reads this provider.
  service.initialize();
  return service;
});
