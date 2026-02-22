import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  final FlutterLocalNotificationsPlugin localNotifications;

  NotificationScheduler(this.localNotifications);

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'Важные уведомления',
        importance: Importance.max,
        priority: Priority.high,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await localNotifications.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: details,
      );

      log('Notification shown successfully: id=$id');
    } catch (e, stackTrace) {
      log('ERROR showing notification: $e');
      log('Stack trace: $stackTrace');
    }
  }

  Future<void> scheduleWeeklyReminder() async {
    try {
      await localNotifications.cancel(id: 777);
      log('Cancelled previous notification with id 777 (reset timer)');

      final now = tz.TZDateTime.now(tz.local);

      final scheduledDate = now.add(const Duration(days: 7));

      log('Current time: $now, Scheduled time: $scheduledDate');

      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          localNotifications
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      bool hasPermission = true;

      if (androidImplementation != null) {
        hasPermission =
            await androidImplementation.areNotificationsEnabled() ?? false;
        log('Android notifications enabled: $hasPermission');

        if (!hasPermission) {
          log('WARNING: Notifications are disabled! Requesting permission...');
          final bool? granted = await androidImplementation
              .requestNotificationsPermission();
          hasPermission = granted ?? false;
          log('Permission request result: $hasPermission');
        } else {
          log('Notifications are enabled, proceeding with scheduling...');
        }
      }

      if (androidImplementation == null) {
        final IOSFlutterLocalNotificationsPlugin? iosImplementation =
            localNotifications
                .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin
                >();
        if (iosImplementation != null) {
          final bool? iosPermission = await iosImplementation
              .requestPermissions(alert: true, badge: true, sound: true);
          hasPermission = iosPermission ?? false;
          log('iOS notification permission: $hasPermission');
        }
      }

      if (!hasPermission) {
        log('ERROR: Notification permission not granted! Cannot schedule.');
        return;
      }

      final Duration timeUntilNotification = scheduledDate.difference(now);

      await localNotifications.zonedSchedule(
        id: 777,
        title: 'Скучно без анекдотов? 🥺',
        body: 'Зайди — у нас свежие анекдоты!',
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'weekly_reminder',
            'Еженедельные напоминания',
            channelDescription: 'Напоминает зайти в приложение',
            importance: Importance.high,
            priority: Priority.high,
            enableVibration: true,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexact,
      );

      log('Weekly reminder scheduled for: $scheduledDate');

      final List<PendingNotificationRequest> pendingNotifications =
          await localNotifications.pendingNotificationRequests();
      log('Total pending notifications: ${pendingNotifications.length}');
      bool foundScheduled = false;
      for (var notification in pendingNotifications) {
        log(
          'Pending notification: id=${notification.id}, title="${notification.title}", body="${notification.body}"',
        );
        if (notification.id == 777) {
          foundScheduled = true;
          log('Found our scheduled notification (id=777)');
        }
      }
      if (!foundScheduled && timeUntilNotification.inMinutes >= 1) {
        log(
          'ERROR: Scheduled notification (id=777) not found in pending list!',
        );
      }
    } catch (e, stackTrace) {
      log('ERROR scheduling notification: $e');
      log('Stack trace: $stackTrace');
    }
  }
}
