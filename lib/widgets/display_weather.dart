import 'package:easyweather/models/weather_model.dart';
import 'package:easyweather/utils/util_function.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DisplayWeather extends StatelessWidget {
  final Weather weather;
  const DisplayWeather({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                UtilFunction()
                    .getWeatherAnimation(condition: weather.condition),
                width: 270,
                height: 270,
              ),
            ),
            const SizedBox(
                height:
                    1), // Adds vertical space between the animation and the text
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${weather.temperature.toStringAsFixed(1)}°C",
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  weather.condition,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  weather.description,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetail("Pressure", "${weather.pressure} hPa"),
                _buildWeatherDetail("Humidity", "${weather.humidity}%"),
                _buildWeatherDetail("Wind Speed", "${weather.windSpeed} m/s"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
