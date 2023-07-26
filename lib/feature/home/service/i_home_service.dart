import 'package:dio/dio.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';

abstract class IHomeService {
  final Dio dio;

  IHomeService(this.dio);

  Future<WeatherModel?> fetchWeather();
}
