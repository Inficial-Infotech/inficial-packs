// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmergencyContact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) {
  return EmergencyContact(
    email: json['email'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    title: json['title'] as String?,
    phone: json['phone'] as String?,
  );
}

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'title': instance.title,
      'phone': instance.phone,
    };
