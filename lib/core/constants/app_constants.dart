class AppConstants {
  static const int anekdotMaxRetries = 3;
  static const int anekdotMinimumLength = 10;

  static const Duration anekdotRequestReceiveTimeout = Duration(seconds: 5);
  static const Duration anekdotRequestSendTimeout = Duration(seconds: 3);
  static const Duration anekdotRetryDelay = Duration(milliseconds: 500);

  static const Duration dioConnectTimeout = Duration(seconds: 15);
  static const Duration dioReceiveTimeout = Duration(seconds: 15);
  static const Duration dioSendTimeout = Duration(seconds: 15);

  static const Duration favoriteSearchDebounce = Duration(milliseconds: 150);
  static const Duration messageDisplayDuration = Duration(seconds: 1);
  static const Duration weeklyReminderInterval = Duration(days: 7);

  static const int weeklyReminderNotificationId = 777;
}
