// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      ecoCertified: json['ecoCertified'] as bool?,
      email: json['email'] as String?,
      emergencyContacts: (json['emergencyContacts'] as List<dynamic>?)
          ?.map((e) => EmergencyContact.fromJson(e as Map<String, dynamic>))
          .toList(),
      birthday: dateTimeFromJson(json['birthday'] as Timestamp?),
      firstName: json['firstName'] as String?,
      gender: json['gender'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      regionOfInterest: json['regionOfInterest'] as String?,
      uid: json['uid'] as String?,
      savedDeals: (json['savedDeals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'birthday': dateTimeToJson(instance.birthday),
      'ecoCertified': instance.ecoCertified,
      'email': instance.email,
      'emergencyContacts': instance.emergencyContacts,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'regionOfInterest': instance.regionOfInterest,
      'uid': instance.uid,
      'savedDeals': instance.savedDeals,
    };
