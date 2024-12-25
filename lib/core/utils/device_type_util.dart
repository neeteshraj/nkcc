import 'dart:io';
import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceTypeUtil {
  static Future<String> getDeviceType() async {
    if (Platform.isAndroid) {
      return "ANDROID";
    } else if (Platform.isIOS) {
      return "IOS";
    } else if (Platform.isWindows) {
      return "WINDOWS";
    } else if (Platform.isLinux) {
      return "LINUX";
    } else if (Platform.isMacOS) {
      return "MACOS";
    } else {
      return "UNKNOWN";
    }
  }

  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "UNKNOWN_IOS_ID";
    } else {
      return "UNKNOWN_DEVICE_ID";
    }
  }

  static Future<String> getDeviceModel() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else {
      return "UNKNOWN_DEVICE_MODEL";
    }
  }

  static Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getClientIp() async {
    try {
      final dio = Dio();
      final response = await dio.get('https://api64.ipify.org?format=json');
      if (response.statusCode == 200) {
        final ip = response.data['ip'];
        return ip ?? "UNKNOWN_IP";
      } else {
        return "UNKNOWN_IP";
      }
    } catch (e) {
      return "UNKNOWN_IP";
    }
  }
}
