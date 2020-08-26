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
      print(user);
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
  Future<Either<Failure, bool>> logIn(
      {String email, String password, UserType userType}) async {
    try {
      var credential = await apiDataSource.postLogIn(
          email: email, password: password, userType: userType);
      print(credential);
      await sharedPreferencesDataSource.cacheToken(credential['jwt']);
      await sharedPreferencesDataSource.cacheUserType(userType);
      await sharedPreferencesDataSource.cacheUserByType(
          id: credential['id'],
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
  Future<Either<Failure, bool>> signUp(
      {String email, String password, UserType userType}) async {
    try {
      var credential = await apiDataSource.postSignUp(
          email: email, password: password, userType: userType);
      print(credential);
      await sharedPreferencesDataSource.cacheToken(credential['jwt']);
      await sharedPreferencesDataSource.cacheUserType(userType);

      await sharedPreferencesDataSource.cacheUserByType(
          id: credential['id'],
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
          : await sharedPreferencesDataSource.fetchCachedUser();
      print('********************************' + user.toString());
      values['jwt'] = jwt;
      values['userType'] = userType;
      values['user'] = user;
      return Right(values);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> completeCompanyProfile(
      {Company company}) async {
    try {
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();

       await apiDataSource.postCompleteCompanyProfile (company:company,
          jwt: jwt) ;
     var user = await sharedPreferencesDataSource.fetchCachedCompany();
     company.email = user.email;
     company.id = user.id;
     await sharedPreferencesDataSource.cacheCompany(company);
        return Right(true);

    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }catch(e){
      return Left(UnknownFailure());

    }
  }

  @override
  Future<Either<Failure, bool>> completeJobSeekerProfile({JobSeeker jobSeeker,File cv,File personalPhoto}) async{
    try {
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();

      var result = await apiDataSource.postCompleteJobSeekerProfile (jobSeeker:jobSeeker,
          jwt: jwt,cv: cv,personalPhoto: personalPhoto) ;
     var user = await sharedPreferencesDataSource.fetchCachedUser();
       jobSeeker.cv=result['cv'];
       jobSeeker.email = user.email;
       jobSeeker.personalPhoto=result['personalPhoto'];
       await sharedPreferencesDataSource.cacheJobSeeker(jobSeeker);
       return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }catch(e){
      return Left(UnknownFailure());
    }
  }




  @override
  Future<Either<Failure, bool>> addNewJob({Job job}) async{
    try {
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();

      var result = await apiDataSource.postNewJob (job:job,
          jwt: jwt) ;

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }catch(e){
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getJobsByCompany({int pageNumber = 1}) async{
    try {
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();

      var result = await apiDataSource.getJobsByCompany(jwt: jwt,page: pageNumber);
      var jobs=((result['jobs']) as List).map((i) =>
          Job.fromJson(i)).toList();
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
  Future<Either<Failure, List<Job>>> getRecentJobs({int pageNumber = 1}) async{

    try {
      var result = await apiDataSource.getRecentJobs(page: pageNumber);

      var jobs=((result['jobs']) as List).map((i) =>
          Job.fromJson(i)).toList();
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
  Future<Either<Failure,List<Job>>> searchJobs({int pageNumber = 1, int cityId, int countryId}) async{

    try {
      var result = await apiDataSource.searchJobs(page: pageNumber,cityId: cityId,countryId: countryId);
      var jobs=((result['jobs']) as List).map((i) =>
          Job.fromJson(i)).toList();
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
  Future<Either<Failure, List<City>>> getCitiesByCountry({int countryId}) async{
    try {
      var cities = await apiDataSource.getCitiesByCountry(countryId: countryId,);
      print(cities);
      return Right( cities);
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
  Future<Either<Failure, List<Country>>> getCountries()async {
    try {
      var countries = await apiDataSource.getCountries();
      print(countries);
      return Right( countries);
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
