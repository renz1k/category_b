abstract interface class SettingsRepositoryInterface {
  bool isDarkThemeSelected();
  Future<void> setDarkThemeSelected(bool selected);

  bool areNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool enabled);
}
