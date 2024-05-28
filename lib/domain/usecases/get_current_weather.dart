import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/failure.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUsecase {
  final WeatherRepository weatherRepository;
  GetCurrentWeatherUsecase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
