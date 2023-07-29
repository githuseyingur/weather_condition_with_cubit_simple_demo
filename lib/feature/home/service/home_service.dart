import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';

class HomeService extends IHomeService {
  HomeService(super.dio);

  Map<String, dynamic> queryParamsCityName = {
    "city": "Konya",
  };

  Map<String, dynamic> queryParamsLocation = {
    "lat": "42",
    "lon": "42",
  };
  Map<String, dynamic> headers = {
    "X-Api-Key": "B2RcmoUpjxoV/dbSzaYhGg==AjPO6hEFRZDSBtdu",
    // More headers...
  };

  @override
  Future<WeatherModel?> fetchWeatherByCityName() async {
    try {
      final response = await dio.get(
        "",
        queryParameters: queryParamsCityName,
        options: Options(
          headers: headers,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response);
      var resData = response.data;
      if (response.statusCode == HttpStatus.ok) {
        var result = WeatherModel().fromJson(resData);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<WeatherModel?> fetchWeatherByLocation() async {
    try {
      final response = await dio.get(
        "",
        queryParameters: queryParamsLocation,
        options: Options(
          headers: headers,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response);
      var resData = response.data;
      if (response.statusCode == HttpStatus.ok) {
        var result = WeatherModel().fromJson(resData);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
