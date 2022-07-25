import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  static const String _key = 'city';

  CityBloc() : super(CityInitial()) {
    on<CityInitializationStarted>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final city = prefs.getString(_key);

      if (city != null && city.isNotEmpty) {
        emit(CitySelected(city));
      } else {
        emit(CityWaitSelection());
      }
    });
  }
}
