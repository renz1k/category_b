import 'package:category_b/core/services/notifications/notification_service_interface.dart';
import 'package:category_b/repositories/settings/settings_repository_interface.dart';

class AppInitializer {
  AppInitializer({
    required this.notificationService,
    required this.settingsRepository,
  });
  final NotificationServiceInterface notificationService;
  final SettingsRepositoryInterface settingsRepository;

  Future<void> init() async {
    final enabled = settingsRepository.areNotificationsEnabled();
    final hasPermission = await notificationService.hasPermission();

    if (enabled && hasPermission) {
      await notificationService.enableNotifications();
    }
  }
}
