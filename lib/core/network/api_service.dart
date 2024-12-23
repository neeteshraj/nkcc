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

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      print('Error fetching data: ${e.message}');
      throw Exception('Error: ${e.message}');
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      print('Error posting data: ${e.message}');
      throw Exception('Error: ${e.message}');
    }
  }
}
