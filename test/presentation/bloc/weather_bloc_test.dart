import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/failure.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase;

  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUsecase = MockGetCurrentWeatherUsecase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUsecase);
  });

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
  test('initial State should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'Should emit [WeatherLoading, WeatherLoaded] when OnCityChanged is added.',
    build: () {
      when(mockGetCurrentWeatherUsecase(testCityName))
          .thenAnswer((_) async => const Right(testWeatherEntity));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [WeatherLoading(), const WeatherLoaded(testWeatherEntity)],
  );

  blocTest<WeatherBloc, WeatherState>(
    'Should emit [WeatherLoading, WeatherLoadFaile] when OnCityChanged is added.',
    build: () {
      when(mockGetCurrentWeatherUsecase(testCityName)).thenAnswer(
          (_) async => const Left(ServerFailure("An error has occured")));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [WeatherLoading(), const WeatherLoadFaile("An error has occured")],
  );
}
