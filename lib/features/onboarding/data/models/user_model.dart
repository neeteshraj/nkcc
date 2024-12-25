class UserData {
  final String email;
  final String username;
  final String fullName;
  final String role;
  final List<String> billNumbers;
  final String fcmToken;

  UserData({
    required this.email,
    required this.username,
    required this.fullName,
    required this.role,
    required this.billNumbers,
    required this.fcmToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      username: json['username'],
      fullName: json['fullName'],
      role: json['role'],
      billNumbers: List<String>.from(json['billNumbers']),
      fcmToken: json['fcmToken'],
    );
  }
}

