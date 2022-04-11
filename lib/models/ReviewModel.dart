import 'package:json_annotation/json_annotation.dart';

part 'ReviewModel.g.dart';

@JsonSerializable()
class ReviewModel {
  String title;
  String text;
  double value;

  ReviewModel({
    required this.title,
    required this.text,
    required this.value,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> data) =>
      _$ReviewModelFromJson(data);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
