import 'package:json_annotation/json_annotation.dart';

part 'AddressModel.g.dart';

@JsonSerializable()
class AddressModel {
  String? buildingNumber;
  String? street;
  String? city;
  String? zipCode;
  String? state;
  String? country;

  AddressModel({
    this.buildingNumber,
    this.street,
    this.city,
    this.zipCode,
    this.state,
    this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> data) =>
      _$AddressModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
