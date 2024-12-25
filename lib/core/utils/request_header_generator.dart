import 'package:support/core/constants/app_constants.dart';
import 'package:support/core/utils/device_type_util.dart';

import 'request_id_generator.dart';

class RequestHeaderGenerator {
  static Future<Map<String, dynamic>> generate({
    required String action,
    String channel = AppConstants.CHANNEL,
    String languageCode = "en-US",
  }) async {
    final deviceType = await DeviceTypeUtil.getDeviceType();
    final deviceId = await DeviceTypeUtil.getDeviceId();
    final clientIp = await DeviceTypeUtil.getClientIp();
    final appVersion = await DeviceTypeUtil.getAppVersion();
    final deviceModel = await DeviceTypeUtil.getDeviceModel();

    return {
      "requestId": RequestIdGenerator.generate(),
      "timestamp": DateTime.now().toUtc().toIso8601String(),
      "channel": channel,
      "deviceType": deviceType,
      "deviceId": deviceId,
      "clientIp": clientIp,
      "action": action,
      "appVersion": appVersion,
      "languageCode": languageCode,
      "deviceModel": deviceModel,
    };
  }
}
