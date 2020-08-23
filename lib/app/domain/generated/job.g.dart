// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entities/job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
    id: json['id'] as int,
    companyName: json['companyName'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'title': instance.title,
      'description': instance.description,
    };
