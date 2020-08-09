import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/country.g.dart';
@JsonSerializable()
class Country extends Equatable {
  int id;
  String name;

  Country({@required this.id, @required this.name});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object> get props => [id, name];
}
