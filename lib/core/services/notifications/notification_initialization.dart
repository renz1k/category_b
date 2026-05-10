import 'dart:io';

import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/core/texts/app_texts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:talker/talker.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationInitializer {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      tz.initializeTimeZones();
      getIt<Talker>().info('Timezone initialized: ${tz.local}');

      const androidInit = AndroidInitializationSettings('notification_icon');

      const iOSInit = DarwinInitializationSettings();

      const settings = InitializationSettings(
        android: androidInit,
        iOS: iOSInit,
      );

      final initialized = await localNotifications.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          getIt<Talker>().info(
            'Notification clicked: id=${response.id}, payload=${response.payload}',
          );
        },
      );

      if (initialized != true) {
        getIt<Talker>().error(
          'ERROR: Local notifications failed to initialize!',
        );
        return;
      }
      getIt<Talker>().info('Local notifications initialized: $initialized');

      await _createChannels();

      await _requestAndroidPermissions();

      await _requestIosPermissions();
    } catch (e, stackTrace) {
      getIt<Talker>().error('ERROR: NotificationInitializer init failed: $e');
      getIt<Talker>().error('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _createChannels() async {
    const highImportance = AndroidNotificationChannel(
      'high_importance_channel',
      AppTexts.notificationImportantChannelName,
      description: AppTexts.notificationImportantChannelDescription,
      importance: Importance.max,
    );

    const weeklyReminder = AndroidNotificationChannel(
      'weekly_reminder',
      AppTexts.notificationWeeklyChannelName,
      description: AppTexts.notificationWeeklyChannelDescription,
      importance: Importance.high,
    );

    final android = localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.createNotificationChannel(highImportance);
    await android?.createNotificationChannel(weeklyReminder);

    getIt<Talker>().info('Notification channels created');
  }

  Future<void> _requestAndroidPermissions() async {
    if (!Platform.isAndroid) return;

    try {
      final fcmSettings = await fcm.requestPermission();
      getIt<Talker>().info(
        'FCM permission: ${fcmSettings.authorizationStatus}',
      );

      final androidImpl = localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      if (androidImpl != null) {
        final granted = await androidImpl.requestNotificationsPermission();
        getIt<Talker>().info('Android local notification permission: $granted');
      }
    } on Object catch (e, stackTrace) {
      getIt<Talker>().error('ERROR requesting Android permissions: $e');
      getIt<Talker>().error('Stack trace: $stackTrace');
    }
  }

  Future<void> _requestIosPermissions() async {
    if (!Platform.isIOS) return;

    try {
      final iosImplementation = localNotifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();

      if (iosImplementation != null) {
        final iosPermission = await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        getIt<Talker>().info(
          'iOS local notification permission: $iosPermission',
        );
      }
    } on Object catch (e, stackTrace) {
      getIt<Talker>().error('ERROR requesting iOS permissions: $e');
      getIt<Talker>().error('Stack trace: $stackTrace');
    }
  }
}
