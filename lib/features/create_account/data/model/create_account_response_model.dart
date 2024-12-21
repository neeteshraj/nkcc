class CreateAccountResponse {
  final ResponseHeader responseHeader;
  final User? user;
  final TokenInfo? tokenInfo;
  final String? errorDescription;

  CreateAccountResponse({
    required this.responseHeader,
    this.user,
    this.tokenInfo,
    this.errorDescription,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) {
    return CreateAccountResponse(
      responseHeader: ResponseHeader.fromJson(json['responseHeader']),
      user: json['response'] != null ? User.fromJson(json['response']['user']) : null,
      tokenInfo: json['response'] != null ? TokenInfo.fromJson(json['response']['tokenInfo']) : null,
      errorDescription: json['responseHeader']['responseDescription'],
    );
  }
}

class ResponseHeader {
  final int status;
  final String statusCode;
  final String responseTitle;
  final String responseDescription;

  ResponseHeader({
    required this.status,
    required this.statusCode,
    required this.responseTitle,
    required this.responseDescription,
  });

  factory ResponseHeader.fromJson(Map<String, dynamic> json) {
    return ResponseHeader(
      status: json['status'],
      statusCode: json['statusCode'],
      responseTitle: json['responseTitle'],
      responseDescription: json['responseDescription'],
    );
  }
}

class User {
  final String email;
  final String username;
  final String fullName;
  final String role;
  final List<String> billNumbers;
  final String fcmToken;

  User({
    required this.email,
    required this.username,
    required this.fullName,
    required this.role,
    required this.billNumbers,
    required this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      username: json['username'],
      fullName: json['fullName'],
      role: json['role'],
      billNumbers: List<String>.from(json['billNumbers']),
      fcmToken: json['fcmToken'],
    );
  }
}

class TokenInfo {
  final String authToken;
  final String refreshToken;
  final int expiresIn;

  TokenInfo({
    required this.authToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      authToken: json['authToken'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
    );
  }
}
