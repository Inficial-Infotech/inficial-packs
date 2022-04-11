import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:packs/models/EmergencyContact.dart';
import 'package:packs/utils/helpers/jsonSerializables.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  String? firstName;
  String? lastName;
  String? logoURL;
  DateTime? birthday;
  String? email;
  List<EmergencyContact>? emergencyContacts;
  String? gender;
  String? phone;
  String? regionOfInterest;
  String? uid;
  List<String>? savedDeals;

  UserModel({
    this.firstName,
    this.lastName,
    this.logoURL,
    this.gender,
    this.birthday,
    this.email,
    this.phone,
    this.emergencyContacts,
    this.regionOfInterest,
    this.uid,
    this.savedDeals,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
