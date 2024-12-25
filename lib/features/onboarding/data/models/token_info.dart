class TokenInfo {
  final String authToken;
  final int expiresIn;
  final String refreshToken;
  final int generatedAt;
  final int refreshExpiresIn;

  TokenInfo({
    required this.authToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.generatedAt,
    required this.refreshExpiresIn,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      authToken: json['authToken'],
      expiresIn: json['expiresIn'],
      refreshToken: json['refreshToken'],
      generatedAt: json['generatedAt'],
      refreshExpiresIn: json['refreshExpiresIn'],
    );
  }
}