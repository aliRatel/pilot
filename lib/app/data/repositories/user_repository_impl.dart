import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/user.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';

class UserRepositoryImpl extends UserRepository{

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
  Future<Either<Failure, User>> logIn({String email, String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> registerUser({String email, String password}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

}