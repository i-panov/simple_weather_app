import 'package:flutter/material.dart';
import 'package:simple_weather_app/ui/city_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Weather Forecast',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: CityPage(),
  ));
}
