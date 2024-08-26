import 'package:easyweather/models/weather_model.dart';
import 'package:easyweather/pages/searchweather.dart';
import 'package:easyweather/provider/themeprovider.dart';
import 'package:easyweather/services/weather_service.dart';
import 'package:easyweather/widgets/display_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env['OPEN_WEATHER_API_KEY'] ?? '');

  Weather? _weather;

  void fetchWeather() async {
    try {
      // Fetch the weather data for Colombo
      final weather = await _weatherService.getWeather();
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load weather data: $e'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Weather'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(
                    Theme.of(context).brightness != Brightness.dark,
                  );
                },
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  size: 30,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
      body: _weather != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(11), // Add padding here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DisplayWeather(weather: _weather!),
                    const SizedBox(
                        height: 16), // Optional: Add space between widgets
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchWeatherPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Go to Search",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
    );
  }
}
