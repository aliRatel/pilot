import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/repositories/company_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class CompanyLoginUseCase extends UseCase<Company, CompanyLoginParams> {
  final CompanyRepository companyRepository;

  CompanyLoginUseCase({@required this.companyRepository});

  @override
  Future<Either<Failure, Company>> call(CompanyLoginParams params) async {
    return await companyRepository.logIn(
        email: params.email, password: params.password);
  }
}

class CompanyLoginParams extends Equatable {
  final String email;
  final String password;

  CompanyLoginParams({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
