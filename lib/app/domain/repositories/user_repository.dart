import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/user.dart';
import 'package:pilot/core/error/failures.dart';

abstract class UserRepository {

  //api methods
  Future<Either<User,Failure>> registerUser(String email,String password);
  Future<Either<User,Failure>> fetchUser(int id);
  Future<Either<User,Failure>> completeProfile(User user);
  Future<Either<User,Failure>> logIn(String email,String password);


}