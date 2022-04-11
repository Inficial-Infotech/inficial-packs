import 'package:json_annotation/json_annotation.dart';

part 'PriceModel.g.dart';

@JsonSerializable()
class PriceModel {
  String? currency;
  int? value;
  int? priceBeforeDiscount;

  PriceModel({
    this.currency,
    this.value,
    this.priceBeforeDiscount,
  });

  factory PriceModel.fromJson(Map<String, dynamic> data) =>
      _$PriceModelFromJson(data);

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);
}
