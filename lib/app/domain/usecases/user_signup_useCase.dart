import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class UserSignUpUseCase extends UseCase<bool, UserSignUpParams> {
  final UserRepository userRepository;

  UserSignUpUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(UserSignUpParams params) async {
    return await userRepository.signUp(
        email: params.email, password: params.password,userType:params.userType);
  }
}

class UserSignUpParams extends Equatable {
  final String email;
  final String password;
  final UserType userType;
  UserSignUpParams({@required this.email, @required this.password,@required this.userType});

  @override
  List<Object> get props => [email, password,userType];
}
