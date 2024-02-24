import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/home/enum/home_states.dart';
import 'package:weather_app/feature/home/model/city_model.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/home_service.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';
import 'package:weather_app/product/enums/sky_condition.dart';
import 'package:weather_app/product/service/project_manager.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(HomeState.initial()) {
    cityHomeService = HomeService(ProjectNetworkManager.instance.cityDio);
    fetchCityItems();
  }
  final IHomeService? homeService;
  late IHomeService? cityHomeService;
  final TextEditingController cityInputController = TextEditingController();
  WeatherModel? weatherModel = WeatherModel();
  String? currentLocationCity;
  SkyCondition? skyCondition;
  DateTime? sunRise;
  DateTime? sunSet;
  List<CityModel> cityList = [];
  bool? isCurrentLocation = true;
  Future<void> fetchItem(String? lat, String? lon) async {
    emit(state.copyWith(homeStates: HomeStates.loading));
    try {
      if (lat == null || lon == null) {
        currentLocationCity =
            (await homeService!.getCityNameByCurrentLocation());
      } else {
        isCurrentLocation = false;
      }
      weatherModel = (await homeService!.fetchWeatherByCityName(lat, lon));
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
        sunRise =
            DateTime.fromMillisecondsSinceEpoch(weatherModel!.sunrise! * 1000);
        sunSet =
            DateTime.fromMillisecondsSinceEpoch(weatherModel!.sunset! * 1000);
        emit(state.copyWith(
            weatherModel: weatherModel, homeStates: HomeStates.loaded));
      }
      // emit(HomeItemLoaded(weatherModel!));
    } catch (e) {
      emit(state.copyWith(homeStates: HomeStates.error));
    }
  }

  Future<void> fetchCityItems() async {
    cityList = (await cityHomeService!.fetchCityItems())!;
    emit(state.copyWith(cityList: cityList));
  }

  void changeSuggestionVisible() {
    emit(state.copyWith(isListVisible: !state.isListVisible));
  }

  List<CityModel> myList = [];
  void typeAheadFilter(String value) {
    emit(state.copyWith(cityList: cityList, suggestionCityList: myList));
    myList = cityList
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    emit(state.copyWith(suggestionCityList: myList, cityList: cityList));
  }
}
