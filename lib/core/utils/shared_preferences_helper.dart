import 'package:shared_preferences/shared_preferences.dart';
import 'package:support/config/logger/logger.dart';
import 'package:support/core/constants/app_secrets.dart';
import 'package:support/features/onboarding/data/models/token_info.dart';

class SharedPreferencesHelper {
  static Future<void> saveTokenData(TokenInfo tokenData) async {
    try {
      final preferences = await SharedPreferences.getInstance();

      await preferences.setString(AppSecrets.authToken, tokenData.authToken);
      await preferences.setString(AppSecrets.refreshToken, tokenData.refreshToken);
      await preferences.setInt(AppSecrets.expiresIn, tokenData.expiresIn);
      await preferences.setInt(AppSecrets.generatedAt, tokenData.generatedAt);
      await preferences.setInt(AppSecrets.refreshExpiresIn, tokenData.refreshExpiresIn);

      LoggerUtils.logInfo("Saved token information to shared preferences");
    } catch (e) {
      LoggerUtils.logError("Error saving token data to local storage: ${e.toString()}");
    }
  }

  static Future<TokenInfo?> getTokenData() async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final authToken = preferences.getString(AppSecrets.authToken);
      final refreshToken = preferences.getString(AppSecrets.refreshToken);
      final expiresIn = preferences.getInt(AppSecrets.expiresIn);
      final generatedAt = preferences.getInt(AppSecrets.generatedAt);
      final refreshExpiresIn = preferences.getInt(AppSecrets.refreshExpiresIn);

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

      await preferences.remove(AppSecrets.authToken);
      await preferences.remove(AppSecrets.refreshToken);
      await preferences.remove(AppSecrets.expiresIn);
      await preferences.remove(AppSecrets.generatedAt);
      await preferences.remove(AppSecrets.refreshExpiresIn);

      LoggerUtils.logInfo("Token information cleared from local storage.");
    } catch (e) {
      LoggerUtils.logError("Error clearing token data from local storage: ${e.toString()}");
    }
  }
}
