import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/events/weather_event.dart';
import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/repositories/weather_repository.dart';
import 'package:weather_bloc/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc( {required this.weatherRepository})
      : super(WeatherStateIntitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeahterEventRequested) {
      yield WeatherStateLoading();
      try {
        final Weather weather =
            await weatherRepository.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeahterEventRefresh) {
      try {
        final Weather weather =
            await weatherRepository.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
