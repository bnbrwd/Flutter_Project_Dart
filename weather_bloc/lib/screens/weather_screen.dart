// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/blocs/theme_bloc.dart';
import 'package:weather_bloc/blocs/weather_bloc.dart';
import 'package:weather_bloc/events/theme_event.dart';
import 'package:weather_bloc/events/weather_event.dart';
import 'package:weather_bloc/states/theme_state.dart';
import 'package:weather_bloc/states/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Completer<void> _completer;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wather App using Flutter Bloc'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //Naigate to Settings Screen
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () async {
              //Navigate to city search screen.
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(
                ThemeEventWeatherChanged(
                    weatherCondition: weatherState.weather.weatherCondition),
              );
              _completer.complete();
              _completer = Completer();
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(WeahterEventRefresh(city: weather.location));

                      // return a completer object.

                      return _completer.future;
                    },
                    child: Container(
                      color: themeState.backgroundColor,
                      child: ListView(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                weather.location,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.textColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                              ),
                              Center(
                                child: Text(
                                  'Updated: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: themeState.textColor,
                                  ),
                                ),
                              ),
                              //show more here, put together inside a widget
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (weatherState is WeatherStateFailure) {
              return Text(
                'Something went wrong',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              );
            }
            return Center(
              child: Text(
                'select a location first !',
                style: TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
