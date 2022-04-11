// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StartEndDateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartEndDateModel _$StartEndDateModelFromJson(Map<String, dynamic> json) {
  return StartEndDateModel(
    start: dateTimeFromJson(json['start'] as Timestamp?),
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  );
}

Map<String, dynamic> _$StartEndDateModelToJson(StartEndDateModel instance) =>
    <String, dynamic>{
      'start': dateTimeToJson(instance.start),
      'end': instance.end?.toIso8601String(),
    };
