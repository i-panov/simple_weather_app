import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(city),
                        Text(', '),
                        Text(presentState.time.toString()),
                      ],
                    ),
                    if (precipitationIconName != null)
                      SvgPicture.asset("assets/images/${precipitationIconName}.svg", width: 50, height: 50)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
