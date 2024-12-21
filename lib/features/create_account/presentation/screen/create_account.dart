import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_cubit.dart';
import 'package:support/features/create_account/presentation/widgets/check_box.dart';
import 'package:support/features/create_account/presentation/widgets/continue.dart';
import 'package:support/features/create_account/presentation/widgets/text_input.dart';
import 'package:support/features/create_account/presentation/widgets/top_bar.dart';
import 'package:support/features/create_account/presentation/widgets/translated_text.dart';
import 'package:support/core/utils/size_utils.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    try {
      return await loadTranslations(context);
    } catch (error) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CreateAccountCubit(),
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: FutureBuilder<Map<String, String>>(
            future: _loadTranslations(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const Center(child: Text('Error loading translations'));
              }

              final translations = snapshot.data!;
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeUtils.getHeight(context, 0.1)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeUtils.getHeight(context, 0.05)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TranslatedText(
                              translationKey: 'letsCreateAccount',
                              translations: translations,
                            ),
                            SizedBox(
                                height: SizeUtils.getHeight(context, 0.03)),
                            DescriptionWidget(
                              translations: translations,
                            ),
                            SizedBox(
                                height: SizeUtils.getHeight(context, 0.03)),
                            TextInputFieldsWidget(translations: translations),
                            SizedBox(
                                height: SizeUtils.getHeight(context, 0.03)),
                            const PrivacyPolicyCheckbox(),
                            SizedBox(
                                height: SizeUtils.getHeight(context, 0.03)),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeUtils.getHeight(context, 0.05)),
                              child: ContinueButton(
                                translations: translations,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const CustomAppBar(),
                ],
              );
            },
          ),
        ));
  }
}
