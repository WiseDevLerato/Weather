class ForecastEntry {
  final DateTime dateTime;
  final double temperature;
  final String icon;

  ForecastEntry({
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

  factory ForecastEntry.fromJson(Map<String, dynamic> json) {
    return ForecastEntry(
      dateTime: DateTime.parse(json['dt_txt'] as String),
      temperature: (json['main']['temp'] as num).toDouble(),
      icon: (json['weather'][0]['icon'] as String),
    );
  }
}

class ForecastData {
  final List<ForecastEntry> entries;

  ForecastData({required this.entries});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List<dynamic>;
    return ForecastData(
      entries: list.map((e) => ForecastEntry.fromJson(e)).toList(),
    );
  }
}
