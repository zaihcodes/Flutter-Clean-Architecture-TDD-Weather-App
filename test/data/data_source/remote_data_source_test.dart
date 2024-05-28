import 'package:flutter_clean_architecture_tdd_weather_app/core/constants/constants.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';
  group('get current Weather', () {
    // Valide model
    test('Should return weather model when the response is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      // assert
      expect(result, isA<WeatherModel>());
    });

    // Server exception
    test(
        'Should return a serverexception when the response status is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final result =
          weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      // assert

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
