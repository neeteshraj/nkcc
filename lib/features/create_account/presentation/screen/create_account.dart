import 'package:flutter/material.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/features/create_account/presentation/widgets/check_box.dart';
import 'package:support/features/create_account/presentation/widgets/continue.dart';
import 'package:support/features/create_account/presentation/widgets/text_input.dart';
import 'package:support/features/create_account/presentation/widgets/top_bar.dart';
import 'package:support/features/create_account/presentation/widgets/translated_text.dart';
import 'package:support/core/utils/size_utils.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TranslatedText(translationKey: 'letsCreateAccount'),
                SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                const DescriptionWidget(),
                SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                const TextInputFieldsWidget(),
                SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                const PrivacyPolicyCheckbox(),
                SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                Padding(
                  padding: EdgeInsets.only(top: SizeUtils.getHeight(context, 0.1)),
                  child: ContinueButton(
                    onPressed: () {
                      print("Continue button pressed!");
                    },
                  ),
                ),
              ],
            ),
          ),
          const CustomAppBar(),
        ],
      ),
    );
  }
}
