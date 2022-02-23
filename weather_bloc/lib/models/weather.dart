import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstrom,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unkown
}

class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  const Weather({
    required this.weatherCondition,
    required this.formattedCondition,
    required this.minTemp,
    required this.temp,
    required this.maxTemp,
    required this.locationId,
    required this.created,
    required this.lastUpdated,
    required this.location,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        weatherCondition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location,
      ];

//convert from JSON to Weather object

// "consolidated_weather": [
//         {
//             "id": 5236769747369984,
//             "weather_state_name": "Light Rain",
//             "weather_state_abbr": "lr",
//             "wind_direction_compass": "NW",
//             "created": "2022-02-23T04:03:19.565316Z",
//             "applicable_date": "2022-02-22",
//             "min_temp": -4.57,
//             "max_temp": 7.175,
//             "the_temp": -1.3650000000000002,
//             "wind_speed": 8.318539973445743,
//             "wind_direction": 312.0,
//             "air_pressure": 1020.0,
//             "humidity": 73,
//             "visibility": 14.926578779925237,
//             "predictability": 75
//         },
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(
            consolidatedWeather['weather_state_abbr']),
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        minTemp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId:
            jsonObject['woeid'] as int, //where on Earth Identifier = woeid
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: jsonObject['title']);
  }

  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstrom,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
    };
    return map[inputString] ?? WeatherCondition.unkown;
  }
}














// import 'dart:convert';

// Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

// String weatherToJson(Weather data) => json.encode(data.toJson());

// class Weather {
//   Weather({
//     required this.consolidatedWeather,
//     required this.time,
//     required this.sunRise,
//     required this.sunSet,
//     required this.timezoneName,
//     required this.parent,
//     required this.sources,
//     required this.title,
//     required this.locationType,
//     required this.woeid,
//     required this.lattLong,
//     required this.timezone,
//   });

//   final List<ConsolidatedWeather> consolidatedWeather;
//   final DateTime time;
//   final DateTime sunRise;
//   final DateTime sunSet;
//   final String timezoneName;
//   final Parent parent;
//   final List<Source> sources;
//   final String title;
//   final String locationType;
//   final int woeid;
//   final String lattLong;
//   final String timezone;

//   factory Weather.fromJson(Map<String, dynamic> json) => Weather(
//         consolidatedWeather: List<ConsolidatedWeather>.from(
//             json["consolidated_weather"]
//                 .map((x) => ConsolidatedWeather.fromJson(x))),
//         time: DateTime.parse(json["time"]),
//         sunRise: DateTime.parse(json["sun_rise"]),
//         sunSet: DateTime.parse(json["sun_set"]),
//         timezoneName: json["timezone_name"],
//         parent: Parent.fromJson(json["parent"]),
//         sources:
//             List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
//         title: json["title"],
//         locationType: json["location_type"],
//         woeid: json["woeid"],
//         lattLong: json["latt_long"],
//         timezone: json["timezone"],
//       );

//   Map<String, dynamic> toJson() => {
//         "consolidated_weather":
//             List<dynamic>.from(consolidatedWeather.map((x) => x.toJson())),
//         "time": time.toIso8601String(),
//         "sun_rise": sunRise.toIso8601String(),
//         "sun_set": sunSet.toIso8601String(),
//         "timezone_name": timezoneName,
//         "parent": parent.toJson(),
//         "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
//         "title": title,
//         "location_type": locationType,
//         "woeid": woeid,
//         "latt_long": lattLong,
//         "timezone": timezone,
//       };
// }

// class ConsolidatedWeather {
//   ConsolidatedWeather({
//     required this.id,
//     required this.weatherStateName,
//     required this.weatherStateAbbr,
//     required this.windDirectionCompass,
//     required this.created,
//     required this.applicableDate,
//     required this.minTemp,
//     required this.maxTemp,
//     required this.theTemp,
//     required this.windSpeed,
//     required this.windDirection,
//     required this.airPressure,
//     required this.humidity,
//     required this.visibility,
//     required this.predictability,
//   });

//   final int id;
//   final String weatherStateName;
//   final String weatherStateAbbr;
//   final String windDirectionCompass;
//   final DateTime created;
//   final DateTime applicableDate;
//   final double minTemp;
//   final double maxTemp;
//   final double theTemp;
//   final double windSpeed;
//   final double windDirection;
//   final double airPressure;
//   final int humidity;
//   final double visibility;
//   final int predictability;

//   factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
//       ConsolidatedWeather(
//         id: json["id"],
//         weatherStateName: json["weather_state_name"],
//         weatherStateAbbr: json["weather_state_abbr"],
//         windDirectionCompass: json["wind_direction_compass"],
//         created: DateTime.parse(json["created"]),
//         applicableDate: DateTime.parse(json["applicable_date"]),
//         minTemp: json["min_temp"].toDouble(),
//         maxTemp: json["max_temp"].toDouble(),
//         theTemp: json["the_temp"].toDouble(),
//         windSpeed: json["wind_speed"].toDouble(),
//         windDirection: json["wind_direction"].toDouble(),
//         airPressure: json["air_pressure"].toDouble(),
//         humidity: json["humidity"],
//         visibility: json["visibility"].toDouble(),
//         predictability: json["predictability"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "weather_state_name": weatherStateName,
//         "weather_state_abbr": weatherStateAbbr,
//         "wind_direction_compass": windDirectionCompass,
//         "created": created.toIso8601String(),
//         "applicable_date":
//             "${applicableDate.year.toString().padLeft(4, '0')}-${applicableDate.month.toString().padLeft(2, '0')}-${applicableDate.day.toString().padLeft(2, '0')}",
//         "min_temp": minTemp,
//         "max_temp": maxTemp,
//         "the_temp": theTemp,
//         "wind_speed": windSpeed,
//         "wind_direction": windDirection,
//         "air_pressure": airPressure,
//         "humidity": humidity,
//         "visibility": visibility,
//         "predictability": predictability,
//       };
// }

// class Parent {
//   Parent({
//     required this.title,
//     required this.locationType,
//     required this.woeid,
//     required this.lattLong,
//   });

//   final String title;
//   final String locationType;
//   final int woeid;
//   final String lattLong;

//   factory Parent.fromJson(Map<String, dynamic> json) => Parent(
//         title: json["title"],
//         locationType: json["location_type"],
//         woeid: json["woeid"],
//         lattLong: json["latt_long"],
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "location_type": locationType,
//         "woeid": woeid,
//         "latt_long": lattLong,
//       };
// }

// class Source {
//   Source({
//     required this.title,
//     required this.slug,
//     required this.url,
//     required this.crawlRate,
//   });

//   final String title;
//   final String slug;
//   final String url;
//   final int crawlRate;

//   factory Source.fromJson(Map<String, dynamic> json) => Source(
//         title: json["title"],
//         slug: json["slug"],
//         url: json["url"],
//         crawlRate: json["crawl_rate"],
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "slug": slug,
//         "url": url,
//         "crawl_rate": crawlRate,
//       };
// }
