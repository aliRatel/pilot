import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
class CheckForAvailableUsersUseCase extends UseCase<dynamic,NoParams>{

  final UserRepository userRepository;

  CheckForAvailableUsersUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, Map<String,dynamic>>> call(NoParams params) async{
    return await userRepository.getCachedUserInfo();
  }

}