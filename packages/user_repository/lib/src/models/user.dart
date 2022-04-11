import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/src/models/emergency_contact.dart';
import 'package:user_repository/utils/helpers/jsonSerializables.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  DateTime? birthday;
  bool? ecoCertified;
  String? email;
  List<EmergencyContact>? emergencyContacts;
  String? firstName;
  String? gender;
  String? lastName;
  String? phone;
  String? regionOfInterest;
  String? uid;
  List<String>? savedDeals;

  User({
    this.ecoCertified,
    this.email,
    this.emergencyContacts,
    this.birthday,
    this.firstName,
    this.gender,
    this.lastName,
    this.phone,
    this.regionOfInterest,
    this.uid,
    this.savedDeals,
  });

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
