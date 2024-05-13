

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_task/features/homepage/models/weather_model.dart';
import 'package:weather_task/features/homepage/service/weather_service.dart';


final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) => WeatherNotifier());
@immutable
abstract class WeatherState{}

class InitalState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState{
  final WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}
class ErrorSate extends WeatherState{
  final String message;
  ErrorSate({required this.message});
}

class WeatherNotifier extends StateNotifier<WeatherState>{
  WeatherNotifier() : super(InitalState());
  final WeatherRepository _weatherRepo = WeatherRepository();

  void fetchWeather(String cityName)async{
    try{
      state = WeatherLoadingState();
      WeatherModel weatherModel = await _weatherRepo.getWeather(cityName);
      state = WeatherLoadedState(weatherModel: weatherModel);
    }catch (e){
      state = ErrorSate(message: e.toString());
    }
  }
}