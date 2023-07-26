import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/core/base/base_model.dart';
part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends BaseModel<WeatherModel> {
  final int? cloudPct;
  final int? temp;
  final int? feelsLike;
  final int? humidity;
  final int? minTemp;
  final int? maxTemp;
  final double? windSpeed;
  final int? windDegrees;
  final int? sunrise;
  final int? sunset;

  WeatherModel(
      {this.cloudPct,
      this.temp,
      this.feelsLike,
      this.humidity,
      this.minTemp,
      this.maxTemp,
      this.windSpeed,
      this.windDegrees,
      this.sunrise,
      this.sunset});

  @override
  Map<String, dynamic> toJson() {
    return _$WeatherModelToJson(this);
  }

  @override
  WeatherModel fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }

  @override
  List<Object?> get props =>
      [cloudPct, temp, feelsLike, humidity, minTemp, maxTemp, windSpeed, windDegrees, sunrise, sunset];
}
