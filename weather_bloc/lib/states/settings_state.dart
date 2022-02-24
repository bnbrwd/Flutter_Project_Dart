
import 'package:equatable/equatable.dart';

enum TemperatureUnit {
  fahrenheit,
  celsius
}

class SettingsState extends Equatable {
  final TemperatureUnit temperatureUnit;

  const SettingsState({required this.temperatureUnit});

  @override
  // TODO: implement props
  List<Object?> get props => [temperatureUnit];

}