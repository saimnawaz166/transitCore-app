import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'api_client.dart';

/// Push notifications via Firebase Cloud Messaging. Every public method is
/// safe to call even when Firebase hasn't been configured yet (no
/// google-services.json dropped in) — it logs and returns rather than
/// throwing, so the rest of the app is never affected by push being
/// unavailable. The moment real Firebase credentials exist, this starts
/// working with no further code changes.
class PushNotificationService {
  PushNotificationService(this._apiClient);

  final ApiClient _apiClient;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _firebaseReady = false;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<String>? _tokenRefreshSub;

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      _firebaseReady = true;
    } catch (e) {
      debugPrint('Push notifications unavailable — Firebase not configured yet ($e).');
      return;
    }

    await _localNotifications.initialize(
      const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')),
    );

    _foregroundSub ??= FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    _tokenRefreshSub ??= FirebaseMessaging.instance.onTokenRefresh.listen(_registerToken);
  }

  /// Requests permission and registers the device's current token — call
  /// this once a driver is actually authenticated, since registration
  /// needs a bearer token attached to the request.
  Future<void> registerCurrentToken() async {
    if (!_firebaseReady) return;

    final settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) await _registerToken(token);
  }

  Future<void> _registerToken(String token) async {
    try {
      await _apiClient.dio.post('/fcm-token', data: {'token': token});
    } on DioException catch (e) {
      // Best-effort — a 401 here just means registerCurrentToken() was
      // called before login finished; the next successful call (next app
      // open, or the driver logging back in) catches it up.
      debugPrint('FCM token registration failed: ${e.message}');
    }
  }

  void _showForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'fleetops_default',
          'FleetOps Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  void dispose() {
    _foregroundSub?.cancel();
    _tokenRefreshSub?.cancel();
  }
}
