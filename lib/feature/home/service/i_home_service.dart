import 'package:dio/dio.dart';
import 'package:weather_app/feature/home/model/city_model.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';

abstract class IHomeService {
  final Dio dio;

  IHomeService(this.dio);

// get Weather Condition
  Future<WeatherModel?> fetchWeatherByCityName();
  Future<String?> getCityNameByCurrentLocation();

// get City List
  Future<List<CityModel>?> fetchCityItems();
}
