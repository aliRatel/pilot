// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    id: json['id'] as int,
    countryId: json['countryId'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'countryId': instance.countryId,
      'name': instance.name,
    };
