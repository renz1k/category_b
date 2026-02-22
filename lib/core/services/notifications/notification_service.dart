import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_background_handler.dart';
import 'notification_initialization.dart';
import 'notification_scheduling.dart';

class NotificationService {
  final initializer = NotificationInitializer();
  late final NotificationScheduler scheduler;

  Future<void> initialize() async {
    try {
      await initializer.initialize();
      scheduler = NotificationScheduler(initializer.localNotifications);

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');
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

      log('Notification service initialized');
    } catch (e, stackTrace) {
      log('ERROR: NotificationService init failed: $e');
      log('Stack trace: $stackTrace');
    }
  }

  Future<void> scheduleWeeklyReminder() => scheduler.scheduleWeeklyReminder();
}
