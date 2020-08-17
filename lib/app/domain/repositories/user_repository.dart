import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/core/error/failures.dart';

abstract class UserRepository {

  //api methods
  Future<Either<Failure,JobSeeker>> registerUser({String email,String password});
  Future<Either<Failure,JobSeeker>> fetchUser({int id});
  Future<Either<Failure,JobSeeker>> completeProfile({JobSeeker user});
  Future<Either<Failure,JobSeeker>> logIn({String email,String password,UserType userType});

}