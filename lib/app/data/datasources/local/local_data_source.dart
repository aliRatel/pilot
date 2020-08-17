import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const CACHED_LOCAl_USER = 'CACHED_LOCAL_USER';
const CACHED_TOKEN = 'CACHED_TOKEN';
const CACHED_CREDENTIALS = 'CACHED_CREDENTIALS';
const CACHED_USER_TYPE = 'CACHED_USER_TYPE';

abstract class SharedPreferencesDataSource {
  Future<JobSeeker> fetchCachedUser();

  Future<Company> fetchCachedCompany();

  Future<bool> deleteCachedUser();

  Future<bool> deleteCachedCompany();

  Future<bool> cacheUser(JobSeeker user);

  Future<bool> cacheCompany(Company company);

  Future<bool> cacheUserCredentials(Map<String, dynamic> credentials);

  Future<bool> deleteUserCredentials();

  Future<bool> cacheUserType();

  Future<bool> cacheToken(String jwt);

  Future<bool> deleteToken();
}

class SharedPreferencesDataSourceImpl extends SharedPreferencesDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferencesDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<bool> cacheCompany(Company company) async{
    var result = await sharedPreferences.setString('comp', company.toJson().toString());
    if(result ==true) return true;
    else throw CacheException;
  }

  @override
  Future<bool> cacheToken(String jwt) {
    // TODO: implement cacheToken
    throw UnimplementedError();
  }

  @override
  Future<bool> cacheUser(JobSeeker user) {
    // TODO: implement cacheUser
    throw UnimplementedError();
  }

  @override

  Future<bool> cacheUserCredentials(Map<String,dynamic> credentials) {
    // TODO: implement cacheUserCredentials
    throw UnimplementedError();
  }

  @override
  Future<bool> cacheUserType() {
    // TODO: implement cacheUserType
    throw UnimplementedError();
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
    // TODO: implement fetchCachedCompany
    throw UnimplementedError();
  }

  @override
  Future<JobSeeker> fetchCachedUser() {
    // TODO: implement fetchCachedUser
    throw UnimplementedError();
  }



}