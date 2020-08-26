import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class SearchJobsUseCase
    extends UseCase<Map<String, dynamic>, SearchJobsParams> {
  final UserRepository userRepository;

  SearchJobsUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      SearchJobsParams params) async {
    return await userRepository.searchJobs(
        pageNumber: params.pageNumber,
        cityId: params.cityId,
        countryId: params.countryId);
  }
}

class SearchJobsParams extends Equatable {
  final int pageNumber;
  final int cityId;
  final int countryId;

  SearchJobsParams(
      {@required this.pageNumber,
      @required this.cityId,
      @required this.countryId});

  @override
  // TODO: implement props
  List<Object> get props => [pageNumber, cityId, countryId];
}
