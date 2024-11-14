import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/data/models/user/authentication_response.dart';
import 'package:let_tutor/data/network/apis/authentication_api_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class AuthenticationRepository {
  final AuthenticationApiClient _authenticationApiClient;

  AuthenticationRepository({AuthenticationApiClient? authenticationApiClient})
      : _authenticationApiClient =
            authenticationApiClient ?? AuthenticationApiClient();

  Future<AuthenticationResponse> signUp(String email, String password) async {
    log('from repo : $email, password: $password');
    try {
      final response = await _authenticationApiClient.signUp(email, password);
      return response;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error handling from repo: $e');
      rethrow;
    }
  }
}
