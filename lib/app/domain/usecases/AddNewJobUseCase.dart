import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class AddNewJobUseCase extends UseCase<bool, AddNewJobParams> {
  final UserRepository userRepository;

  AddNewJobUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(AddNewJobParams params) {
    userRepository.addNewJob(job:params.job);
  }
}

class AddNewJobParams extends Equatable {
  final Job job;

  AddNewJobParams({@required this.job});

  @override
  List<Object> get props => [job];
}
