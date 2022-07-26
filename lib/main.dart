import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simple_weather_app/ui/city_page.dart';

void main() async {
  await initializeDateFormatting('ru_RU');
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Weather Forecast',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: CityPage(),
  ));
}
