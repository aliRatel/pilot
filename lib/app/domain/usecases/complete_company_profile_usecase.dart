import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pilot/app/domain/repositories/user_repository.dart';
import 'package:pilot/core/error/failures.dart';
import 'package:pilot/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class CompleteCompanyProfileUseCase
    extends UseCase<bool, CompleteCompanyProfileParams> {
  final UserRepository userRepository;

  CompleteCompanyProfileUseCase({@required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(
      CompleteCompanyProfileParams params) async {
    return await userRepository.completeCompanyProfile(
        companyName: params.companyName,
        countryId: params.countryId,
        cityId: params.cityId,
        zipCode: params.zipCode,
        street: params.street,
        buildingNumber: params.buildingNumber,
        phoneNumber: params.phoneNumber,
        mobileNumber: params.mobileNumber);
  }

}

class CompleteCompanyProfileParams extends Equatable {
  final String companyName;
  final int countryId;
  final int cityId;
  final String zipCode;
  final String street;
  final String buildingNumber;
  final String phoneNumber;
  final String mobileNumber;


  CompleteCompanyProfileParams(
      {@required this.companyName, @required this.countryId, @required this.cityId,
        @required this.zipCode, @required this.street, @required this.buildingNumber, @required this.phoneNumber,
        @required this.mobileNumber});

  @override
  // TODO: implement props
  List<Object> get props =>
      [
        companyName,
        countryId,
        cityId,
        zipCode,
        street,
        buildingNumber,
        phoneNumber,
        mobileNumber
      ];

}