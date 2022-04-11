// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DealModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealModel _$DealModelFromJson(Map<String, dynamic> json) {
  return DealModel(
    uid: json['uid'] as String?,
    active: json['active'] as bool?,
    category: json['category'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    ecoCertified: json['ecoCertified'] as bool?,
    groupSize: json['groupSize'] as int?,
    availableSpaces: json['availableSpaces'] as int?,
    address: json['address'] == null
        ? null
        : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    geoloc: json['geoloc'] == null
        ? null
        : GeoPointModel.fromJson(json['geoloc'] as Map<String, dynamic>),
    price: json['price'] == null
        ? null
        : PriceModel.fromJson(json['price'] as Map<String, dynamic>),
    specialOffer: json['specialOffer'] as bool?,
    whatToBring: (json['whatToBring'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    titleImage: json['titleImage'] as String?,
    galleryImages: (json['galleryImages'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    itinerary: (json['itinerary'] as List<dynamic>?)
        ?.map((e) => IconTitleTextModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    whatsIncluded: (json['whatsIncluded'] as List<dynamic>?)
        ?.map((e) => IconTitleTextModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    specials: (json['specials'] as List<dynamic>?)
        ?.map((e) => IconTitleTextModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    covidMeasures: (json['covidMeasures'] as List<dynamic>?)
        ?.map((e) => IconTitleTextModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    cancellationPolicy: json['cancellationPolicy'] == null
        ? null
        : IconTitleTextModel.fromJson(
            json['cancellationPolicy'] as Map<String, dynamic>),
    rating: (json['rating'] as List<dynamic>?)
        ?.map((e) => RatingModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    reviews: (json['reviews'] as List<dynamic>?)
        ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DealModelToJson(DealModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'active': instance.active,
      'category': instance.category,
      'name': instance.name,
      'description': instance.description,
      'ecoCertified': instance.ecoCertified,
      'groupSize': instance.groupSize,
      'availableSpaces': instance.availableSpaces,
      'address': instance.address?.toJson(),
      'geoloc': instance.geoloc?.toJson(),
      'price': instance.price?.toJson(),
      'specialOffer': instance.specialOffer,
      'whatToBring': instance.whatToBring,
      'titleImage': instance.titleImage,
      'galleryImages': instance.galleryImages,
      'itinerary': instance.itinerary?.map((e) => e.toJson()).toList(),
      'whatsIncluded': instance.whatsIncluded?.map((e) => e.toJson()).toList(),
      'specials': instance.specials?.map((e) => e.toJson()).toList(),
      'covidMeasures': instance.covidMeasures?.map((e) => e.toJson()).toList(),
      'cancellationPolicy': instance.cancellationPolicy?.toJson(),
      'rating': instance.rating?.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
    };
