import 'package:support/config/logger/logger.dart';
import 'package:support/core/utils/shared_preferences_helper.dart';

class RouteManager {
  static Future<String> getInitialRoute() async {
    try {
      final tokenData = await SharedPreferencesHelper.getTokenData();

      if (tokenData != null && tokenData.authToken.isNotEmpty) {
        return '/home';
      } else {
        return '/onboarding';
      }
    } catch (e) {
      LoggerUtils.logError("Error in RouteManager.getInitialRoute: ${e.toString()}");
      return '/onboarding';
    }
  }
}
