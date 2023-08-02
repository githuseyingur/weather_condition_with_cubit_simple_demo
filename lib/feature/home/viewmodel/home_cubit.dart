import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/home/model/city_model.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';
import 'package:weather_app/product/enums/sky_condition.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(HomeInitial());

  final IHomeService? homeService;
  WeatherModel? weatherModel = WeatherModel();
  String? currentLocationCity;
  SkyCondition? skyCondition;
  DateTime? sunRise;
  DateTime? sunSet;
  List<CityModel> cityList = [];
  bool isPagingLoading = false;

  Future<void> fetchItem() async {
    _changePagingLoading();

    emit(HomeLoading(true));
    try {
      currentLocationCity = (await homeService!.getCityNameByCurrentLocation());
      weatherModel = (await homeService!.fetchWeatherByCityName());

      if (weatherModel != null) {
        if (20 >= int.parse(weatherModel!.cloudPct.toString())) {
          skyCondition = SkyCondition.clear;
        } else if (20 < int.parse(weatherModel!.cloudPct.toString()) &&
            50 >= int.parse(weatherModel!.cloudPct.toString())) {
          skyCondition = SkyCondition.fewClouds;
        } else if (50 < int.parse(weatherModel!.cloudPct.toString()) &&
            70 >= int.parse(weatherModel!.cloudPct.toString())) {
          skyCondition = SkyCondition.partlyClouds;
        } else if (70 < int.parse(weatherModel!.cloudPct.toString())) {
          skyCondition = SkyCondition.cloudy;
        }

        sunRise = DateTime.fromMillisecondsSinceEpoch(weatherModel!.sunrise! * 1000);
        sunSet = DateTime.fromMillisecondsSinceEpoch(weatherModel!.sunset! * 1000);
        print("sky condition : " + skyCondition.toString());
        print("sun rise  : " + sunRise.toString());
        print("sun rise  : " + sunSet.toString());
        emit(HomeItemLoaded(weatherModel!));
        _changePagingLoading();
      }
      emit(HomeItemLoaded(weatherModel!));
    } catch (e) {
      emit(HomeError(weatherModel.toString()));
    }
  }

  Future<void> fetchCityItems() async {
    cityList = (await homeService!.fetchCityItems())!;
    print("cubit city list lenght : ${cityList.length}");
    for (var element in cityList) {
      print("city name : ${element.name}");
    }
  }

  List<CityModel> suggestionList = [];
  String? hint;
  void typeAheadFilter(String value) {
    suggestionList.clear();

    for (CityModel city in cityList) {
      if (city.name!.contains(value)) {
        suggestionList.add(city);
      }
    }

    if (suggestionList.isNotEmpty) {
      var firstSuggestion = suggestionList[0].name;

      hint = firstSuggestion!;
    }
  }

  void _changePagingLoading() => isPagingLoading = !isPagingLoading;
}
