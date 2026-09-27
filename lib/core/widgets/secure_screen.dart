import 'package:flutter/widgets.dart';

import '../services/secure_screen_service.dart';

/// Wrap any screen that renders payout/fare data in this widget so
/// screenshots/recordings are blocked (Android) for as long as it's visible.
class SecureScreen extends StatefulWidget {
  const SecureScreen({super.key, required this.child});

  final Widget child;

  @override
  State<SecureScreen> createState() => _SecureScreenState();
}

class _SecureScreenState extends State<SecureScreen> {
  @override
  void initState() {
    super.initState();
    SecureScreenService.enable();
  }

  @override
  void dispose() {
    SecureScreenService.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
