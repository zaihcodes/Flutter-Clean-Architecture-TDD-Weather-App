import 'dart:convert';

import 'package:flutter_clean_architecture_tdd_weather_app/core/constants/constants.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final weatherModel = WeatherModel.fromJson(json);
      return weatherModel;
    } else {
      throw ServerException();
    }
  }
}
