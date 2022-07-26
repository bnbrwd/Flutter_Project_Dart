// https://www.metaweather.com/api/location/2379574

// https://www.metaweather.com/api/location/search/?query=chicago

// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_bloc/models/weather.dart';

const baseUrl = 'https://www.metaweather.com';
// ignore: prefer_function_declarations_over_variables
final locationUrl = (city) => '$baseUrl/api/location/search/?query=$city';
final weatherUrl = (locationId) => '$baseUrl/api/location/$locationId';

class WeatherRepository {
  final http.Client httpClient;

  WeatherRepository({required this.httpClient});

  Future<int> getLocationIdFromCity(String city) async {
    final response = await httpClient.get(Uri.parse(locationUrl(city)));
    if(response.statusCode == 200) {
      print('data in repo for city--- ${response.body}');
     final cities = jsonDecode(response.body) as List;
     return (cities.first)['woeid'] ?? {};
    }else {
      throw Exception('Error getting location id of : $city');
    }
  }

  //LocationId => Weather
  Future<Weather> fetchWeather(int locationId) async {
    final response = await httpClient.get(Uri.parse(weatherUrl(locationId)));
    if(response.statusCode != 200) {
      throw Exception('Error getting weather from locationId: $locationId');
    }
    print('data in repo for locationId--- ${response.body}');
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationIdFromCity(city);
    return fetchWeather(locationId);
  }
 }
