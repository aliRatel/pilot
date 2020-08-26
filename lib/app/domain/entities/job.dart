import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part '../generated/job.g.dart';
@JsonSerializable()
class Job extends Equatable {
  int id;
  @JsonKey(name: 'company_Name')
  String companyName;
  @JsonKey(name: 'publish_By')
  int companyId;
  String title;
  String skills;
  String description;
  String abstract;
  @JsonKey(name: 'country')
  int countryId;
  @JsonKey(name: 'city')
  int cityId;
  DateTime date;

  Job(
      {@required this.id,
      @required this.companyName,
      @required this.title,
      @required this.description,
      @required this.countryId,
      @required this.abstract,
      @required this.companyId,
      @required this.cityId,
      @required this.date,
      @required this.skills});

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);

  @override
  List<Object> get props => [
        id,
        companyName,
        companyId,
        title,
        skills,
        description,
        abstract,
        countryId,
        cityId,
        date,
      ];
}
