part of 'city_bloc.dart';

abstract class CityState extends Equatable {
}

class CityInitial extends CityState {
  @override
  List<Object> get props => [];
}

class CityLoading extends CityState {
  @override
  List<Object> get props => [];
}

class CitySelected extends CityState {
  final String city;

  CitySelected(this.city);

  @override
  List<Object> get props => [city];
}
