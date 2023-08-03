// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:weather_app/feature/home/enum/home_states.dart';
import '../model/city_model.dart';
import '../model/weather_model.dart';

class HomeState extends Equatable {
  const HomeState(
      {required this.cityList, required this.weatherModel, required this.homeStates, required this.suggestionCityList});
  final List<CityModel>? cityList;
  final List<CityModel>? suggestionCityList;
  final WeatherModel? weatherModel;
  final HomeStates homeStates;
  factory HomeState.initial() {
    return const HomeState(
        cityList: null, weatherModel: null, homeStates: HomeStates.initial, suggestionCityList: null);
  }
  @override
  List<Object?> get props => [cityList, weatherModel, homeStates, suggestionCityList];
  HomeState copyWith({
    List<CityModel>? cityList,
    WeatherModel? weatherModel,
    HomeStates? homeStates,
    List<CityModel>? suggestionCityList,
  }) {
    return HomeState(
      cityList: cityList ?? this.cityList,
      weatherModel: weatherModel ?? this.weatherModel,
      homeStates: homeStates ?? this.homeStates,
      suggestionCityList: suggestionCityList ?? this.suggestionCityList,
    );
  }
}
// / / part of 'home_cubit.dart';
// abstract class HomeState {}
// class HomeInitial extends HomeState {}
// class HomeLoading extends HomeState {
//   final bool isLoading;
//   HomeLoading(this.isLoading);
// }
// class HomeItemLoaded extends HomeState {
//   final WeatherModel weatherModel;
//   HomeItemLoaded(this.weatherModel);
// }
// class HomeItemLoadedCities extends HomeState {
//   final List<CityModel> cityModel;
//   HomeItemLoadedCities(this.cityModel);
// }
// class HomeError extends HomeState {
//   final String message;
//   HomeError(this.message);
// }
