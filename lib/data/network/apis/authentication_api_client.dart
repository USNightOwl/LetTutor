import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/user/authentication_response.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class AuthenticationApiClient {
  // sign in
  Future<AuthenticationResponse> signIn(String email, String password) async {
    try {
      final response = await DioClient.instance.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      log('from login api client: $response');
      AuthenticationResponse loginResponse =
          AuthenticationResponse.fromJson(response);
      return loginResponse;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error when handling response from api: $e');
      rethrow;
    }
  }

  // sign up
  Future<AuthenticationResponse> signUp(String email, String password) async {
    try {
      final response = await DioClient.instance.post(
        Endpoints.register,
        data: {'email': email, 'password': password, 'source': null},
      );
      log('from regsiter api client: $response');
      AuthenticationResponse loginResponse =
          AuthenticationResponse.fromJson(response);
      return loginResponse;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error when handling response from api: $e');
      rethrow; // quăng lỗi này ra cho cha bắt;
    }
  }

  //signInWithGoogle(String accessToken) {}
  Future<AuthenticationResponse> signInWithGoogle(String accessToken) async {
    try {
      final response = await DioClient.instance.post(
        Endpoints.loginWithGoogle,
        data: {'access_token': accessToken},
      );
      return response['access_token'];
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error when handling response from api: $e');
      rethrow;
    }
  }
}
