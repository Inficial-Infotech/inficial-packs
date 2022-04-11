import 'package:json_annotation/json_annotation.dart';

part 'IconTitleTextModel.g.dart';

@JsonSerializable()
class IconTitleTextModel {
  String? icon;
  String? title;
  String? text;

  IconTitleTextModel({
    this.icon,
    this.title,
    this.text,
  });

  factory IconTitleTextModel.fromJson(Map<String, dynamic> data) =>
      _$IconTitleTextModelFromJson(data);

  Map<String, dynamic> toJson() => _$IconTitleTextModelToJson(this);
}
