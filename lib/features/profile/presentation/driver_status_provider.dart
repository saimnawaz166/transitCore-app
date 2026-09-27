import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/driver_status.dart';

class DriverStatusNotifier extends Notifier<DriverStatus> {
  @override
  DriverStatus build() => DriverStatus.active;

  void setStatus(DriverStatus status) => state = status;
}

final driverStatusProvider = NotifierProvider<DriverStatusNotifier, DriverStatus>(DriverStatusNotifier.new);
