// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/job_seeker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobSeeker _$JobSeekerFromJson(Map<String, dynamic> json) {
  return JobSeeker(
    id: json['id'] as int,
    email: json['email'] as String,
    nationality: json['nationality'] as String,
    country: json['country'] as String,
    city: json['city'] as String,
    password: json['password'] as String,
    zipCode: json['zipCode'] as String,
    street: json['street'] as String,
    houseNumber: json['houseNumber'] as int,
    phoneNumber: json['phoneNumber'] as String,
    personalPhoto: json['personalPhoto'] as String,
    cv: json['cv'] as String,
    coverLetter: json['coverLetter'] as String,
    name: json['name'] as String,
    surname: json['surname'] as String,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
  );
}

Map<String, dynamic> _$JobSeekerToJson(JobSeeker instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'nationality': instance.nationality,
      'country': instance.country,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'street': instance.street,
      'houseNumber': instance.houseNumber,
      'phoneNumber': instance.phoneNumber,
      'personalPhoto': instance.personalPhoto,
      'cv': instance.cv,
      'coverLetter': instance.coverLetter,
      'name': instance.name,
      'surname': instance.surname,
      'birthday': instance.birthday?.toIso8601String(),
    };
