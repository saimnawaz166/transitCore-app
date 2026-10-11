import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/core_providers.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/auth_providers.dart';

void main() {
  runApp(const ProviderScope(child: FleetDriverApp()));
}

class FleetDriverApp extends ConsumerStatefulWidget {
  const FleetDriverApp({super.key});

  @override
  ConsumerState<FleetDriverApp> createState() => _FleetDriverAppState();
}

class _FleetDriverAppState extends ConsumerState<FleetDriverApp> {
  @override
  void initState() {
    super.initState();
    // Starts Firebase + the foreground-message/token-refresh listeners —
    // safe no-op until real credentials exist (see PushNotificationService).
    ref.read(pushNotificationServiceProvider);

    // Registration itself needs a bearer token, so it's tied to the
    // session actually appearing rather than firing at cold start.
    ref.listenManual(sessionProvider, (previous, next) {
      if (previous?.value == null && next.value != null) {
        ref.read(pushNotificationServiceProvider).registerCurrentToken();
      }
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'FleetOps Driver',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
