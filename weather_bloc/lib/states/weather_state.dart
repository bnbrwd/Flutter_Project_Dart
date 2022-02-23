
import 'package:equatable/equatable.dart';
import 'package:weather_bloc/models/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherStateIntitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  final Weather weather;
 const WeatherStateSuccess({required this.weather});

 @override
  List<Object> get props => [weather];
}

class WeatherStateFailure extends WeatherState {}
