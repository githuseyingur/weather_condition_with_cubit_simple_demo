import 'package:dio/dio.dart';

class ProjectNetworkManager {
  ProjectNetworkManager._() {
    _weatherDio = Dio(BaseOptions(baseUrl: "https://api.api-ninjas.com/v1/weather"));
    _cityDio = Dio(BaseOptions(baseUrl: "https://api.jsonserve.com/h-6XeG"));
    _header = {
      "X-Api-Key": "B2RcmoUpjxoV/dbSzaYhGg==AjPO6hEFRZDSBtdu",
    };
    _queryParam = {"lat": null, "lon": null};
  }
  late final Dio _weatherDio;
  late final Dio _cityDio;
  late final Map<String, dynamic> _header;
  late final Map<String, dynamic> _queryParam;
  static ProjectNetworkManager instance = ProjectNetworkManager._();
  Dio get weatherService => _weatherDio;
  Dio get cityService => _cityDio;
  Map<String, dynamic> get header => _header;
  Map<String, dynamic> get queryParam => _queryParam;
  void setQueryParam(double lat, double lon) {
    _queryParam.update("lat", (value) => lat);
    _queryParam.update("lon", (value) => lon);
  }
}
