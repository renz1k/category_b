import 'package:category_b/core/services/notifications/notification_service.dart';

class AppInitializer {
  final NotificationService notificationService;

  AppInitializer({required this.notificationService});

  Future<void> init() async {
    await notificationService.initialize();
    await notificationService.scheduleWeeklyReminder();
  }
}
