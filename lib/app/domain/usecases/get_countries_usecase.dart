import 'package:dartz/dartz.dart';
import 'package:pilot/app/domain/entities/country.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class GetCountriesUseCase extends UseCase<List<Country>, NoParams> {
  final UserRepository userRepository;

  GetCountriesUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) async {
    return await userRepository.getCountries();
  }
}
