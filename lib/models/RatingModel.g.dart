// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RatingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) {
  return RatingModel(
    title: json['title'] as String,
    value: (json['value'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };
