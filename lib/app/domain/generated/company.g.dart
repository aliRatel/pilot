// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    id: json['id'] as int,
    companyName: json['companyName'] as String,
    country: json['country'] as String,
    city: json['city'] as String,
    zipCode: json['zipCode'] as String,
    street: json['street'] as String,
    buildingNumber: json['buildingNumber'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    phoneNumber: json['phoneNumber'] as String,
    mobileNumber: json['mobileNumber'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'country': instance.country,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'street': instance.street,
      'buildingNumber': instance.buildingNumber,
      'phoneNumber': instance.phoneNumber,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'password': instance.password,
    };
