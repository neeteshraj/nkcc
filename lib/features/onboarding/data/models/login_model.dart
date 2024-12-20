import 'package:support/features/onboarding/data/models/token_info.dart';
import 'package:support/features/onboarding/data/models/user_model.dart';

class LoginResponse {
  final ResponseHeader responseHeader;
  final UserData userData;
  final TokenInfo tokenInfo;

  LoginResponse({
    required this.responseHeader,
    required this.userData,
    required this.tokenInfo,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      responseHeader: ResponseHeader.fromJson(json['responseHeader']),
      userData: UserData.fromJson(json['response']['user']),
      tokenInfo: TokenInfo.fromJson(json['response']['tokenInfo']),
    );
  }
}

class ResponseHeader {
  final int status;
  final String statusCode;
  final String requestId;
  final String timeStamp;
  final String responseTitle;
  final String responseDescription;

  ResponseHeader({
    required this.status,
    required this.statusCode,
    required this.requestId,
    required this.timeStamp,
    required this.responseTitle,
    required this.responseDescription,
  });

  factory ResponseHeader.fromJson(Map<String, dynamic> json) {
    return ResponseHeader(
      status: json['status'],
      statusCode: json['statusCode'],
      requestId: json['requestId'],
      timeStamp: json['timeStamp'],
      responseTitle: json['responseTitle'],
      responseDescription: json['responseDescription'],
    );
  }
}
