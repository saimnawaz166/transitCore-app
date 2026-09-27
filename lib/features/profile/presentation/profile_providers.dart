import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/fake_profile_repository.dart';
import '../domain/driver_profile.dart';
import '../domain/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final repo = FakeProfileRepository();
  ref.onDispose(repo.dispose);
  return repo;
});

final myProfileProvider = StreamProvider<DriverProfile>((ref) {
  return ref.watch(profileRepositoryProvider).watchMyProfile();
});
