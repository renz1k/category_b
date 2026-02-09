// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:category_b/repositories/settings/settings_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  SettingsRepository({required SharedPreferences preferences})
    : _preferences = preferences;

  final SharedPreferences _preferences;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  @override
  bool isDarkThemeSelected() {
    final selected = _preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await _preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
}
