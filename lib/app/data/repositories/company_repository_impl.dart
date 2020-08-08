import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/repositories/company_repository.dart';
import 'package:pilot/core/error/failures.dart';

class CompanyRepositoryImpl extends CompanyRepository{
  @override
  Future<Either<Failure, Company>> completeCompanyProfile({Company company}) {
    // TODO: implement completeCompanyProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Company>> fetchCompany({int id}) {
    // TODO: implement fetchCompany
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Company>> logIn({String email, String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Company>> registerCompany({String email, String password}) {
    // TODO: implement registerCompany
    throw UnimplementedError();
  }

}