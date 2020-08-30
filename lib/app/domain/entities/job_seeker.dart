import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/job_seeker.g.dart';

@JsonSerializable()
class JobSeeker extends Equatable {
  int id;
  String email;
  String nationality;
  int country;
  int city;
  @JsonKey(name: 'zip_code')
  String zipCode;
  String street;
  @JsonKey(name: 'house_number')
  int houseNumber;
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  String personalPhoto;
  String cv;
  @JsonKey(name: 'cover_letter')
  String coverLetter;
  @JsonKey(name: 'Name')
  String name;
  String surname;
  @JsonKey(name: 'birth_date')
  DateTime birthday;
  @JsonKey(name:'mobile_number')
  String mobileNumber;
  String gender;


  JobSeeker(
      {this.id,
      this.email,
      this.nationality,
      this.country,
      this.city,
      this.zipCode,
      this.street,
      this.houseNumber,
      this.phoneNumber,
      this.personalPhoto,
      this.cv,
      this.coverLetter,
      this.name,
        this.gender,
        this.mobileNumber,
      this.surname,
      this.birthday});

  factory JobSeeker.fromJson(Map<String, dynamic> json) => _$JobSeekerFromJson(json);

  Map<String, dynamic> toJson() => _$JobSeekerToJson(this);

  @override
  List<Object> get props => [
        id,
        email,
        nationality,
        country,
        city,
        zipCode,
        street,
        houseNumber,
        personalPhoto,
        cv,
        coverLetter,
        name,
        birthday
      ];
}
