import 'package:flutter/material.dart';
import 'package:support/core/database/user/user_database_service.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/features/home/presentation/widgets/top_bar.dart';
import 'package:support/core/database/database_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    try {
      return await loadTranslations(context);
    } catch (error) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseHelper = DatabaseHelper();
    final userDatabaseService = UserDatabaseService(databaseHelper: databaseHelper);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeUtils.getHeight(context, 0.06)),
        child: FutureBuilder<Map<String, String>>(
          future: _loadTranslations(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SafeArea(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SafeArea(child: Text('Error loading translations')),
              );
            }

            final translations = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SafeArea(
                child: TopBar(
                  translations: translations,
                  userDatabaseService: userDatabaseService,
                ),
              ),
            );
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "Hello, Home Screen!",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
