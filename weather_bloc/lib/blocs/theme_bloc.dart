import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/events/theme_event.dart';
import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(const ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
   late ThemeState newThemeState;
    if (themeEvent is ThemeEventWeatherChanged) {
      final weatherCondition = themeEvent.weatherCondition;
      if (weatherCondition == WeatherCondition.clear ||
          weatherCondition == WeatherCondition.lightCloud) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.yellow, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.hail ||
          weatherCondition == WeatherCondition.snow ||
          weatherCondition == WeatherCondition.sleet) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.heavyCloud) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.grey, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.heavyRain ||
          weatherCondition == WeatherCondition.lightRain ||
          weatherCondition == WeatherCondition.showers) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.indigo, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.thunderstrom) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.deepPurple, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.unkown) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      }
      yield newThemeState;
    }
  }
}
