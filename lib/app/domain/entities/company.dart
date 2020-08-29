import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/company.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Company extends Equatable {
  int id;
  @JsonKey(name:'Name')
  String companyName;
  int country;
  int city;
  @JsonKey(name:'zip_code')
  String zipCode;
  String street;
  @JsonKey(name:'building_number')
  int buildingNumber;
  @JsonKey(name:'phone_number')
  String phoneNumber;
  @JsonKey(name:'mobile_number')
  String mobileNumber;
  String email;


  Company({this.id, this.companyName, this.country, this.city, this.zipCode,
    this.street, this.buildingNumber,this.email, this.phoneNumber, this.mobileNumber});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @override
  List<Object> get props =>
      [
        id,
        companyName,
        country,
        city,
        zipCode,
        street,
        buildingNumber,
        phoneNumber,
        mobileNumber
      ];

}

