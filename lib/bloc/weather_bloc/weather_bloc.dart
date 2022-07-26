import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_weather_app/exceptions/api_exception.dart';
import 'package:simple_weather_app/models/weather_forecast.dart';
import 'package:simple_weather_app/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final String city;

  WeatherBloc(this.city) : super(WeatherInitial()) {
    // todo: необходимо подставить адрес запущенного бэка
    final service = WeatherService('http://localhost');

    on<WeatherRefreshStarted>((event, emit) async {
      emit(WeatherLoading());

      try {
        emit(WeatherPresent(await service.request(city)));
      } on SocketException catch (e) {
        print(e);
        emit(WeatherError('Нет подключения к сервису'));
      } on ApiException catch (e) {
        emit(WeatherError(e.message));
      } on Exception catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
