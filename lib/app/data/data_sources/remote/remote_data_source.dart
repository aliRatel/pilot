import 'package:chopper/chopper.dart';
import 'package:pilot/app/data/data_sources/remote/services/user_remote_service.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:meta/meta.dart';

abstract class ApiDataSource {
  Future<Map<String, dynamic>> postLogIn(
      {String email, String password, UserType userType});

  Future<Map<String, dynamic>> postSignUp(
      {String email, String password, UserType userType});

  Future<bool> postCompleteCompanyProfile(
      {String companyName,
      int countryId,
      int cityId,
      String zipCode,
      String street,
      String buildingNumber,
      String phoneNumber,
      String mobileNumber,String jwt});
}

class ApiDataSourceImpl extends ApiDataSource {
  final UserRemoteService userRemoteService;

  ApiDataSourceImpl({@required this.userRemoteService});

  @override
  Future<Map<String, dynamic>> postLogIn(
      {String email, String password, UserType userType}) async {
    var body = {
      'email': email,
      'password': password,
      'userType': userType.toShortString()
    };
    var response = await userRemoteService.postLogin(body);
    print(response.statusCode);
    if (response.statusCode == 202) {
      int id = response.body['id'];
      String jwt = response.body['jwtToken'];
      return {'id': id, 'jwt': jwt};
    } else
      throw mapResponseException(response.statusCode);
  }

  @override
  Future<Map<String, dynamic>> postSignUp(
      {String email, String password, UserType userType}) async {
    var body = {
      'email': email,
      'password': password,
      'userType': userType.toShortString()
    };
    var response = await userRemoteService.postSignUp(body);
    print(response.statusCode);
    if (response.statusCode == 202) {
      int id = response.body['id'];
      String jwt = response.body['jwtToken'];
      return {'id': id, 'jwt': jwt};
    } else
      throw mapResponseException(response.statusCode);
  }

  @override
  Future<bool> postCompleteCompanyProfile (
      {String companyName,
      int countryId,
      int cityId,
      String zipCode,
      String street,
      String buildingNumber,
      String phoneNumber,
      String mobileNumber,String jwt}) async{
    var body = {
      'companyName': companyName,
      'countryId': countryId,
      'cityId': cityId,
      'zipCode': zipCode,
      'street': street,
      'buildingNumber': buildingNumber,
      'phoneNumber': phoneNumber,
      'mobileNumber':mobileNumber
    };
    var header=jwt;

  }
}
