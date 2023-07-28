// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      cloudPct: json['cloud_pct'] as int?,
      temp: json['temp'] as int?,
      feelsLike: json['feels_like'] as int?,
      humidity: json['humidity'] as int?,
      minTemp: json['min_temp'] as int?,
      maxTemp: json['max_temp'] as int?,
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      windDegrees: json['wind_degrees'] as int?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'cloud_pct': instance.cloudPct,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'humidity': instance.humidity,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'wind_speed': instance.windSpeed,
      'wind_degrees': instance.windDegrees,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
