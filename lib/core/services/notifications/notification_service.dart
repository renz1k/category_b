import 'package:app_settings/app_settings.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/services/notifications/firebase_background_handler.dart';
import 'package:category_b/core/services/notifications/notification_initialization.dart';
import 'package:category_b/core/services/notifications/notification_scheduling.dart';
import 'package:category_b/core/services/notifications/notification_service_interface.dart';
import 'package:category_b/core/texts/app_texts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:talker/talker.dart';

class NotificationService implements NotificationServiceInterface {
  final initializer = NotificationInitializer();
  late final NotificationScheduler scheduler;

  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await initializer.initialize();

      scheduler = NotificationScheduler(initializer.localNotifications);

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        getIt<Talker>().info('Foreground message: ${message.messageId}');
        if (message.notification != null) {
          scheduler.showNotification(
            id: message.hashCode,
            title:
                message.notification!.title ??
                AppTexts.notificationForegroundDefaultTitle,
            body:
                message.notification!.body ??
                AppTexts.notificationForegroundDefaultBody,
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        getIt<Talker>().info('Notification opened app: ${message.messageId}');
      });

      final initialMessage = await initializer.fcm.getInitialMessage();
      if (initialMessage != null) {
        getIt<Talker>().info(
          'App opened from notification: ${initialMessage.messageId}',
        );
      }

      final token = await initializer.fcm.getToken();
      getIt<Talker>().info('FCM Token: $token');

      initializer.fcm.onTokenRefresh.listen((String newToken) {
        getIt<Talker>().info('FCM Token refreshed: $newToken');
      });

      _initialized = true;
      getIt<Talker>().info('NotificationService initialized successfully');
    } on Object catch (e, stackTrace) {
      getIt<Talker>().error('NotificationService init error: $e');
      getIt<Talker>().error('Stack trace: $stackTrace');
    }
  }

  @override
  Future<bool> hasPermission() async {
    final status = await ph.Permission.notification.status;
    return status.isGranted;
  }

  @override
  Future<bool> requestPermission() async {
    final status = await ph.Permission.notification.request();
    return status.isGranted;
  }

  @override
  Future<bool> enableNotifications() async {
    await initialize();

    final granted = await hasPermission() || await requestPermission();

    if (!granted) {
      return false;
    }

    await scheduler.scheduleWeeklyReminder();
    return true;
  }

  @override
  Future<void> disableNotifications() async {
    await initialize();
    await scheduler.cancelWeeklyReminder();
  }

  @override
  Future<void> openSystemSettings() async {
    try {
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    } on Object {
      await ph.openAppSettings();
    }
  }
}
