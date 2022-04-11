// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeoPointModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoPointModel _$GeoPointModelFromJson(Map<String, dynamic> json) {
  return GeoPointModel(
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$GeoPointModelToJson(GeoPointModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
