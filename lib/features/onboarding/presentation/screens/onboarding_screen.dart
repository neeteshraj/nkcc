import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/constants/videos_path.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:support/features/onboarding/data/datasources/onboarding_data_source.dart';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';
import '../bloc/onboarding_cubit.dart';
import '../widgets/onboarding_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(VideoPaths.splashScreen)
      ..initialize().then((_) {
        setState(() {}); // Update the UI once the video is loaded
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

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
                        body: Stack(
                          children: [
                            // Video Background
                            if (_videoController.value.isInitialized)
                              SizedBox.expand(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: _videoController.value.size.width,
                                    height: _videoController.value.size.height,
                                    child: VideoPlayer(_videoController),
                                  ),
                                ),
                              ),
                            // Semi-transparent Overlay
                            Container(
                              color: Colors.black.withOpacity(0.6),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // PageView for Onboarding Cards
                                  SizedBox(
                                    height: SizeUtils.getHeight(context, 0.42),
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
                                  // Action Button
                                  Padding(
                                    padding: SizeUtils.getPadding(context, 0, 0.03),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // cubit.nextPage(state.index, onboardingData.length);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.buttonBackground,
                                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                                            ),
                                            child: Text(
                                              state.index == onboardingData.length - 1
                                                  ? translations['scan_to_add_product'] ?? "Scan to Add Product"
                                                  : translations['next'] ?? "Next",
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: SizeUtils.getHeight(context, 0.01)),
                                        TextButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: AppColors.backgroundColor,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                                              ),
                                              builder: (context) {
                                                return Padding(
                                                  padding: SizeUtils.getPadding(context, 0.03, 0.03),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            // Action when button is pressed
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: AppColors.buttonBackground,
                                                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                          ),
                                                          child: Text(
                                                            translations["continue"] ?? "Continue",
                                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 18
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: SizeUtils.getHeight(context, 0.01))
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            translations['enter_code_to_add_product'] ?? "Enter code to Add product",
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: SizeUtils.getHeight(context, 0.015))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
