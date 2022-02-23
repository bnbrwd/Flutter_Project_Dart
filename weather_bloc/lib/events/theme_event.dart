
import 'package:equatable/equatable.dart';
import 'package:weather_bloc/models/weather.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {

  final WeatherCondition weatherCondition;

  ThemeEventWeatherChanged({required this.weatherCondition});
  @override
  // TODO: implement props
  List<Object> get props => [weatherCondition];
  
}