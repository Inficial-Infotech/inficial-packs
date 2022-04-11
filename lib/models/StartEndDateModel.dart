import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:packs/utils/helpers/jsonSerializables.dart';
part 'StartEndDateModel.g.dart';

@JsonSerializable()
class StartEndDateModel {
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  DateTime? start;
  DateTime? end;

  StartEndDateModel({
    this.start,
    this.end,
  });

  factory StartEndDateModel.fromJson(Map<String, dynamic> data) =>
      _$StartEndDateModelFromJson(data);

  Map<String, dynamic> toJson() => _$StartEndDateModelToJson(this);
}
