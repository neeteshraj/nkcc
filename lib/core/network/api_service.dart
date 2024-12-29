import 'package:dio/dio.dart';
import 'package:support/core/constants/app_constants.dart';
import 'retry_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
    baseUrl: AppConstants.BASE_URL,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  )) {
    _dio.interceptors.add(RetryInterceptor(dio: _dio));
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final errorData = e.response?.data;
        throw ApiException.fromJson(errorData);
      } else {
        throw Exception('Error: ${e.message}');
      }
    }
  }
}

class ApiException implements Exception {
  final int status;
  final String statusCode;
  final String requestId;
  final String responseTitle;
  final String responseDescription;

  ApiException({
    required this.status,
    required this.statusCode,
    required this.requestId,
    required this.responseTitle,
    required this.responseDescription,
  });

  factory ApiException.fromJson(Map<String, dynamic> json) {
    final responseHeader = json['responseHeader'];
    return ApiException(
      status: responseHeader['status'],
      statusCode: responseHeader['statusCode'],
      requestId: responseHeader['requestId'],
      responseTitle: responseHeader['responseTitle'],
      responseDescription: responseHeader['responseDescription'],
    );
  }

  @override
  String toString() {
    return 'ApiException: $responseTitle ($statusCode) - $responseDescription';
  }
}
