import 'package:json_annotation/json_annotation.dart';

part 'SupportContact.g.dart';

@JsonSerializable()
class SupportContact {
  String? email;
  String? firstName;
  String? lastName;
  String? title;
  String? phone;

  SupportContact({
    this.email,
    this.firstName,
    this.lastName,
    this.title,
    this.phone,
  });

  factory SupportContact.fromJson(Map<String, dynamic> data) =>
      _$SupportContactFromJson(data);

  Map<String, dynamic> toJson() => _$SupportContactToJson(this);
}
