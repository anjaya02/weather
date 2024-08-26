import 'package:easyweather/models/weather_model.dart';
import 'package:easyweather/services/weather_service.dart';
import 'package:easyweather/widgets/display_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env['OPEN_WEATHER_API_KEY'] ?? '');

  final TextEditingController _controller = TextEditingController();
  Weather? _weather;
  String? _error;

  void _searchWeather() async {
    final city = _controller.text.trim();
    if (city.isEmpty) {
      setState(() {
        _error = "Please enter a city name";
      });
      return;
    }

    try {
      final weather = await _weatherService.getWeather(cityName: city);
      setState(() {
        _weather = weather;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = "Could not fetch weather data for $city";
        _weather = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'City Name',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Border radius here
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchWeather,
                  ),
                ),
                onSubmitted: (_) => _searchWeather(),
              ),
              const SizedBox(height: 10),
              _error != null
                  ? Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    )
                  : _weather != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(20), // Border radius here
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Border radius here
                            child: DisplayWeather(weather: _weather!),
                          ),
                        )
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
