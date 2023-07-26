part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  final bool isLoading;

  HomeLoading(this.isLoading);
}

class HomeItemLoaded extends HomeState {
  final WeatherModel weatherModel;
  HomeItemLoaded(this.weatherModel);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
