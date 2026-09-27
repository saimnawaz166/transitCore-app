import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../data/fake_auth_repository.dart';
import '../domain/auth_repository.dart';
import '../domain/driver_session.dart';

/// Swap this single provider to point at a real implementation later —
/// no UI code depends on [FakeAuthRepository] directly.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repo = FakeAuthRepository(ref.watch(secureStorageProvider));
  ref.onDispose(repo.dispose);
  return repo;
});

final sessionProvider = StreamProvider<DriverSession?>((ref) {
  return ref.watch(authRepositoryProvider).watchSession();
});

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(sessionProvider).value != null;
});
