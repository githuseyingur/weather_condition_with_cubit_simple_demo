// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      cloudPct: json['cloudPct'] as int?,
      temp: json['temp'] as int?,
      feelsLike: json['feelsLike'] as int?,
      humidity: json['humidity'] as int?,
      minTemp: json['minTemp'] as int?,
      maxTemp: json['maxTemp'] as int?,
      windSpeed: (json['windSpeed'] as num?)?.toDouble(),
      windDegrees: json['windDegrees'] as int?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'cloudPct': instance.cloudPct,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'windSpeed': instance.windSpeed,
      'windDegrees': instance.windDegrees,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
