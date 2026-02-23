import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_background_handler.dart';
import 'notification_initialization.dart';
import 'notification_scheduling.dart';

class NotificationService {
  final initializer = NotificationInitializer();
  late final NotificationScheduler scheduler;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await initializer.initialize();

      scheduler = NotificationScheduler(initializer.localNotifications);

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Foreground message: ${message.messageId}');
        if (message.notification != null) {
          scheduler.showNotification(
            id: message.hashCode,
            title: message.notification!.title ?? 'Новый анекдот!',
            body: message.notification!.body ?? 'Зайди почитать.',
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('Notification opened app: ${message.messageId}');
      });

      RemoteMessage? initialMessage = await initializer.fcm.getInitialMessage();
      if (initialMessage != null) {
        log('App opened from notification: ${initialMessage.messageId}');
      }

      String? token = await initializer.fcm.getToken();
      log('FCM Token: $token');

      initializer.fcm.onTokenRefresh.listen((String newToken) {
        log('FCM Token refreshed: $newToken');
      });

      _initialized = true;
      log('NotificationService initialized successfully');
    } catch (e, stackTrace) {
      log('NotificationService init error: $e');
      log('Stack trace: $stackTrace');
    }
  }

  Future<bool> hasPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> enableNotifications() async {
    await initialize();

    final granted = await hasPermission() || await requestPermission();

    if (!granted) {
      return false;
    }

    await scheduler.scheduleWeeklyReminder();
    return true;
  }

  Future<void> disableNotifications() async {
    await initialize();
    await scheduler.cancelWeeklyReminder();
  }

  Future<void> openSystemSettings() async {
    await openAppSettings();
  }
}
