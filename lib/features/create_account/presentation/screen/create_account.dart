import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_cubit.dart';
import 'package:support/features/create_account/presentation/widgets/check_box.dart';
import 'package:support/features/create_account/presentation/widgets/continue.dart';
import 'package:support/features/create_account/presentation/widgets/text_input.dart';
import 'package:support/features/create_account/presentation/widgets/top_bar.dart';
import 'package:support/features/create_account/presentation/widgets/translated_text.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/startup/presentation/bloc/translations_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_state.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final billNumbers = (arguments?["billNumber"] as String?)?.split(',') ?? [];

    print('billNumbers: $billNumbers');

    GlobalKey<FormState> inputFormKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (_) => CreateAccountCubit(apiService: apiService, billNumbers: billNumbers),
      child: BlocProvider(
        create: (_) => TranslationsCubit()..loadTranslationsFromCubit(context),
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: BlocBuilder<TranslationsCubit, TranslationsState>(
            builder: (context, state) {
              final translations = state.translations;

              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: SizeUtils.getHeight(context, 0.1)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: SizeUtils.getHeight(context, 0.05)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TranslatedText(
                              translationKey: 'letsCreateAccount',
                              translations: translations,
                            ),
                            SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                            DescriptionWidget(translations: translations),
                            SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                            TextInputFieldsWidget(
                              translations: translations,
                              formKey: inputFormKey,
                            ),
                            SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                            const PrivacyPolicyCheckbox(),
                            SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                            Padding(
                              padding: EdgeInsets.only(top: SizeUtils.getHeight(context, 0.05)),
                              child: ContinueButton(
                                translations: translations,
                                inputFormKey: inputFormKey,
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
        ),
      ),
    );
  }
}
