import 'package:chopper/chopper.dart';
import 'package:pilot/app/data/datasources/remote/services/user_remote_service.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/core/error/exceptions.dart';

abstract class ApiDataSource {
  Future<Map<String, dynamic>> postLogIn(
      {String email, String password, UserType userType});
}

class ApiDataSourceImpl extends ApiDataSource {
  final UserRemoteService userRemoteService = UserRemoteService.create();

  @override
  Future<Map<String, dynamic>> postLogIn(
      {String email, String password, UserType userType}) async {
    var body = {'email': email, 'password': password, 'userType': userType};
    var response = await userRemoteService.postLogin(body);
    if (response.statusCode == 202) {
      int id = response.body['id'];
      String jwt = response.body['jwtToken'];
      return {'id': id, 'jwt': jwt};
    }else throw mapResponseException(response.statusCode);
  }
}
