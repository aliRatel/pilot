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
  Future<Either<Failure, bool>> fetchUser({int id}) {
    // TODO: implement fetchUser
    throw UnimplementedError();
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

  /* TODO yhya : some notes before you start coding :
      1- I will figure something out  with the web team  to change jobs.companyId => jobs.companyName so we don't have to send another request to get the company name with its Id or do any populating
      2- all the below methods will use query params instead of body except for the addNewJob(Job job) method
      3- remember to generate chopper services with build runner using filename.chopper.dart instead of filename.g.dart /// this one had me stuck for a while  :)  :)  :)  :)  :)
      4- you can always  use whatever status codes you fell right
      5- create a separate method in the ApiDataSource for each one of the below todos
      6-  thank you and have fun
  */


  @override
  Future<Either<Failure, bool>> addNewJob({Job job}) async{
    // TODO yhya : please get the jwt from shared prefs and send a post request with the apiDataSource that has a (jwt as bearer header and a job as json )
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getJobsByCompany({int pageNumber = 1}) async{
    /* TODO yhya :please  send a post request after getting the jwt from shared Prefs because it will be used in the back end to get the current company Id
        using the apiDataSource method that has a ( a pageNumber with default 1  )
         should return a map with keys ('jobs' as list of jobs after deserialize  ,'totalPages' as int indicating the total number of pages after considering that each page contains only 10 jobs
    */
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getRecentJobs({int pageNumber = 1}) async{
    // TODO yhya: the same as getJobsByCompany but we are just getting the recent jobs (each page contains 10 items) /// no jwt needed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> searchJobs({int pageNumber = 1, int cityId, int countryId}) async{
    // TODO yhya: the same as getRecentJobs but we are just getting the recent jobs (each page contains 10 items) considering the city and country Id ,,, note : I think that City Id will be Enough /// no jwt needed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<City>>> getCitiesByCountry({int countryId}) {
    // TODO yhya: a simple get request to get all cities of a specific country
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Country>>> getCountries() {
    // TODO yhya: a simple get request to get all countries
    throw UnimplementedError();
  }

}
