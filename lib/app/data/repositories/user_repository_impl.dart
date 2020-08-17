import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilot/app/data/datasources/local/local_data_source.dart';
import 'package:pilot/app/data/datasources/remote/remote_data_source.dart';
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
    }
  }

  @override
  Future<Either<Failure, bool>> registerUser(
      {String email, String password}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
