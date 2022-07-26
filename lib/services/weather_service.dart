import 'dart:convert';
import 'package:simple_weather_app/exceptions/api_exception.dart';
import 'package:simple_weather_app/models/precipitation_forecast.dart';
import 'package:simple_weather_app/models/precipitation_type.dart';
import 'package:simple_weather_app/models/sun_forecast.dart';
import 'package:simple_weather_app/models/temperature_forecast.dart';
import 'package:simple_weather_app/models/weather_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/models/wind_forecast.dart';

class WeatherService {
  final String apiHost;

  WeatherService(this.apiHost);

  Future<WeatherForecast> request(String city) async {
    final response = await http.get(Uri.parse("${apiHost}?city=$city"));
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result.containsKey('error')) {
      throw ApiException(result['error'], response.statusCode);
    }

    final tzOffset = DateTime.now().timeZoneOffset;

    return WeatherForecast(
      sun: SunForecast(
        rise: DateTime.parse(result['sun']['rise']).add(tzOffset),
        set: DateTime.parse(result['sun']['set']).add(tzOffset),
      ),
      temperature: TemperatureForecast(
        current: result['temperature']['current'],
        feels_like: result['temperature']['feels_like'],
      ),
      wind: WindForecast(
        speed: result['wind']['speed'],
        gusts: result['wind']['gusts'],
        direction: result['wind']['direction'],
      ),
      precipitation: PrecipitationForecast(
        value: result['precipitation']['value'],
        type: parsePrecipitationType(result['precipitation']['mode']),
        description: result['precipitation']['description'],
      ),
      humidity: result['humidity'],
      pressure: result['pressure'],
      clouds: result['clouds'],
      visibility: result['visibility'],
    );
  }
}
