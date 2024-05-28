import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUsecase = GetCurrentWeatherUsecase(mockWeatherRepository);
  });
  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );
  const testCityName = "New York";
  test('Should get current weather details from repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    // act
    final result = await getCurrentWeatherUsecase(testCityName);
    // assert
    expect(result, const Right(testWeatherDetail));
  });
}
