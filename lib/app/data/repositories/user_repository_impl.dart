
import 'package:dartz/dartz.dart';
import 'package:pilot/app/data/data_sources/local/local_data_source.dart';
import 'package:pilot/app/data/data_sources/remote/remote_data_source.dart';

import 'package:pilot/app/domain/entities/enums/user_type.dart';
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
  Future<Either<Failure, bool>> completeProfile({JobSeeker user}) {
    // TODO: implement completeProfile
    throw UnimplementedError();
  }

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
  Future<Either<Failure, bool>> registerUser({String email, String password}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCachedUserInfo() async {
    try {
      Map<String, dynamic> values;
      var jwt = await sharedPreferencesDataSource.fetchCachedJwt();
      var userType = await sharedPreferencesDataSource.fetchCachedUserType();
      var user = userType == UserType.company
          ? await sharedPreferencesDataSource.fetchCachedCompany()
          : await sharedPreferencesDataSource.fetchCachedUser();
      values['jwt'] = jwt;
      values['userType']=userType;
      values['user'] = user;
      return Right(values);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
