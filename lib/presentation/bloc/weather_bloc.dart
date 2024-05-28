import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/usecases/get_current_weather.dart';
import 'package:rxdart/rxdart.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUsecase _getCurrentWeatherUsecase;
  WeatherBloc(this._getCurrentWeatherUsecase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());

        final result = await _getCurrentWeatherUsecase(event.cityName);

        result.fold((failure) {
          emit(WeatherLoadFaile(failure.message));
        }, (data) {
          emit(WeatherLoaded(data));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
