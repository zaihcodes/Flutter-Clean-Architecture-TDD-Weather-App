import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/data/models/weather_model.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });
  // is the model equal entity
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );
  test('Should be a subclass of weather entity', () async {
    // arrange
    // act
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });
  // from json
  test('Should return a valide model from json ', () async {
    // arrange
    // act
    final weatherJson =
        await readJson('helpers/dummy_data/dummy_weather_response.json');

    final weatherModel = WeatherModel.fromJson(weatherJson);
    // assert
    expect(weatherModel, testWeatherModel);
  });

  // to json

  test(
      'Should return a valide Json object from weathermodel with the proper data',
      () async {
    const expectedJson = {
      "weather": [
        {
          "main": "Clear",
          "description": "clear sky",
          "icon": "01n",
        }
      ],
      "main": {"temp": 292.87, "pressure": 1012, "humidity": 70},
      "name": "New York",
    };
    // arrange

    // act
    final result = testWeatherModel.toJson();
    // assert
    expect(result, expectedJson);
  });
}
