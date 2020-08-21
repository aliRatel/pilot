import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/company.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Company extends Equatable {
  int id;
  String companyName;
  int country;
  int city;
  String zipCode;
  String street;
  String buildingNumber;
  String phoneNumber;
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

