import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/home/model/weather_model.dart';
import 'package:weather_app/feature/home/service/i_home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(HomeInitial());

  final IHomeService homeService;
  WeatherModel? weatherModel = WeatherModel();

  bool isPagingLoading = false;

  Future<void> fetchItem() async {
    _changePagingLoading();

    emit(HomeLoading(true));
    try {
      weatherModel = (await homeService.fetchWeatherByCityName());
      _changePagingLoading();

      if (weatherModel != null) {
        emit(HomeItemLoaded(weatherModel!));
      }
      emit(HomeItemLoaded(weatherModel!));
    } catch (e) {
      emit(HomeError(weatherModel.toString()));
    }
  }

  void _changePagingLoading() => isPagingLoading = !isPagingLoading;
}
