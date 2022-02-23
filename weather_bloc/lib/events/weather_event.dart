import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeahterEventRequested extends WeatherEvent {
  final String city;
  const WeahterEventRequested({required this.city});

  @override
  // TODO: implement props
  List<Object> get props => [city];
}

class WeahterEventRefresh extends WeatherEvent {
  final String city;
  const WeahterEventRefresh({required this.city});

  @override
  // TODO: implement props
  List<Object> get props => [city];
}