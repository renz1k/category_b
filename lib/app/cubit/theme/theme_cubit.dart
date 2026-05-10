import 'package:anekdots_b/core/di/setup_dependencies.dart';
import 'package:anekdots_b/repositories/settings/settings_repository_interface.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:talker/talker.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required SettingsRepositoryInterface settingsRepository})
    : _settingsRepository = settingsRepository,
      super(const ThemeState(Brightness.light)) {
    _checkSelectedTheme();
  }

  final SettingsRepositoryInterface _settingsRepository;

  Future<void> setThemeBrightness(Brightness brightness) async {
    try {
      emit(ThemeState(brightness));
      await _settingsRepository.setDarkThemeSelected(
        selected: brightness == Brightness.dark,
      );
    } on Object catch (e) {
      getIt<Talker>().error(e.toString());
    }
  }

  void _checkSelectedTheme() {
    try {
      final brightness = _settingsRepository.isDarkThemeSelected()
          ? Brightness.dark
          : Brightness.light;
      emit(ThemeState(brightness));
    } on Object catch (e) {
      getIt<Talker>().error(e.toString());
    }
  }
}
