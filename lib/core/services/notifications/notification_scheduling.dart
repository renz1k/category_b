import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  NotificationScheduler(this.localNotifications);
  final FlutterLocalNotificationsPlugin localNotifications;

  static const int weeklyId = 777;

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
    } on Object catch (e, stackTrace) {
      log('ERROR showing notification: $e');
      log('Stack trace: $stackTrace');
    }
  }

  Future<void> scheduleWeeklyReminder() async {
    try {
      await cancelWeeklyReminder();
      log('Cancelled previous notification with id $weeklyId (reset timer)');

      final now = tz.TZDateTime.now(tz.local);
      final scheduledDate = now.add(const Duration(days: 7));
      log('Current time: $now, Scheduled time: $scheduledDate');

      await localNotifications.zonedSchedule(
        id: weeklyId,
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
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexact,
      );
    } on Object catch (e, stackTrace) {
      log('ERROR scheduling notification: $e');
      log('Stack trace: $stackTrace');
    }
  }

  Future<void> cancelWeeklyReminder() async {
    await localNotifications.cancel(id: weeklyId);
    log('Weekly reminder cancelled');
  }
}
