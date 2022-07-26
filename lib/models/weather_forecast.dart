import 'package:simple_weather_app/models/precipitation_forecast.dart';
import 'package:simple_weather_app/models/sun_forecast.dart';
import 'package:simple_weather_app/models/temperature_forecast.dart';
import 'package:simple_weather_app/models/wind_forecast.dart';

class WeatherForecast {
  final SunForecast sun;
  final TemperatureForecast temperature;
  final WindForecast wind;
  final PrecipitationForecast precipitation;

  /// Влажность в %
  final int humidity;

  /// Давление в hPa
  final int pressure;

  /// Облачность
  final String clouds;

  /// Видимость в метрах
  final int visibility;

  WeatherForecast({
    required this.sun,
    required this.temperature,
    required this.wind,
    required this.precipitation,

    required this.humidity,
    required this.pressure,
    required this.clouds,
    required this.visibility,
  });
}
