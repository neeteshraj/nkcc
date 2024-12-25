import 'package:support/features/onboarding/data/models/token_info.dart';
import 'package:support/features/onboarding/data/models/user_model.dart';
import '../../../onboarding/data/models/login_model.dart';

class CreateAccountResponse {
  final ResponseHeader responseHeader;
  final ResponseData? response;
  final String? errorDescription;

  CreateAccountResponse({
    required this.responseHeader,
    this.response,
    this.errorDescription,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) {
    return CreateAccountResponse(
      responseHeader: ResponseHeader.fromJson(json['responseHeader']),
      response: json['response'] != null ? ResponseData.fromJson(json['response']) : null,
      errorDescription: json['responseHeader']['responseDescription'],
    );
  }
}

class ResponseData {
  final UserData user;
  final TokenInfo tokenInfo; 

  ResponseData({
    required this.user,
    required this.tokenInfo,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      user: UserData.fromJson(json['user']),
      tokenInfo: TokenInfo.fromJson(json['tokenInfo']),
    );
  }
}
