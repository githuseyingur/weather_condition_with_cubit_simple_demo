import 'package:weather_app/feature/home/model/weather_model.dart';

abstract class IHomeService {
  Future<WeatherModel> getWeather();
}
