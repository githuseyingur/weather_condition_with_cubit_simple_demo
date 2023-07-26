import 'package:dio/dio.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';

class HomeService extends IHomeService {
  HomeService(super.dio);
  Map<String, dynamic> queryParams = {
    "city": "Konya",
  };
  Map<String, dynamic> headers = {
    "X-Api-Key": "B2RcmoUpjxoV/dbSzaYhGg==AjPO6hEFRZDSBtdu",
    // More headers...
  };
  @override
  Future<WeatherModel?> fetchWeather() async {
    try {
      final response = await dio.get(
        "weather",
        queryParameters: queryParams,
        options: Options(
          headers: headers, // Header bilgilerini options içinde belirtiyoruz
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response.toString());
    } catch (e) {}
  }
}
