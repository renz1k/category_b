abstract interface class SettingsRepositoryInterface {
  bool isDarkThemeSelected();
  Future<void> setDarkThemeSelected({required bool selected});

  bool areNotificationsEnabled();
  Future<void> setNotificationsEnabled({required bool enabled});
}
