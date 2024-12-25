import 'package:logger/logger.dart';

class LoggerUtils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  static Logger get logger => _logger;

  static void logInfo(String message) {
    _logger.i(message);
  }

  static void logDebug(String message) {
    _logger.d(message);
  }

  static void logError(String message, [dynamic error]) {
    if (error != null) {
      _logger.e('$message: $error');
    } else {
      _logger.e(message);
    }
  }

  static void logWarning(String message) {
    _logger.w(message);
  }
}
