import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherModel {
  final double temperatureInCelsius;
  final double temperatureInFahrenheit;
  final String weatherCondition;
  final String iconUrl;
  final String cityName;
  WeatherModel( {
    required this.temperatureInCelsius,
    required this.temperatureInFahrenheit,
    required this.weatherCondition,
    required this.iconUrl,
    required this.cityName,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      cityName:map['location']['name'] as String,
      temperatureInCelsius: map['current']['temp_c'] ,
      temperatureInFahrenheit: map['current']['temp_f'] ,
      weatherCondition: map['current']['condition']['text'] as String,
      iconUrl:  map['current']['condition']['icon'] as String,
    );
  }

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
