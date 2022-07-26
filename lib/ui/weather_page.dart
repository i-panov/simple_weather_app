import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:simple_weather_app/ui/city_page.dart';

class WeatherPage extends StatelessWidget {
  final String city;

  WeatherPage(this.city);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(city)..add(WeatherRefreshStarted()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            actions: [
              ElevatedButton(
                child: Text('Обновить прогноз'),
                onPressed: () => context.read<WeatherBloc>().add(WeatherRefreshStarted()),
              ),
              ElevatedButton(
                child: Text('Выбрать город'),
                onPressed: () {
                  final route = MaterialPageRoute(builder: (context) => CityPage(withoutInitialization: true));
                  Navigator.pushAndRemoveUntil(context, route, (route) => false);
                },
              ),
            ],
          ),
          body: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return Center(child: Text('Прогноз не загружен'));
              }

              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is WeatherError) {
                return Center(child: Text(state.error));
              }

              final presentState = state as WeatherPresent;
              final precipitationIconName = state.forecast.precipitation.type?.name;

              final params = <String, String>{
                'По ощущениям': _temperatureValueToString(state.forecast.temperature.feels_like),
                'Ветер': "${state.forecast.wind.speed} м/с, ${state.forecast.wind.direction}",
                'Влажность': "${state.forecast.humidity} %",
                'Осадки': "${state.forecast.precipitation.value} мм",
                'Давление': "${state.forecast.pressure} hPa",
                'Солнце': "${_timeToString(state.forecast.sun.set)} / ${_timeToString(state.forecast.sun.rise)}",
              };

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(city),
                        Text(', '),
                        Text(_dateTimeToString(presentState.time)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_temperatureValueToString(presentState.forecast.temperature.current), style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                        SizedBox(width: 10),
                        if (precipitationIconName != null)
                          SvgPicture.asset("assets/images/${precipitationIconName}.svg", width: 50, height: 50),
                        SizedBox(width: 10),
                        Text(presentState.forecast.clouds),
                      ],
                    ),
                    for (final pair in params.entries)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(pair.key),
                              Text(pair.value),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _dateTimeToString(DateTime value) => DateFormat('dd.MM HH:mm:ss', 'ru_RU').format(value);

  String _timeToString(DateTime value) => DateFormat('HH:mm', 'ru_RU').format(value);

  String _temperatureValueToString(int value) {
    final sign = value.isNegative ? '-' : (value == 0 ? '' : '+');
    return "${sign}${value}";
  }
}
