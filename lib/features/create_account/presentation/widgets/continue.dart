import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_cubit.dart';

class ContinueButton extends StatelessWidget {
  final String translationKey;
  final Map<String, String> translations;

  const ContinueButton({
    super.key,
    required this.translations,
    this.translationKey = 'complete',
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = translations[translationKey] ?? 'Complete';

    return Padding(
      padding: SizeUtils.getPadding(context, 0, 0.05),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final state = context.read<CreateAccountCubit>().state;
            print('Current email: ${state.email}, isValid: ${state.isEmailValid}');
            if (state.isEmailValid) {
              print("Form submitted successfully!");
            } else {
              print("Invalid email address!");
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            backgroundColor: AppColors.buttonBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
