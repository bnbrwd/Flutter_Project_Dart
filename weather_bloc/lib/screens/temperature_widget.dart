// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/blocs/settings_bloc.dart';
import 'package:weather_bloc/blocs/theme_bloc.dart';
import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/states/settings_state.dart';
import 'package:weather_bloc/states/theme_state.dart';
import 'package:weather_icons/weather_icons.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;
  const TemperatureWidget({Key? key, required this.weather}) : super(key: key);

  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';

  BoxedIcon _mapWeatherConditionToIcon(
      {required WeatherCondition weatherCondition}) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        return BoxedIcon(WeatherIcons.day_sunny);

      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return BoxedIcon(WeatherIcons.snow);

      case WeatherCondition.heavyCloud:
        return BoxedIcon(WeatherIcons.cloud_up);

      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return BoxedIcon(WeatherIcons.rain);

      case WeatherCondition.thunderstrom:
        return BoxedIcon(WeatherIcons.thunderstorm);

      case WeatherCondition.unkown:
        return BoxedIcon(WeatherIcons.sunset);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //add icon here.
            _mapWeatherConditionToIcon(weatherCondition: weather.weatherCondition),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Min temp: ${_formattedTemperature(weather.minTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: _themeState.textColor,
                        ),
                      ),
                      Text(
                        'Temp: ${_formattedTemperature(weather.temp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: _themeState.textColor,
                        ),
                      ),
                      Text(
                        'Max temp: ${_formattedTemperature(weather.maxTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: _themeState.textColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
