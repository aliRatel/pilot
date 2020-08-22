import 'dart:html';

import 'package:chopper/chopper.dart';
import 'package:pilot/app/data/data_sources/remote/services/user_remote_service.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:meta/meta.dart';

abstract class ApiDataSource {
  Future<Map<String, dynamic>> postLogIn(
      {String email, String password, UserType userType});

  Future<Map<String, dynamic>> postSignUp(
      {String email, String password, UserType userType});

  Future<bool> postCompleteCompanyProfile(
      {Company company,String jwt});

  Future<bool> postCompleteJobSeekerProfile(
      {JobSeeker jobSeeker,String jwt});
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
      {Company company,String jwt}) async{
    var companyJson =  company.toJson();
    var header=jwt;
    var response = await userRemoteService.postCompleteCompanyProfile(companyJson, jwt);
    if(response.statusCode == 200)
      return true;
    else throw ServerException();

  }

  @override
  Future<bool> postCompleteJobSeekerProfile({JobSeeker jobSeeker, String jwt,File cv,File personalPhoto}) async{

    var jobSeekerJson =  jobSeeker.toJson();
    var header=jwt;
    var response = await userRemoteService.postCompleteCompanyProfile(jobSeekerJson, jwt);
    if(response.statusCode == 200)
      return true;
    else throw ServerException();
  }
}
