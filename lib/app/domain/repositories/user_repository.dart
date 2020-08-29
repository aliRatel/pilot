
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/country.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:meta/meta.dart';
abstract class UserRepository {
  //api methods
  Future<Either<Failure, bool>> signUp(
      {String email, String password, UserType userType});

  Future<Either<Failure, Map<String, dynamic>>> fetchUser({int id});

  Future<Either<Failure, bool>> completeJobSeekerProfile({JobSeeker jobSeeker,File cv,File personalPhoto});

  Future<Either<Failure, bool>> completeCompanyProfile({Company company});

  Future<Either<Failure, UserType>> logIn(
      {String email, String password});

  Future<Either<Failure, Map<String, dynamic>>> getCachedUserInfo();

  Future<Either<Failure,bool>> addNewJob({Job job});
  Future<Either<Failure,List<Job>>> getRecentJobs({int pageNumber=1});
  Future<Either<Failure,List<Job>>> searchJobs({int pageNumber=1, int cityId,int countryId});
  Future<Either<Failure,List<Job>>> getJobsByCompany();
  Future<Either<Failure,List<Country>>> getCountries();
  Future<Either<Failure,List<City>>> getCitiesByCountry({int countryId});
}
