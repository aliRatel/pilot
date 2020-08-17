import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/job_seeker.g.dart';

@JsonSerializable()
class JobSeeker extends Equatable {
  int id;
  String email;
  String password;
  String nationality;
  String country;
  String city;
  String zipCode;
  String street;
  int houseNumber;
  String phoneNumber;
  String personalPhoto;
  String cv;
  String coverLetter;
  String name;
  String surname;
  DateTime birthday;

  JobSeeker(
      {this.id,
      this.email,
      this.nationality,
      this.country,
      this.city,
      this.password,
      this.zipCode,
      this.street,
      this.houseNumber,
      this.phoneNumber,
      this.personalPhoto,
      this.cv,
      this.coverLetter,
      this.name,
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
        password,
        personalPhoto,
        cv,
        coverLetter,
        name,
        birthday
      ];
}
