import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';

class HomeService extends IHomeService {
  HomeService(super.dio);

  double? lon;
  double? lat;
  // Map<String, dynamic> queryParamCityName = {
  //   "city": "Konya",
  // };

  // Map<String, dynamic> queryParamsLocation = {
  //   "lat": "42",
  //   "lon": "42",
  // };
  Map<String, dynamic> headers = {
    //!taşı
    "X-Api-Key": "B2RcmoUpjxoV/dbSzaYhGg==AjPO6hEFRZDSBtdu",
  };

  @override
  Future<WeatherModel?> fetchWeatherByCityName() async {
    //String cityName = await getCityNameByCurrentLocation() ?? '';
    Map<String, dynamic> queryParamCoord = {
      //! taşı
      "lat": lat,
      "lon": lon
    };
    // queryParamCityName.update("city", (value) => cityName);
    try {
      final response = await dio.get(
        "",
        queryParameters: queryParamCoord,
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
  Future<String?> getCityNameByCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {}
    var position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).timeout(const Duration(seconds: 5));
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat = position.latitude,
        lon = position.longitude,
      );
      print("city:${placemarks[0].administrativeArea}");
      return placemarks[0].administrativeArea.toString();
    } catch (err) {
      return null;
    }
  }
}
