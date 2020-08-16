import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/user.dart';
import 'package:pilot/core/error/failures.dart';

abstract class UserRepository {

  //api methods
  Future<Either<Failure,User>> registerUser({String email,String password});
  Future<Either<Failure,User>> fetchUser({int id});
  Future<Either<Failure,User>> completeProfile({User user});
  Future<Either<Failure,User>> logIn({String email,String password,String userType});

}