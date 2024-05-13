import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherModel {
  final double temperatureInCelsius;
  final double temperatureInFahrenheit;
  final String waetherCondition;
  final String iconUrl;
  WeatherModel({
    required this.temperatureInCelsius,
    required this.temperatureInFahrenheit,
    required this.waetherCondition,
    required this.iconUrl,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      temperatureInCelsius: map['current']['temp_c'] ,
      temperatureInFahrenheit: map['current']['temp_f'] ,
      waetherCondition: map['current']['condition']['text'] as String,
      iconUrl:  map['current']['condition']['icon'] as String,
    );
  }

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
