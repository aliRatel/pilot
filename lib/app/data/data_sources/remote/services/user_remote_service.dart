import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

part  'generated/user_remote_service.chopper.dart';

@ChopperApi(baseUrl: '/user')
abstract class UserRemoteService extends ChopperService {
  static UserRemoteService create() {
    final client = ChopperClient(
        baseUrl: 'http://192.168.1.101:8000',
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
}