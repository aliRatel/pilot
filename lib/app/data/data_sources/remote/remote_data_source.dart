
import 'dart:convert';
import 'dart:io';


import 'package:pilot/app/data/data_sources/remote/services/user_remote_service.dart';
import 'package:pilot/app/domain/entities/company.dart';
import 'package:pilot/app/domain/entities/enums/user_type.dart';
import 'package:pilot/app/domain/entities/job.dart';
import 'package:pilot/app/domain/entities/job_seeker.dart';
import 'package:pilot/core/error/exceptions.dart';
import 'package:meta/meta.dart';

abstract class ApiDataSource {
  Future<Map<String, dynamic>> postLogIn(
      {String email, String password});

  Future<Map<String, dynamic>> postSignUp(
      {String email, String password, UserType userType});

  Future<bool> postCompleteCompanyProfile(
      {Company company,String jwt});

  Future<Map<String,dynamic>> postCompleteJobSeekerProfile(
      {JobSeeker jobSeeker,String jwt,File cv,File personalPhoto});

  Future<Map<String, dynamic>> getUser(
      {int id});


  Future<bool> postNewJob(
      {Job job,String jwt});

  Future<Map<String, dynamic>> getJobsByCompany(
      {String jwt});

  Future<Map<String, dynamic>> getRecentJobs(
      {int page});

  Future<Map<String, dynamic>> searchJobs(
      {int page,int cityId, int countryId});

  Future<Map<String, dynamic>> getCitiesByCountry(
      {int countryId});

  Future<Map<String, dynamic>> getCountries();

}

class ApiDataSourceImpl extends ApiDataSource {
  final UserRemoteService userRemoteService;

  ApiDataSourceImpl({@required this.userRemoteService});

  @override
  Future<Map<String, dynamic>> postLogIn(
      {String email, String password}) async {
    var body = {
      'email': email,
      'password': password,
    };
    var response = await userRemoteService.postLogin(body);
    print(response.error);

    if (response.statusCode == 200) {
      int id = response.body['user_id'];
      String jwt = response.body['token'];

      int userType = response.body['user_type'];
      return {'id': id, 'jwt': jwt,'userType':userType,'completed': response.body['completed']};
    } else
      throw mapResponseException(response.statusCode);
  }

  @override
  Future<Map<String, dynamic>> postSignUp(
      {String email, String password, UserType userType}) async {
    var body = {'user': {
      'email': email,
      'password': password,
      'user_type': userType.index + 1
    }};
    var response = await userRemoteService.postSignUp(body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      String jwt = response.body['token'];
      return {'jwt': jwt};
    } else
      throw mapResponseException(response.statusCode);
  }

  @override
  Future<bool> postCompleteCompanyProfile (
      {Company company,String jwt}) async{
    print('start');
    print(company);
    var companyJson =  company.toJson();

    var header=jwt;
    var response = await userRemoteService.postCompleteCompanyProfile(companyJson, header);
    print(response.statusCode);
    print(response.error);
    if(response.statusCode == 200)
      return true;
    else throw ServerException();

  }

  @override
  Future<Map<String,dynamic>> postCompleteJobSeekerProfile({JobSeeker jobSeeker, String jwt,File cv,File personalPhoto}) async{

    var jobSeekerJson =  jobSeeker;
    var header=jwt;
    print('start');
    var response = await userRemoteService.postCompleteJobSeekerProfile(json.encode(jobSeekerJson),header,cv.path,personalPhoto.path);
    print(response.statusCode);
    print(response.error);
    print(response.body);
    if(response.statusCode == 200)
      return response.body;

     throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> getUser({int id}) async{

    var response = await userRemoteService.getUser(id);
    if(response.statusCode == 200)
      return response.body;

    throw ServerException();
  }

  @override
  Future<bool> postNewJob({Job job,String jwt}) async{
    var jobJson =  job.toJson();
    print('////////////////////////////////////////////////////////////////////////////////////////////////');
    print(jobJson);
    var header = jwt;
    var response = await userRemoteService.postNewJob(jobJson, header);
    if(response.statusCode == 200)
      return true;

    throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> getJobsByCompany({String jwt}) async{
    var response = await userRemoteService.getJobsByCompany(jwt);
    if(response.statusCode == 200)
      return response.body;

    throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> getRecentJobs({int page}) async{
    var response = await userRemoteService.getRecentJobs(page);
    if(response.statusCode == 200)
      return response.body;

    throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> searchJobs({int page, int cityId, int countryId}) async{
    var response = await userRemoteService.searchJobs(cityId);
    if(response.statusCode == 200)
      return response.body;

    throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> getCitiesByCountry({int countryId}) async{
    var response = await userRemoteService.getCitiesByCountry(countryId);
    if(response.statusCode == 200)
      return response.body;

    throw ServerException();
  }

  @override
  Future<Map<String, dynamic>> getCountries() async{
    var response = await userRemoteService.getCountries();
    print(response);
    if(response.statusCode == 200)
      return response.body;

    throw ServerException();
  }


}
