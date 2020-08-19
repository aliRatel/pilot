// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_remote_service.dart';

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
    final $url = '/user/register';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postLogin(Map<String, dynamic> body) {
    final $url = '/user/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
