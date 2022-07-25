import 'package:simple_weather_app/models/precipitation_type.dart';

/// Прогноз осадков
class PrecipitationForecast {
  /// Количество осадков в мм
  final int value;

  final PrecipitationType? type;

  /// Описание осадков
  final String description;

  PrecipitationForecast({required this.value, required this.type, required this.description});
}
