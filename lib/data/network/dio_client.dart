import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/data/network/interceptors/dio_interceptor.dart';

class DioClient {
  static const baseUrl = 'https://sandbox.api.lettutor.com';

  // create singleton instance
  static final instance = DioClient._();
  DioClient._() {
    _dio.interceptors.add(DioInterceptor(_dio));
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    responseType: ResponseType.json,
  ));

  //Get Method
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is List) {
          return response.data.map((e) => e as Map<String, dynamic>).toList();
        }
      }
      throw 'something went wrong';
    } catch (e) {
      log('error from dio client: $e');
      rethrow;
    }
  }

  //Post Method
  Future<Map<String, dynamic>> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      log('from dio client: $data');
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(
              followRedirects: false,
              validateStatus: (status) {
                return status != null ? status <= 500 : false;
              },
            ) ??
            Options(
              followRedirects: false,
              validateStatus: (status) {
                return status != null ? status <= 500 : false;
              },
            ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('call success !');
        return response.data;
      }
      throw response.data['message'];
    } catch (e) {
      log('error: $e');
      rethrow;
    }
  }
}
