// ignore_for_file: prefer_const_constructors

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/blocs/settings_bloc.dart';
import 'package:weather_bloc/blocs/theme_bloc.dart';
import 'package:weather_bloc/blocs/weather_bloc.dart';
import 'package:weather_bloc/blocs/weather_bloc_observer.dart';
import 'package:weather_bloc/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_bloc/screens/weather_screen.dart';

void main() {
  // Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  BlocOverrides.runZoned(
    () {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (context) => ThemeBloc(),
            ),
            BlocProvider<SettingsBloc>(
              create: (context) => SettingsBloc(),
            ),
          ],
          child: MyApp(
            weatherRepository: weatherRepository,
          ),
        ),
      );
    },
    blocObserver: WeatherBlocObserver(),
  );

  // runApp(
  //   MultiBlocProvider(
  //     providers: [
  //       BlocProvider<ThemeBloc>(
  //         create: (context) => ThemeBloc(),
  //       ),
  //       BlocProvider<SettingsBloc>(
  //         create: (context) => SettingsBloc(),
  //       ),
  //     ],
  //     child: MyApp(
  //       weatherRepository: weatherRepository,
  //     ),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  const MyApp({Key? key, required this.weatherRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weater BLoC',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherScreen(),
      ),
    );
  }
}
