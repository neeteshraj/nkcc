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
    final shouldRetry = _shouldRetry(err);
    final retries = (err.requestOptions.extra["retries"] as int?) ?? 0;

    if (shouldRetry && retries < maxRetries) {
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

        err.requestOptions.extra["retries"] = 0;
        return handler.resolve(response);
      } catch (retryError) {
        LoggerUtils.logError('Retry failed: $retryError');
        return handler.next(err);
      }
    }

    if (!shouldRetry) {
      LoggerUtils.logError('Retry not allowed for error: ${err.message}');
    } else {
      LoggerUtils.logError('Max retries exceeded for ${err.requestOptions.path}');
    }

    if (err.response != null) {
      handler.resolve(err.response!);
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    if (err.response != null) {
      final responseBody = err.response?.data;
      final statusCode = err.response?.statusCode;

      if (statusCode == 500 && responseBody != null) {
        return false;
      }
    }

    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.unknown ||
        (err.response?.statusCode == 500 || err.response?.statusCode == 502 || err.response?.statusCode == 503);
  }
}
