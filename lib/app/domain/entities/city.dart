import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part '../generated/city.g.dart';
@JsonSerializable()
class City extends Equatable{
  final int id;
  final int countryId;
  final String name;

  City({@required this.id,@required this.countryId,@required this.name});

  factory City.fromJson(Map<String,dynamic> json) => _$CityFromJson(json);
  Map<String,dynamic> toJson() => _$CityToJson(this);
  @override
  List<Object> get props => [id,countryId,name];
}