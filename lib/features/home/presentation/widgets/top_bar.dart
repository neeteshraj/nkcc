import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:support/config/logger/logger.dart';
import 'package:support/config/routes/routes.dart';
import 'package:support/core/database/user/user_database_service.dart';
import 'package:support/core/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  final Map<String, String> translations;
  final UserDatabaseService userDatabaseService;

  const TopBar({
    super.key,
    required this.translations,
    required this.userDatabaseService,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: userDatabaseService.getUser(1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error fetching user information"));
        }

        final user = snapshot.data;

        if (user == null) {
          return const Center(child: Text("User not found"));
        }

        final fullName = user['fullName'] ?? 'Guest';
        final firstName = fullName.split(' ').first;
        final profilePicture = user['profilePicture'];

        Uint8List? imageBytes;
        if (profilePicture != null && profilePicture.isNotEmpty) {
          try {
            imageBytes = base64Decode(profilePicture);
          } catch (e) {
            LoggerUtils.logError('Error decoding profile picture: $e');
          }
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translations['welcomeBack'] ?? 'Welcome Back',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  firstName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.home,
                  arguments: 3,
                );
              },
              child: imageBytes != null
                  ? ClipOval(
                child: Image.memory(
                  imageBytes,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              )
                  : CircleAvatar(
                radius: 22.5,
                backgroundColor: Colors.white,
                child: Text(
                  fullName.isNotEmpty
                      ? fullName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonBackground,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
