import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
class GetRecentJobsUseCase extends UseCase<Map<String,dynamic>,GetRecentJobsParams>{
  final UserRepository userRepository;

  GetRecentJobsUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(GetRecentJobsParams params) async {
    return await userRepository.getRecentJobs(pageNumber: params.pageNumber);
  }


}

class GetRecentJobsParams extends Equatable{
  final int pageNumber;

  GetRecentJobsParams({@required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];

}