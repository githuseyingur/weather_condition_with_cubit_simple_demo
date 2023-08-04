import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/home/model/city_model.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';
import 'package:weather_app/product/service/project_manager.dart';

class HomeService extends IHomeService {
  HomeService(super.dio);
  double? longtitude;
  double? lattitude;
  @override
  Future<WeatherModel?> fetchWeatherByCityName(String? lat, String? lon) async {
    //String cityName = await getCityNameByCurrentLocation() ?? '';
    Map<String, dynamic> queryParamCoord;
    if (lat == null || lon == null) {
      if (lattitude == null || longtitude == null) {
        Fluttertoast.showToast(
            msg: 'İstek başarısız oldu. Lütfen internet bağlantınızı kontrol edin.',
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            webPosition: "top");
      } else {
        ProjectNetworkManager.instance.setQueryParam(lattitude!, longtitude!);
      }
    } else {
      ProjectNetworkManager.instance.setQueryParam(double.parse(lat), double.parse(lon));
    }
    // queryParamCityName.update("city", (value) => cityName);
    try {
      final response = await dio.get(
        "",
        queryParameters: ProjectNetworkManager.instance.queryParam,
        options: Options(
          headers: ProjectNetworkManager.instance.header,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      lattitude = null;
      longtitude = null;
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
        lattitude = position.latitude,
        longtitude = position.longitude,
      );
      return placemarks[0].administrativeArea.toString();
    } catch (err) {
      return null;
    }
  }

  @override
  Future<List<CityModel>?> fetchCityItems() async {
    try {
      final response = await dio.get(
        "",
      );
      var resData = response.data;
      if (response.statusCode == HttpStatus.ok) {
        List<CityModel>? result = (resData as List).map((e) => CityModel().fromJson(e)).toList();
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
