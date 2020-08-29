// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
    id: json['id'] as int,
    companyName: json['company_Name'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    countryId: json['country'] as int,
    abstract: json['abstract'] as String,
    companyId: json['publish_By'] as int,
    cityId: json['city'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    skills: json['skills'] as String,
  )
    ..city = json['city_Name'] as String
    ..country = json['country_Name'] as String;
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'company_Name': instance.companyName,
      'publish_By': instance.companyId,
      'title': instance.title,
      'skills': instance.skills,
      'description': instance.description,
      'abstract': instance.abstract,
      'country': instance.countryId,
      'city': instance.cityId,
      'city_Name': instance.city,
      'country_Name': instance.country,
      'date': instance.date?.toIso8601String(),
    };
