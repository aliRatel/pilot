import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

const CACHED_LOCAl_USER = 'CACHED_LOCAL_USER';
const CACHED_TOKEN = 'CACHED_TOKEN';
const CACHED_CREDENTIALS = 'CACHED_CREDENTIALS';
const CACHED_USER_TYPE = 'CACHED_USER_TYPE';
const CACHED_USER_STATE = 'CACHED_USER_STATE';


abstract class SharedPreferencesDataSource {
  Future<JobSeeker> fetchCachedJobSeeker();

  Future<Company> fetchCachedCompany();

  Future<String> fetchCachedJwt();

  Future<UserType> fetchCachedUserType();

  Future<bool> deleteCachedUser();

  Future<bool> deleteCachedCompany();

  Future<bool> cacheJobSeeker(JobSeeker jobSeeker);

  Future<bool> cacheCompany(Company company);

  Future<bool> cacheUserCredentials(Map<String, dynamic> credentials);

  Future<bool> deleteUserCredentials();

  Future<bool> cacheUserType(UserType userType);

  Future<bool> cacheToken(String jwt);

  Future<bool> deleteToken();

  Future<bool> cacheUserByType(
      {int id, String email, String password, UserType userType});

  Future<bool>cacheUserState(bool completed) ;
  Future<bool> fetchUserState();
}

class SharedPreferencesDataSourceImpl extends SharedPreferencesDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferencesDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<bool> cacheCompany(Company company) async {
    var result = await sharedPreferences.setString(
        CACHED_LOCAl_USER, json.encode(company.toJson()));
    if (result) {
      return Future.value(result);
    }

    throw CacheException;
  }

  @override
  Future<bool> cacheJobSeeker(JobSeeker jobSeeker) async {
    jobSeeker.birthday= DateTime.now();
    var result = await sharedPreferences.setString(
        CACHED_LOCAl_USER, json.encode(jobSeeker));
    if (result) return result;

    throw CacheException;
  }

  @override
  Future<bool> cacheToken(String jwt) async {
    bool result = await sharedPreferences.setString(CACHED_TOKEN, 'bearer '+jwt);
    if (result) return result;
    throw CacheException();
  }

  @override
  Future<bool> cacheUserCredentials(Map<String, dynamic> credentials) {
    // TODO: implement cacheUserCredentials
    throw UnimplementedError();
  }

  @override
  Future<bool> cacheUserType(UserType userType) async {

    bool result = await sharedPreferences.setString(
        CACHED_USER_TYPE, userType.toShortString());
    if (result) return result;
    throw CacheException();
  }

  @override
  Future<bool> deleteCachedCompany() {
    // TODO: implement deleteCachedCompany
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCachedUser() {
    // TODO: implement deleteCachedUser
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteToken() {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteUserCredentials() {
    // TODO: implement deleteUserCredentials
    throw UnimplementedError();
  }

  @override
  Future<Company> fetchCachedCompany() {
    var result = sharedPreferences.getString(CACHED_LOCAl_USER);
    if (result != null) {
      return Future.value(Company.fromJson(json.decode(result)));
    }
    throw CacheException();
  }

  @override
  Future<JobSeeker> fetchCachedJobSeeker() {
    var result = sharedPreferences.getString(CACHED_LOCAl_USER);
    if (result != null) {
      //return Future.value(JobSeeker.fromJson(json.decode(result)));
    }
    throw CacheException();
  }

  @override
  Future<bool> cacheUserByType(
      {int id, String email, String password, UserType userType}) async {
    if (userType == UserType.company) {
      Company company = Company(id: id, email: email);

      var result = await cacheCompany(company);
      if (result) return Future.value(result);
      throw CacheException();
    } else if (userType == UserType.jobSeeker) {
      JobSeeker jobSeeker = JobSeeker(id: id, email: email);
      print(jobSeeker);

      var result = await cacheJobSeeker(jobSeeker);
      if (result) return Future.value(result);
      throw CacheException();
    }

  }

  @override
  Future<String> fetchCachedJwt() {
    var jwt = sharedPreferences.getString(CACHED_TOKEN);
    print(jwt);
    if (jwt != null)
      return Future.value(jwt);

      throw CacheException();
  }

  @override
  Future<UserType> fetchCachedUserType() async {
    var result = sharedPreferences.getString(CACHED_USER_TYPE);
    UserType userType = userTypeFromString(result);
    if (userType != null)
      return userType;

      throw CacheException();
  }

  @override
  Future<bool> cacheUserState(bool completed) async {
    var result = await sharedPreferences.setString(
        CACHED_USER_STATE, completed.toString());
    if (result) {
      return Future.value(result);
    }

    throw CacheException;
  }
  @override
  Future<bool> fetchUserState() async {
    var result = sharedPreferences.getString(CACHED_USER_STATE);
    print(result.toLowerCase());
    var completed = result.toLowerCase() == 'true';
    if (completed) {
      return Future.value(completed);
    }else if(!completed)
return Future.value(completed);
    else
    throw CacheException;
  }
}
