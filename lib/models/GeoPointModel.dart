import 'package:json_annotation/json_annotation.dart';

part 'GeoPointModel.g.dart';

@JsonSerializable()
class GeoPointModel {
  double lat;
  double lng;

  GeoPointModel({
    required this.lat,
    required this.lng,
  });

  factory GeoPointModel.fromJson(Map<String, dynamic> data) =>
      _$GeoPointModelFromJson(data);

  Map<String, dynamic> toJson() => _$GeoPointModelToJson(this);
}
