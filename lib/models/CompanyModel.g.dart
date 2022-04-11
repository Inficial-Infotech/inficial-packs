// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  return CompanyModel(
    bio: json['bio'] as String?,
    deals: (json['deals'] as List<dynamic>?)?.map((e) => e as String).toList(),
    ecoCertified: json['ecoCertified'] as bool?,
    name: json['name'] as String?,
    averageRating: (json['averageRating'] as num?)?.toDouble(),
    supportContact: (json['supportContact'] as List<dynamic>?)
        ?.map((e) => SupportContact.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'bio': instance.bio,
      'deals': instance.deals,
      'ecoCertified': instance.ecoCertified,
      'name': instance.name,
      'averageRating': instance.averageRating,
      'supportContact':
          instance.supportContact?.map((e) => e.toJson()).toList(),
    };
