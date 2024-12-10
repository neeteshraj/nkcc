import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/features/onboarding/data/datasources/onboarding_data_source.dart';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';
import '../bloc/onboarding_cubit.dart';
import '../widgets/onboarding_card.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    return await loadTranslations(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: FutureBuilder<Map<String, String>>(
        future: _loadTranslations(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else {
            final translations = snapshot.data!;
            return FutureBuilder<List<OnboardingModel>>(
              future: OnboardingDataSource.getOnboardingData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                        child: Text('Error loading data: ${snapshot.error}')),
                  );
                } else {
                  final onboardingData = snapshot.data!;
                  final pageController = PageController();

                  return BlocConsumer<OnboardingCubit, OnboardingState>(
                    listener: (context, state) {
                      if (state is OnboardingComplete) {
                        Navigator.pushReplacementNamed(context, "/home");
                      } else if (state is OnboardingIndexChange) {
                        pageController.jumpToPage(state.index);
                      }
                    },
                    builder: (context, state) {
                      final cubit = context.read<OnboardingCubit>();

                      return Scaffold(
                        body: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: onboardingData.length,
                                itemBuilder: (context, index) {
                                  return OnboardingCard(
                                    onboardingData: onboardingData[index],
                                  );
                                },
                                onPageChanged: (page) {
                                  cubit.updateIndex(page);
                                },
                              ),
                            ),
                            SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(onboardingData.length,
                                      (index) {
                                    return AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      margin: SizeUtils.getMargin(context, 0, 0.01),
                                      width: state.index == index
                                          ? SizeUtils.getWidth(context, 0.03)
                                          : SizeUtils.getWidth(context, 0.02),
                                      height: SizeUtils.getHeight(context, 0.01),
                                      decoration: BoxDecoration(
                                        color: state.index == index
                                            ? Colors.blue
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                            Padding(
                              padding:
                              SizeUtils.getPadding(context, 0, 0.05),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    cubit.nextPage(
                                        state.index, onboardingData.length);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.buttonBackground,
                                    elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 12.0)
                                  ),
                                  child: Text(
                                    state.index == onboardingData.length - 1
                                        ? translations['get_started'] ??
                                        "Get Started"
                                        : translations['next'] ?? "Next",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}