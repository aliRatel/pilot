import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class CompleteCompanyProfileUseCase
    extends UseCase<bool, CompleteCompanyProfileParams> {
  final UserRepository userRepository;

  CompleteCompanyProfileUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(
      CompleteCompanyProfileParams params) async {
    return await userRepository.completeCompanyProfile(company: params.company);
  }
}

class CompleteCompanyProfileParams extends Equatable {
  final Company company;

  CompleteCompanyProfileParams({@required this.company});

  @override
  // TODO: implement props
  List<Object> get props => [company];
}
