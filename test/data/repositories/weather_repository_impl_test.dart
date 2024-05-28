import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/failure.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/data/models/weather_model.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();

    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 296.56,
    pressure: 1007,
    humidity: 56,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 296.56,
    pressure: 1007,
    humidity: 56,
  );
  const testCityName = 'New York';
  // Return Current weather data success
  // Return Server failure
  // return connection failure

  group('Get current weather', () {
    test('Should return currennt weather when a call data source is successul',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        'Should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      // assert
      expect(result, equals(const Left(ServerFailure("An error has occured"))));
    });

    test('Should return connection failure when the device has no internet',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException("Failed to connect to the network"));

      // act

      final reuslt =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert

      expect(
          reuslt,
          equals(const Left(
              ConnectionFailure("Failed to connect to the network"))));
    });
  });
}
