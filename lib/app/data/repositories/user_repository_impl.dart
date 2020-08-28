import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilot/app/data/data_sources/local/local_data_source.dart';
import 'package:pilot/app/data/data_sources/remote/remote_data_source.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/country.dart';

import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl extends UserRepository {
  final ApiDataSource apiDataSource;
  final SharedPreferencesDataSource sharedPreferencesDataSource;

  UserRepositoryImpl(
      {@required this.apiDataSource,
      @required this.sharedPreferencesDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchUser({int id}) async {
    try {
      var user = await apiDataSource.getUser(id: id);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserType>> logIn(
      {String email, String password}) async {
    try {
      var credential = await apiDataSource.postLogIn(
          email: email, password: password);
      print(credential);
      await sharedPreferencesDataSource.cacheToken(credential['jwt']);
      int index = credential['userType'];
      UserType responseUserType= userTypeFromIndex(index);
      await sharedPreferencesDataSource.cacheUserType(responseUserType);
      await sharedPreferencesDataSource.cacheUserByType(
          id: credential['id'],
          email: email,
          password: password,
          userType: responseUserType);
      return Right(responseUserType);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signUp(
      {String email, String password, UserType userType}) async {
    try {
      var credential = await apiDataSource.postSignUp(
          email: email, password: password, userType: userType);
      print(credential);
      await sharedPreferencesDataSource.cacheToken(credential['jwt']);
      await sharedPreferencesDataSource.cacheUserType(userType);

      await sharedPreferencesDataSource.cacheUserByType(

          email: email,
          password: password,
          userType: userType);
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCachedUserInfo() async {
    try {
      Map<String, dynamic> values = new Map();
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();

      var userType = await sharedPreferencesDataSource.fetchCachedUserType();
      var user = (userType == UserType.company)
          ? await sharedPreferencesDataSource.fetchCachedCompany()
          : await sharedPreferencesDataSource.fetchCachedJobSeeker();
      values['jwt'] = jwt;
      values['userType'] = userType;
      values['user'] = user;
      return Right(values);
    } on CacheException {
      return Left(CacheFailure());
    }catch(e){
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> completeCompanyProfile(
      {Company company}) async {
    try {
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();

      await apiDataSource.postCompleteCompanyProfile(
          company: company, jwt: jwt);
      var user = await sharedPreferencesDataSource.fetchCachedCompany();
      company.email = user.email;
      company.id = user.id;
      await sharedPreferencesDataSource.cacheCompany(company);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> completeJobSeekerProfile(
      {JobSeeker jobSeeker, File cv, File personalPhoto}) async {
    try {
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();

      var result = await apiDataSource.postCompleteJobSeekerProfile(
          jobSeeker: jobSeeker, jwt: jwt, cv: cv, personalPhoto: personalPhoto);
      print(result);
      var user = await sharedPreferencesDataSource.fetchCachedJobSeeker();
      jobSeeker.cv = result['cv'];
      jobSeeker.email = user.email;
      jobSeeker.personalPhoto = result['personalPhoto'];
      await sharedPreferencesDataSource.cacheJobSeeker(jobSeeker);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      print(e);
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addNewJob({Job job}) async {
    try {

       var jwt = await sharedPreferencesDataSource.fetchCachedJwt();
//      var jwt = 'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNTgsInVzZXJuYW1lIjoiQWRtaW5AZXhhbXBsZS5jb20iLCJleHAiOjE2MDEwMzE0MDMsImVtYWlsIjoiQWRtaW5AZXhhbXBsZS5jb20ifQ.ayKykGPdXGLBn2JO_l5RnyniTPosfwa-BuhmCGljLug';

      var result = await apiDataSource.postNewJob(job: job, jwt: jwt);
print('-*-*-*-*--**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*');
print(result);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      print(e);
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getJobsByCompany(
      {int pageNumber = 1}) async {
    try {
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();
//      var jwt ='bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNTgsInVzZXJuYW1lIjoiQWRtaW5AZXhhbXBsZS5jb20iLCJleHAiOjE2MDEwMzE0MDMsImVtYWlsIjoiQWRtaW5AZXhhbXBsZS5jb20ifQ.ayKykGPdXGLBn2JO_l5RnyniTPosfwa-BuhmCGljLug';
      // var comp = await sharedPreferencesDataSource.fetchCachedCompany();
      // var id = comp.id;

      var result = await apiDataSource.getJobsByCompany(jwt: jwt, page: 158);
      var jobs =
          ((result['jobs']) as List).map((i) => Job.fromJson(i)).toList();
      print(jobs);
      return Right(jobs);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getRecentJobs({int pageNumber = 1}) async {
    try {
      var result = await apiDataSource.getRecentJobs(page: pageNumber);

      var jobs =
          ((result['jobs']) as List).map((i) => Job.fromJson(i)).toList();
      return Right(jobs);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Job>>> searchJobs(
      {int pageNumber = 1, int cityId, int countryId}) async {
    try {
      var result = await apiDataSource.searchJobs(
          page: pageNumber, cityId: cityId, countryId: countryId);
      var jobs =
          ((result['jobs']) as List).map((i) => Job.fromJson(i)).toList();
      return Right(jobs);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<City>>> getCitiesByCountry(
      {int countryId}) async {
    try {
      var result = await apiDataSource.getCitiesByCountry(
        countryId: countryId,
      );
      var cities =
          ((result['cities']) as List).map((i) => City.fromJson(i)).toList();
      print(cities);
      return Right(cities);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Country>>> getCountries() async {
    try {
      var result = await apiDataSource.getCountries();

      var countries = ((result['countries']) as List)
          .map((i) => Country.fromJson(i))
          .toList();
      return Right(countries);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      print(e);
      return left(UnknownFailure());
    }
  }
}
