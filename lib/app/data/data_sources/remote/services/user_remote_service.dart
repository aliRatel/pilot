import 'package:chopper/chopper.dart';
import 'package:pilot/app/domain/entities/country.dart';
import 'package:http/http.dart' as http;
import 'package:pilot/app/domain/entities/city.dart';

part  'user_remote_service.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class UserRemoteService extends ChopperService {
  static UserRemoteService create() {
    final client = ChopperClient(
        baseUrl: 'http://aliaskar1333.pythonanywhere.com',
        services: [
          _$UserRemoteService(),
        ],
        converter: JsonConverter());
    return _$UserRemoteService(client);
  }


  @Post(path: '/register')
  Future<Response> postSignUp(@Body() Map<String, dynamic> body);

  @Post(path: '/login')
  Future<Response> postLogin(@Body() Map<String, dynamic> body);

  @Post(path:'/complete-company-profile')
  Future<Response> postCompleteCompanyProfile(@Body() Map<String,dynamic> body,@Header('bearer') String token);

  @Post(path:'/complete-jobseeker-profile')
  @multipart
  Future<Response> postCompleteJobSeekerProfile(@Body() Map<String,dynamic> body,@Header('bearer') String token,@PartFile('image') String imagePath,@PartFile('cv') String cvPath);

  @Get(path: '/user/{id}')
  Future<Response> getUser(@Path() int id);

  @Post(path:'/new-job')
  Future<Response> postNewJob(@Body() Map<String,dynamic> body,@Header('bearer') String token);

  @Get(path: 'jobs/api/job/company/{id}')
  Future<Response> getJobsByCompany(@Header('Authorization') String token,
      @Path('id') int page);

  @Get(path: 'jobs/api/Job/allJobs/')
  Future<Response> getRecentJobs( @Query('int') int page, );

  @Get(path: '/search-jobs')
  Future<Response> searchJobs( @Query('int') int page, @Query('int') int cityId,@Query('int') int countryId,);

  @Get(path: '/get-cities-by-country')
  Future<Response<List<City>>> getCitiesByCountry( @Query('int') int countryId,);

  @Get(path: '/get-countries')
  Future<Response<List<Country>>> getCountries();
}