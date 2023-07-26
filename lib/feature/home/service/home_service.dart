import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';
import 'package:weather_app/product/enums/request_paths/request_paths.dart';

class HomeService extends IHomeService {
  HomeService(super.dio);

  @override
  Future<WeatherModel?> fetchWeather() async {
    try {
      final response = await dio.get(queryParameters: Map.fromEntries([]));
    } catch (e) {}
  }
}
