import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast_data.dart';

abstract class WeatherRepository {
  Future<WeatherData> getWeather({required String city});
  Future<ForecastData> getForecast({required String city});
}

class HttpWeatherRepository implements WeatherRepository {
  final OpenWeatherMapAPI api;
  final http.Client client;

  HttpWeatherRepository({
    required this.api,
    required this.client,
  });

  @override
  Future<WeatherData> getWeather({required String city}) {
    return api.getWeather(city: city, client: client);
  }

  @override
  Future<ForecastData> getForecast({required String city}) {
    return api.getForecast(city: city, client: client);
  }
}
