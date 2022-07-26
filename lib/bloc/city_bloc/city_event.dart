part of 'city_bloc.dart';

abstract class CityEvent {
}

class CityInitializationStarted extends CityEvent {
}

class CitySelectionStarted extends CityEvent {
  final String value;

  CitySelectionStarted(this.value);
}
