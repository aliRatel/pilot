import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/core/error/failures.dart';


abstract class CompanyRepository{
  Future<Either<Failure,Company>> registerCompany({String email,String password});
  Future<Either<Failure,Company>> logIn({String email,String password});
  Future<Either<Failure,Company>> fetchCompany({int id});
  Future<Either<Failure,Company>> completeCompanyProfile({Company company});

}