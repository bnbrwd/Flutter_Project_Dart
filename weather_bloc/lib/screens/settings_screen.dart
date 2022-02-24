
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/blocs/settings_bloc.dart';
import 'package:weather_bloc/events/settings_event.dart';
import 'package:weather_bloc/states/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(children: <Widget>[
        BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingState) {
          return ListTile(
            title: Text('Temperature Unit'),
            isThreeLine: true,
            subtitle: Text(
                settingState.temperatureUnit == TemperatureUnit.celsius
                    ? 'Celsius'
                    : 'Fahrenheit'),
            trailing: Switch(
              value: settingState.temperatureUnit == TemperatureUnit.celsius,
              onChanged: (_) => BlocProvider.of<SettingsBloc>(context)
                  .add(SettingsEventToggleUnit()),
            ),
          );
        }),
      ]),
    );
  }
}
