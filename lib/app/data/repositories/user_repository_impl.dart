import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:pilot/core/error/failures.dart';

class UserRepositoryImpl extends UserRepository {
//datasource (shared prefs,api,sqlite .....)
  @override
  Future<Either<Failure, JobSeeker>> completeProfile({JobSeeker user}) {
    // TODO: implement completeProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, JobSeeker>> fetchUser({int id}) {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, JobSeeker>> logIn(
      {String email, String password, UserType userType}) async {
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
  Future<Either<Failure, JobSeeker>> registerUser({String email, String password}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
