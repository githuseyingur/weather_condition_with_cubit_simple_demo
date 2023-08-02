import 'package:dio/dio.dart';

class ProjectNetworkManager {
  ProjectNetworkManager._() {
    weatherDio = Dio(BaseOptions(baseUrl: "https://api.api-ninjas.com/v1/weather"));
    cityDio = Dio(BaseOptions(baseUrl: "https://api.jsonserve.com/h-6XeG"));
  }
  late final Dio weatherDio;
  late final Dio cityDio;

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get weatherService => weatherDio;
  Dio get cityService => cityDio;
}
