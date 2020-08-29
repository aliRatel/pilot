import 'package:chopper/chopper.dart';
import 'package:pilot/app/domain/entities/country.dart';
import 'package:http/http.dart' as http;
import 'package:pilot/app/domain/entities/city.dart';

part  'user_remote_service.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class UserRemoteService extends ChopperService {
  static UserRemoteService create() {
    final client = ChopperClient(
        baseUrl: 'http://192.168.43.5:8000',
        services: [
          _$UserRemoteService(),
        ],
        converter: JsonConverter());
    return _$UserRemoteService(client);
  }


  @Post(path: 'accounts/api/user/register/')
  Future<Response> postSignUp(@Body() Map<String, dynamic> body);

  @Post(path: 'accounts/api/user/login/')
  Future<Response> postLogin(@Body() Map<String, dynamic> body);

  @Post(path:'accounts/api/user/register/CompanyProfile/')
  Future<Response> postCompleteCompanyProfile(@Body() Map<String,dynamic> body,@Header('Authorization') String token);

  @Post(path:'accounts/api/user/register/JobSeekerProfile/')
  @multipart
  Future<Response> postCompleteJobSeekerProfile(@Part('data') String body,@Header('Authorization') String token,@PartFile('personal_photo') String imagePath,@PartFile('CV') String cvPath);

  @Get(path: '/user/{id}')
  Future<Response> getUser(@Path() int id);

  @Post(path:'jobs/api/job/add/')
  Future<Response> postNewJob(@Body() Map<String,dynamic> body,@Header('Authorization') String token);

  @Get(path: 'jobs/api/job/company/')
  Future<Response> getJobsByCompany(@Header('Authorization') String token);

  @Get(path: 'jobs/api/job/allJobs/')
  Future<Response> getRecentJobs( @Query('int') int page, );

  @Get(path: '/search-jobs')
  Future<Response> searchJobs( @Query('int') int page, @Query('int') int cityId,@Query('int') int countryId,);

  @Get(path: 'accounts/api/CitiesOfCountry/{id}/')
  Future<Response> getCitiesByCountry( @Path('id')  int countryId,);

  @Get(path: 'accounts/api/Country/All/')
  Future<Response> getCountries();
}