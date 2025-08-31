import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/features/weather/domain/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast_data.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';

class HttpWeatherRepository {
  HttpWeatherRepository({
    required this.api,
    required this.client,
  });

  final OpenWeatherMapAPI api;
  final http.Client client;

  Future<WeatherData> getWeather({required String city}) async {
    final url = api.weather(city); // ✅ FIXED
    final response = await client.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load weather');
    }
    final data = jsonDecode(response.body);
    return WeatherData.fromJson(data);
  }

  Future<ForecastData> getForecast({required String city}) async {
    final url = api.forecast(city); 
    final response = await client.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load forecast');
    }
    final data = jsonDecode(response.body);
    return ForecastData.fromJson(data);
  }
}
