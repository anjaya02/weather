import 'package:easyweather/models/weather_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  // Get the weather from the city name
  Future<Weather> getWeather({String cityName = 'Colombo'}) async {
    try {
      final url = '$baseURL?q=$cityName&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}
