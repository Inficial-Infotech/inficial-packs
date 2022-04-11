// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PriceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) {
  return PriceModel(
    currency: json['currency'] as String?,
    value: json['value'] as int?,
    priceBeforeDiscount: json['priceBeforeDiscount'] as int?,
  );
}

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'value': instance.value,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
    };
