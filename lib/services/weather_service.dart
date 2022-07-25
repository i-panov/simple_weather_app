import 'dart:convert';
import 'package:simple_weather_app/exceptions/api_exception.dart';
import 'package:simple_weather_app/models/precipitation_forecast.dart';
import 'package:simple_weather_app/models/precipitation_type.dart';
import 'package:simple_weather_app/models/sun_forecast.dart';
import 'package:simple_weather_app/models/temperature_forecast.dart';
import 'package:simple_weather_app/models/weather_response.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/models/wind_forecast.dart';

class WeatherService {
  Future<WeatherResponse> request(String city) async {
    // todo: необходимо подставить адрес запущенного бэка
    final uri = Uri.parse("http://localhost?city=$city");
    final response = await http.get(uri);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result.containsKey('error')) {
      throw ApiException(result['error'], response.statusCode);
    }

    return WeatherResponse(
      sun: SunForecast(
        rise: DateTime.parse(result['sun']['rise']),
        set: DateTime.parse(result['sun']['set']),
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
