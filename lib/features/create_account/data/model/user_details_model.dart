class ResponseHeader {
  final String status;
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
      status: json['status'].toString(),
      statusCode: json['statusCode'],
      responseTitle: json['responseTitle'],
      responseDescription: json['responseDescription'],
    );
  }
}

class User {
  final String? email; // Made nullable
  final String? username; // Made nullable
  final String? fullName; // Made nullable
  final String? role; // Made nullable
  final List<String>? billNumbers; // Made nullable
  final String? fcmToken; // Made nullable
  final String? profilePicture; // Made nullable

  User({
    this.email,
    this.username,
    this.fullName,
    this.role,
    this.billNumbers,
    this.fcmToken,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email ?? '',
      'username': username ?? '',
      'fullName': fullName ?? '',
      'role': role ?? '',
      'billNumbers': billNumbers?.join(',') ?? '',
      'fcmToken': fcmToken ?? '',
      'profilePicture': profilePicture ?? '',
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String?, // Safely cast to nullable String
      username: json['username'] as String?,
      fullName: json['fullName'] as String?,
      role: json['role'] as String?,
      billNumbers: json['billNumbers'] != null
          ? List<String>.from(json['billNumbers'] as List<dynamic>)
          : null, // Handle null list
      fcmToken: json['fcmToken'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );
  }
}


class UserDetailsResponse {
  final ResponseHeader responseHeader;
  final User? user;

  UserDetailsResponse({required this.responseHeader, this.user});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      responseHeader: ResponseHeader.fromJson(json['responseHeader']),
      user: json['response'] != null
          ? User.fromJson(json['response']['user'])
          : null,
    );
  }
}
