import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_task/features/homepage/models/weather_model.dart';
import 'package:weather_task/features/homepage/service/weather_service.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
    (ref) => WeatherNotifier());

@immutable
abstract class WeatherState {}

class InitalState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}

class ErrorSate extends WeatherState {
  final String message;
  ErrorSate({required this.message});
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(InitalState());
  final WeatherRepository _weatherRepo = WeatherRepository();

  void fetchWeather(String cityName) async {
    try {
      state = WeatherLoadingState();
      WeatherModel weatherModel =
          await _weatherRepo.getWeatherFromName(cityName);
      state = WeatherLoadedState(weatherModel: weatherModel);
    } catch (e) {
      state = ErrorSate(message: e.toString());
    }
  }

  void fetchWeatherFromDeviceLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Service are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission  are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location  permission are permanantly  denied, we cannot  request permission');
    }
    Position locationData = await Geolocator.getCurrentPosition();

    try {
      state = WeatherLoadingState();
      WeatherModel weatherModel =
          await _weatherRepo.getWeatherFromDeviceLocation(
              locationData.latitude.toStringAsFixed(2),
              locationData.longitude.toStringAsFixed(2));
      state = WeatherLoadedState(weatherModel: weatherModel);
    } catch (e) {
      state = ErrorSate(message: e.toString());
    }
  }
}
