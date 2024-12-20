import 'package:shared_preferences/shared_preferences.dart';
import 'package:support/config/logger/logger.dart';
import 'package:support/features/onboarding/data/models/token_info.dart';

class SharedPreferencesHelper {
  static Future<void> saveTokenData(TokenInfo tokenData) async {
    try {
      final preferences = await SharedPreferences.getInstance();

      await preferences.setString('authToken', tokenData.authToken);
      await preferences.setString('refreshToken', tokenData.refreshToken);
      await preferences.setInt('expiresIn', tokenData.expiresIn);
      await preferences.setInt('generatedAt', tokenData.generatedAt);
      await preferences.setInt('refreshExpiresIn', tokenData.refreshExpiresIn);

      LoggerUtils.logInfo("Saved token information to shared preferences");
    } catch (e) {
      LoggerUtils.logError("Error saving token data to local storage: ${e.toString()}");
    }
  }

  static Future<TokenInfo?> getTokenData() async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final authToken = preferences.getString('authToken');
      final refreshToken = preferences.getString('refreshToken');
      final expiresIn = preferences.getInt('expiresIn');
      final generatedAt = preferences.getInt('generatedAt');
      final refreshExpiresIn = preferences.getInt('refreshExpiresIn');

      if (authToken != null &&
          refreshToken != null &&
          expiresIn != null &&
          generatedAt != null &&
          refreshExpiresIn != null) {
        return TokenInfo(
          authToken: authToken,
          refreshToken: refreshToken,
          expiresIn: expiresIn,
          generatedAt: generatedAt,
          refreshExpiresIn: refreshExpiresIn,
        );
      }
      return null;
    } catch (e) {
      LoggerUtils.logError("Error retrieving token data from local storage: ${e.toString()}");
      return null;
    }
  }

  static Future<void> clearTokenData() async {
    try {
      final preferences = await SharedPreferences.getInstance();

      await preferences.remove('authToken');
      await preferences.remove('refreshToken');
      await preferences.remove('expiresIn');
      await preferences.remove('generatedAt');
      await preferences.remove('refreshExpiresIn');

      LoggerUtils.logInfo("Token information cleared from local storage.");
    } catch (e) {
      LoggerUtils.logError("Error clearing token data from local storage: ${e.toString()}");
    }
  }
}
