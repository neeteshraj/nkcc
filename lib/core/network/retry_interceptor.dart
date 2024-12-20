import 'package:dio/dio.dart';
import 'package:support/config/logger/logger.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryInterval;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryInterval = const Duration(seconds: 2),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      var retries = err.requestOptions.extra["retries"] ?? 0;
      if (retries < maxRetries) {
        err.requestOptions.extra["retries"] = retries + 1;
        LoggerUtils.logError('Error occurred: ${err.message}');
        LoggerUtils.logInfo('Retrying request... Attempt: ${retries + 1}');
        await Future.delayed(retryInterval);

        try {
          final response = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(response);
        } catch (e) {
          LoggerUtils.logError('Retry failed: $e');
          return super.onError(err, handler);
        }
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.unknown ||
        err.type == DioExceptionType.badCertificate ||
        err.type == DioExceptionType.cancel ||
        err.type == DioExceptionType.badResponse ||
        (err.response?.statusCode == 500 || err.response?.statusCode == 502);
  }
}
