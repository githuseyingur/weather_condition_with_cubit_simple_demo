import "package:json_annotation/json_annotation.dart";
import "package:weather_app/core/base/base_model.dart";
part "city_model.g.dart";

@JsonSerializable()
class CityModel extends BaseModel<CityModel> {
  final int? id;
  final String? name;
  final String? latitude;
  final String? longitude;
  final int? population;
  final String? region;

  CityModel({this.id, this.name, this.latitude, this.longitude, this.population, this.region});

  @override
  Map<String, dynamic> toJson() {
    return _$CityModelToJson(this);
  }

  @override
  CityModel fromJson(Map<String, dynamic> json) {
    return _$CityModelFromJson(json);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, latitude, longitude, population, region];
}
