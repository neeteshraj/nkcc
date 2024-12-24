import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/logger/logger.dart';
import 'package:support/config/routes/routes.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/features/home/presentation/bloc/user_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_state.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserCubit>().state;
    if (userState is UserInitial || userState is UserError) {
      context.read<UserCubit>().fetchUser(1);
    }
    return BlocBuilder<TranslationsCubit, TranslationsState>(
      builder: (context, translationsState) {
        final translations = translationsState.translations;

        return BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {

            if (state is UserError) {
              return const Center(child: Text("Error fetching user information"));
            }

            if (state is UserLoaded) {
              final user = state.user;

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
            }

            return const Center(child: Text("User not found"));
          },
        );
      },
    );
  }
}
