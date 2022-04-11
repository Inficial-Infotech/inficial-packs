import 'package:json_annotation/json_annotation.dart';
import 'package:packs/models/SupportContact.dart';
import 'AddressModel.dart';

part 'CompanyModel.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyModel {
  String? bio;
  List<String>? deals;
  bool? ecoCertified;
  String? name;
  double? averageRating;
  List<SupportContact>? supportContact;
  AddressModel? address;
  String? logoURL;

  CompanyModel({
    this.bio,
    this.deals,
    this.ecoCertified,
    this.name,
    this.averageRating,
    this.supportContact,
    this.address,
    this.logoURL,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> data) =>
      _$CompanyModelFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
