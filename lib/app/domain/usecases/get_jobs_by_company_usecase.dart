import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
class GetJobsByCompanyUseCase extends UseCase< List<Job>,GetJobsByCompanyParams>{
  final UserRepository userRepository ;

  GetJobsByCompanyUseCase({@required this.userRepository});

  @override
  Future<Either<Failure,  List<Job>>> call(GetJobsByCompanyParams params) async {
return await userRepository.getJobsByCompany(pageNumber: params.pageNumber);
  }
}

class GetJobsByCompanyParams extends Equatable{
  final int pageNumber;

  GetJobsByCompanyParams({@required  this.pageNumber});

  @override
  // TODO: implement props
  List<Object> get props => [pageNumber];
}