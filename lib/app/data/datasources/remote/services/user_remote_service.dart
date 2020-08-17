import 'package:chopper/chopper.dart';

part  'generated/user_remote_service.chopper.dart';

@ChopperApi(baseUrl: '/user')
abstract class UserRemoteService extends ChopperService {
  static UserRemoteService create() {
    final client = ChopperClient(
        baseUrl: 'http://serviceUrl:8000',
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


}