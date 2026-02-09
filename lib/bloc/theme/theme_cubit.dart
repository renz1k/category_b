import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(Brightness.light));

  void setThemeBrightness(Brightness brightness) {
    emit(ThemeState(brightness));
  }
}
