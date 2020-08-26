// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_remote_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$UserRemoteService extends UserRemoteService {
  _$UserRemoteService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserRemoteService;

  @override
  Future<Response<dynamic>> postSignUp(Map<String, dynamic> body) {
    final $url = '//register';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postLogin(Map<String, dynamic> body) {
    final $url = '//login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCompleteCompanyProfile(
      Map<String, dynamic> body, String token) {
    final $url = '//complete-company-profile';
    final $headers = {'bearer': token};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCompleteJobSeekerProfile(
      Map<String, dynamic> body,
      String token,
      String imagePath,
      String cvPath) {
    final $url = '//complete-jobseeker-profile';
    final $headers = {'bearer': token};
    final $body = body;
    final $parts = <PartValue>[
      PartValueFile<String>('image', imagePath),
      PartValueFile<String>('cv', cvPath)
    ];
    final $request = Request('POST', $url, client.baseUrl,
        body: $body, parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUser(int id) {
    final $url = '//user/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postNewJob(
      Map<String, dynamic> body, String token) {
    final $url = '//new-job';
    final $headers = {'bearer': token};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getJobsByCompany(String token, int page) {
    final $url = '/jobs/api/job/company/$page';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRecentJobs(int page) {
    final $url = '/jobs/api/Job/allJobs/';
    final $params = <String, dynamic>{'int': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> searchJobs(int page, int cityId, int countryId) {
    final $url = '//search-jobs';
    final $params = <String, dynamic>{
      'int': page,
      'int': cityId,
      'int': countryId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCitiesByCountry(int countryId) {
    final $url = '/accounts/api/CitiesOfCountry/$countryId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCountries() {
    final $url = '/accounts/api/Country/All/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
