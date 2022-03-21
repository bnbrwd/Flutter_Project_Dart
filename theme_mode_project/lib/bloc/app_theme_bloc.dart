import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:theme_mode_project/app_theme/app_theme.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(AppThemeState(theme: AppTheme.lightTheme)) {
    on<AppThemeEvent>((event, emit) {
      // ignore: unnecessary_type_check
      if (event is AppThemeEvent) {
        emit(AppThemeState(theme: event.theme));
      }
    });
  }
}
