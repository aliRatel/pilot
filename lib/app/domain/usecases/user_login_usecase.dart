import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class UserLoginUseCase extends UseCase<bool, UserLoginParams> {
  final UserRepository userRepository;

  UserLoginUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(UserLoginParams params) async {
    return await userRepository.logIn(
        email: params.email, password: params.password,userType:params.userType);
  }
}

class UserLoginParams extends Equatable {
  final String email;
  final String password;
  final UserType userType;
  UserLoginParams({@required this.email, @required this.password,@required this.userType});

  @override
  List<Object> get props => [email, password,userType];
}
