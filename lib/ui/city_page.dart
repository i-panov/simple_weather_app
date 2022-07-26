import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/bloc/city_bloc/city_bloc.dart';
import 'package:simple_weather_app/ui/weather_page.dart';

class CityPage extends StatelessWidget {
  final bool withoutInitialization;

  CityPage({this.withoutInitialization = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CityBloc>(
        create: (context) {
          final bloc = CityBloc();

          if (!withoutInitialization) {
            bloc.add(CityInitializationStarted());
          }

          return bloc;
        },
        child: BlocListener<CityBloc, CityState>(
          listener: (context, state) {
            if (state is CitySelected) {
              final route = MaterialPageRoute(builder: (context) => WeatherPage(state.city));
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            }
          },
          child: BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              if (state is CitySelected) {
                return Center(child: Text('Город выбран'));
              }

              if (state is CityLoading) {
                return Center(child: CircularProgressIndicator());
              }

              final ctrl = TextEditingController(text: '');

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: ctrl,
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      child: Text('Выбрать'),
                      onPressed: () => context.read<CityBloc>().add(CitySelectionStarted(ctrl.text)),
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
}
