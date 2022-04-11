import 'package:json_annotation/json_annotation.dart';

part 'EmergencyContact.g.dart';

@JsonSerializable()
class EmergencyContact {
  String? email;
  String? firstName;
  String? lastName;
  String? title;
  String? phone;

  EmergencyContact({
    this.email,
    this.firstName,
    this.lastName,
    this.title,
    this.phone,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> data) =>
      _$EmergencyContactFromJson(data);

  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);
}
