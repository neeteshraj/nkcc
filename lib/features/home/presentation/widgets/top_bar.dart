import 'package:flutter/material.dart';
import 'package:support/config/routes/routes.dart';
import 'package:support/core/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  final Map<String, String> translations;

  const TopBar({Key? key, required this.translations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

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
            const Text(
              'Nitesh Khanal',
              style: TextStyle(
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
          child: ClipOval(
            child: Image.network(
              imageUrl,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
