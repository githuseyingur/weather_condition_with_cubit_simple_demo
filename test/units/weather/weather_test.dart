import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/home_service.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';
import 'package:weather_app/product/service/project_manager.dart';

void main() {
  IHomeService? homeWeatherService;
  IHomeService? homeCityService;

  setUp(() {
    homeWeatherService = HomeService(ProjectNetworkManager.instance.weatherDio);
    homeCityService = HomeService(ProjectNetworkManager.instance.cityDio);
  });
  test('Get Weather Condition', () async {
    final response = await homeWeatherService!
        .fetchWeatherByCityName("37.874641", "32.493156");

    expect(response != null, true);
    expect(response is WeatherModel, true);
    expect((response!.maxTemp! - response.minTemp!).isNegative, false);
    if (!(-20 < response.temp! && response.temp! < 50))
      throw "temp is not in range";
  });

  test('Get City List', () async {
    final cityList = await homeCityService!.fetchCityItems();
    expect(cityList!.length, 81);
  });
}
