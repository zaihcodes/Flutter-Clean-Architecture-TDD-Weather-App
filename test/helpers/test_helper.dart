import 'package:flutter_clean_architecture_tdd_weather_app/data/data_source/remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_weather_app/domain/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([WeatherRepository, WeatherRemoteDataSource],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
