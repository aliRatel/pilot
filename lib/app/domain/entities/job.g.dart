// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
    id: json['id'] as int,
    companyId: json['companyId'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'title': instance.title,
      'description': instance.description,
    };
