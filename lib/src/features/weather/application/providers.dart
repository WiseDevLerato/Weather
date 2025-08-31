import 'package:flutter/cupertino.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart'; 
import 'package:open_weather_example_flutter/src/features/weather/data/http_weather_repository.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast_data.dart';
import 'package:http/http.dart' as http;

class WeatherProvider extends ChangeNotifier {
  late final HttpWeatherRepository repository;

  WeatherProvider() {
    repository = HttpWeatherRepository(
      api: OpenWeatherMapAPI(apiKey), 
      client: http.Client(),
    );
  }

  String city = 'London';
  WeatherData? currentWeatherProvider;
  ForecastData? hourlyWeatherProvider;

  Future<void> getWeatherData() async {
    try {
      final weather = await repository.getWeather(city: city);
      currentWeatherProvider = weather;
      notifyListeners();

      await getForecastData(); // fetch forecast after current weather
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  Future<void> getForecastData() async {
    try {
      final forecast = await repository.getForecast(city: city);
      hourlyWeatherProvider = forecast;
      notifyListeners();
    } catch (e) {
      print("Error fetching forecast: $e");
    }
  }
}
