part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherPresent extends WeatherState {
  final WeatherForecast forecast;
  final DateTime time;

  WeatherPresent(this.forecast): time = DateTime.now();

  @override
  List<Object?> get props => [forecast, time];
}

class WeatherError extends WeatherState {
  final String error;

  WeatherError(this.error);

  @override
  List<Object?> get props => [error];
}
