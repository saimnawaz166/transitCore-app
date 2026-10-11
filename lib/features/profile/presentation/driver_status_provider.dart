import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/driver_status.dart';
import 'profile_providers.dart';

/// Local mirror of the driver's real status, kept in sync with the backend
/// (via [myProfileProvider]'s poll) so a change made elsewhere — another
/// device, or an admin override — shows up here too, not just changes made
/// from this screen.
class DriverStatusNotifier extends Notifier<DriverStatus> {
  @override
  DriverStatus build() {
    ref.listen(myProfileProvider, (_, next) {
      next.whenData((profile) => state = profile.status);
    });
    return ref.read(myProfileProvider).asData?.value.status ?? DriverStatus.unavailable;
  }

  /// Optimistically updates the local toggle, then persists it — rolled
  /// back if the request fails so the UI never claims a status that didn't
  /// actually save.
  Future<void> setStatus(DriverStatus status) async {
    final previous = state;
    state = status;
    try {
      await ref.read(profileRepositoryProvider).setStatus(status);
    } catch (_) {
      state = previous;
      rethrow;
    }
  }
}

final driverStatusProvider = NotifierProvider<DriverStatusNotifier, DriverStatus>(DriverStatusNotifier.new);
