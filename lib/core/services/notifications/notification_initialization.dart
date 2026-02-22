import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationInitializer {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      tz.initializeTimeZones();
      log('Timezone initialized: ${tz.local}');

      const androidInit = AndroidInitializationSettings('notification_icon');

      const iOSInit = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      const settings = InitializationSettings(
        android: androidInit,
        iOS: iOSInit,
      );

      final bool? initialized = await localNotifications.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          log(
            'Notification clicked: id=${response.id}, payload=${response.payload}',
          );
        },
      );

      if (initialized != true) {
        log('ERROR: Local notifications failed to initialize!');
        return;
      }
      log('Local notifications initialized: $initialized');

      await _createChannels();

      await _requestAndroidPermissions();

      await _requestIosPermissions();
    } catch (e, stackTrace) {
      log('ERROR: NotificationInitializer init failed: $e');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _createChannels() async {
    const highImportance = AndroidNotificationChannel(
      'high_importance_channel',
      'Важные уведомления',
      description: 'Уведомления о новых анекдотах',
      importance: Importance.max,
    );

    const weeklyReminder = AndroidNotificationChannel(
      'weekly_reminder',
      'Еженедельные напоминания',
      description: 'Напоминает зайти в приложение',
      importance: Importance.high,
    );

    final android = localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.createNotificationChannel(highImportance);
    await android?.createNotificationChannel(weeklyReminder);

    log('Notification channels created');
  }

  Future<void> _requestAndroidPermissions() async {
    final fcmSettings = await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('FCM permission: ${fcmSettings.authorizationStatus}');

    final androidImpl = localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImpl != null) {
      final bool? granted = await androidImpl.requestNotificationsPermission();
      log('Android local notification permission: $granted');
    }
  }

  Future<void> _requestIosPermissions() async {
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
        localNotifications
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();

    if (iosImplementation != null) {
      final bool? iosPermission = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      log('iOS local notification permission: $iosPermission');
    }
  }
}
