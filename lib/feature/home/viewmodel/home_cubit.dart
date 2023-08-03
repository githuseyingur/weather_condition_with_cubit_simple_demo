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
    cityHomeService = HomeService(ProjectNetworkManager.instance.cityService);
    fetchCityItems();
  }
  final IHomeService? homeService;
  late IHomeService? cityHomeService;
  WeatherModel? weatherModel = WeatherModel();
  String? currentLocationCity;
  SkyCondition? skyCondition;
  DateTime? sunRise;
  DateTime? sunSet;
  List<CityModel> cityList = [];
  bool isPagingLoading = false;
  Future<void> fetchItem(String? lat, String? lon) async {
    _changePagingLoading();
    emit(state.copyWith(homeStates: HomeStates.loading));
    try {
      if (lat == null || lon == null) {
        currentLocationCity = (await homeService!.getCityNameByCurrentLocation());
      } else {}
      print("CCCCCCCCCCCCİİİİİİİİİİİİİTYYYYYT:: $currentLocationCity");
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
        sunRise = DateTime.fromMillisecondsSinceEpoch(weatherModel!.sunrise! * 1000);
        sunSet = DateTime.fromMillisecondsSinceEpoch(weatherModel!.sunset! * 1000);
        print("sky condition : " + skyCondition.toString());
        print("sun rise  : " + sunRise.toString());
        print("sun rise  : " + sunSet.toString());
        print("weather model : $weatherModel");
        emit(state.copyWith(weatherModel: weatherModel, homeStates: HomeStates.loaded));
        _changePagingLoading();
      }
      // emit(HomeItemLoaded(weatherModel!));
    } catch (e) {
      emit(state.copyWith(homeStates: HomeStates.error));
    }
  }

  Future<void> fetchCityItems() async {
    cityList = (await cityHomeService!.fetchCityItems())!;
    emit(state.copyWith(cityList: cityList));
    print("cubit city list lenght : ${cityList.length}");
    for (var element in cityList) {
      print("city e : ${element.name}");
    }
  }

  List<CityModel> myList = [];
  String? hint;
  void typeAheadFilter(String value) {
    emit(state.copyWith(cityList: cityList, suggestionCityList: myList));
    // suggestionList.clear();
    // emit(HomeLoading(true));
    // suggestionList.add(city);
    myList = cityList.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(state.copyWith(suggestionCityList: myList, cityList: cityList));
    print('LLLLLLLLLLLLLIIIIIIIIIISSSSSSSSTTTTTTTTT 222222222 ${myList}');
    // emit(HomeItemLoaded(weatherModel!));
    if (myList.isNotEmpty) {
      var firstSuggestion = myList[0].name;
      hint = firstSuggestion!;
      // emit(state.copyWith(suggestionCityList: suggestionList));
      // print('LLLLLLLLLLLLLIIIIIIIIIISSSSSSSSTTTTTTTTT $suggestionList');
      // emit(state.copyWith(cityList: cityList));
    }
  }

  void _changePagingLoading() => isPagingLoading = !isPagingLoading;
}
