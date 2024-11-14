import 'dart:developer';

import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/user/authentication_response.dart';
import 'package:let_tutor/data/network/dio_client.dart';

class AuthenticationApiClient {
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
    } catch (e) {
      log('error when handling response from api: $e');
      rethrow; // quăng lỗi này ra cho cha bắt;
    }
  }
}
