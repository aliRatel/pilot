import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/entities/city.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class GetCitiesByCountryUseCase
    extends UseCase<List<City>, GetCitiesByCountryParams> {
  final UserRepository userRepository;

  GetCitiesByCountryUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, List<City>>> call(
      GetCitiesByCountryParams params) async {
    return await userRepository.getCitiesByCountry(countryId: params.countryId);
  }
}

class GetCitiesByCountryParams extends Equatable {
  final int countryId;

  GetCitiesByCountryParams({@required this.countryId});

  @override
  List<Object> get props => [countryId];
}
