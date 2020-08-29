// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    id: json['id'] as int,
    companyName: json['Name'] as String,
    country: json['country'] as int,
    city: json['city'] as int,
    zipCode: json['zip_code'] as String,
    street: json['street'] as String,
    buildingNumber: json['building_number'] as int,
    email: json['email'] as String,
    phoneNumber: json['phone_number'] as String,
    mobileNumber: json['mobile_number'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'Name': instance.companyName,
      'country': instance.country,
      'city': instance.city,
      'zip_code': instance.zipCode,
      'street': instance.street,
      'building_number': instance.buildingNumber,
      'phone_number': instance.phoneNumber,
      'mobile_number': instance.mobileNumber,
      'email': instance.email,
    };
