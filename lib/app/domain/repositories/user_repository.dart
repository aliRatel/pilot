import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/core/error/failures.dart';

abstract class UserRepository {

  //api methods
  Future<Either<Failure, bool>> signUp({String email, String password,UserType userType});

  Future<Either<Failure, bool>> fetchUser({int id});

  Future<Either<Failure, bool>> completeJobSeekerProfile({JobSeeker user});
  Future<Either<Failure, bool>> completeCompanyProfile(
      {String companyName,
      int countryId,
      int cityId,
      String zipCode,
      String street,String buildingNumber,String phoneNumber,String mobileNumber});

  Future<Either<Failure, bool>> logIn(
      {String email, String password, UserType userType});

  Future<Either<Failure, Map<String, dynamic>>> getCachedUserInfo();

}