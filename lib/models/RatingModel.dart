import 'package:json_annotation/json_annotation.dart';

part 'RatingModel.g.dart';

@JsonSerializable()
class RatingModel {
  String title;
  double value;

  RatingModel({
    required this.title,
    required this.value,
  });

  factory RatingModel.fromJson(Map<String, dynamic> data) =>
      _$RatingModelFromJson(data);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
