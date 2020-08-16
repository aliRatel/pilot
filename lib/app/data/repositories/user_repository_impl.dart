import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/user.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:pilot/core/error/failures.dart';

class UserRepositoryImpl extends UserRepository {
//datasource (shared prefs,api,sqlite .....)
  @override
  Future<Either<Failure, User>> completeProfile({User user}) {
    // TODO: implement completeProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> fetchUser({int id}) {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> logIn(
      {String email, String password, String userType}) async {
    try {
     return Future.delayed(Duration(seconds: 4),()=> Left(ServerFailure()));

    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }

    //await
  }

  @override
  Future<Either<Failure, User>> registerUser({String email, String password}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
