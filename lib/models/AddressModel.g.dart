// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    buildingNumber: json['buildingNumber'] as String?,
    street: json['street'] as String?,
    city: json['city'] as String?,
    zipCode: json['zipCode'] as String?,
    state: json['state'] as String?,
    country: json['country'] as String?,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'buildingNumber': instance.buildingNumber,
      'street': instance.street,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'state': instance.state,
      'country': instance.country,
    };
