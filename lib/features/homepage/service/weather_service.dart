import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_task/features/homepage/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  static const String baseUrl = 'https://api.weatherapi.com/v1/current.json?';
  String apiKey = dotenv.env['api_Key']!;

  Future<WeatherModel> getWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl&q=$city&key=$apiKey'));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load weather');


    }
  }
}
