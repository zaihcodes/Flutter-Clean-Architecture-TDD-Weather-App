import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/failure.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final weatherModel =
          await weatherRemoteDataSource.getCurrentWeather(cityName);

      return Right(weatherModel.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An error has occured"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
