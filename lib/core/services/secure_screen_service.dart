import 'package:flutter/services.dart';

/// Toggles Android's FLAG_SECURE (blocks screenshots/screen recording and
/// hides content from the recent-apps switcher) for screens that display
/// payout figures. iOS has no direct equivalent flag; this is a documented
/// platform limitation, not an oversight.
class SecureScreenService {
  static const _channel = MethodChannel('fleet_driver_app/secure_screen');

  static Future<void> enable() async {
    try {
      await _channel.invokeMethod('enable');
    } on MissingPluginException {
      // No-op on platforms/tests without the native handler registered.
    }
  }

  static Future<void> disable() async {
    try {
      await _channel.invokeMethod('disable');
    } on MissingPluginException {
      // No-op on platforms/tests without the native handler registered.
    }
  }
}
