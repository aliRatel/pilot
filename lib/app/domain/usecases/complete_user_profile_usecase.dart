import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class CompleteJobSeekerProfileUseCase
    extends UseCase<bool, CompleteJobSeekerProfileParams> {
  final UserRepository userRepository;

  CompleteJobSeekerProfileUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(
      CompleteJobSeekerProfileParams params) async {
    return await userRepository.completeJobSeekerProfile(
        jobSeeker: params.jobSeeker,
        cv: params.cv,
        personalPhoto: params.personalPhoto);
  }
}

class CompleteJobSeekerProfileParams extends Equatable {
  final JobSeeker jobSeeker;
  final File cv;
  final File personalPhoto;

  CompleteJobSeekerProfileParams(
      {@required this.jobSeeker,
      @required this.cv,
      @required this.personalPhoto});

  @override
  List<Object> get props => [jobSeeker, cv, personalPhoto];
}
