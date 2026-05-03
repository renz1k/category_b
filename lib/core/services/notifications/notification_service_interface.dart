abstract class NotificationServiceInterface {
  Future<void> initialize();

  Future<bool> hasPermission();

  Future<bool> requestPermission();

  Future<bool> enableNotifications();

  Future<void> disableNotifications();

  Future<void> openSystemSettings();
}
