import 'package:category_b/core/constants/app_constants.dart';
import 'package:category_b/core/di/setup_dependencies.dart';
import 'package:category_b/core/texts/app_texts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:talker/talker.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  NotificationScheduler(this.localNotifications);
  final FlutterLocalNotificationsPlugin localNotifications;

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        AppTexts.notificationImportantChannelName,
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

      getIt<Talker>().info('Notification shown successfully: id=$id');
    } on Object catch (e, stackTrace) {
      getIt<Talker>().error('ERROR showing notification: $e');
      getIt<Talker>().error('Stack trace: $stackTrace');
    }
  }

  Future<void> scheduleWeeklyReminder() async {
    try {
      await cancelWeeklyReminder();
      getIt<Talker>().info(
        'Cancelled previous notification with id '
        '${AppConstants.weeklyReminderNotificationId} (reset timer)',
      );

      final now = tz.TZDateTime.now(tz.local);
      final scheduledDate = now.add(AppConstants.weeklyReminderInterval);
      getIt<Talker>().info('Current time: $now, Scheduled time: $scheduledDate');

      await localNotifications.zonedSchedule(
        id: AppConstants.weeklyReminderNotificationId,
        title: AppTexts.notificationWeeklyTitle,
        body: AppTexts.notificationWeeklyBody,
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'weekly_reminder',
            AppTexts.notificationWeeklyChannelName,
            channelDescription: AppTexts.notificationWeeklyChannelDescription,
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
      getIt<Talker>().error('ERROR scheduling notification: $e');
      getIt<Talker>().error('Stack trace: $stackTrace');
    }
  }

  Future<void> cancelWeeklyReminder() async {
    await localNotifications.cancel(
      id: AppConstants.weeklyReminderNotificationId,
    );
    getIt<Talker>().info('Weekly reminder cancelled');
  }
}
