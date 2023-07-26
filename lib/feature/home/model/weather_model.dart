class WeatherModel {
  int? cloudPct;
  int? temp;
  int? feelsLike;
  int? humidity;
  int? minTemp;
  int? maxTemp;
  double? windSpeed;
  int? windDegrees;
  int? sunrise;
  int? sunset;

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

  WeatherModel.fromJson(Map<String, dynamic> json) {
    cloudPct = json['cloud_pct']; // _ jsonSerialazable hatası var. g dart'a gidip düzelt.
    temp = json['temp'];
    feelsLike = json['feels_like'];
    humidity = json['humidity'];
    minTemp = json['min_temp'];
    maxTemp = json['max_temp'];
    windSpeed = json['wind_speed'];
    windDegrees = json['wind_degrees'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cloud_pct'] = cloudPct;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['humidity'] = humidity;
    data['min_temp'] = minTemp;
    data['max_temp'] = maxTemp;
    data['wind_speed'] = windSpeed;
    data['wind_degrees'] = windDegrees;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
