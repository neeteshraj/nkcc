import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/constants/videos_path.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:support/features/onboarding/presentation/widgets/onboarding_card.dart';
import 'package:video_player/video_player.dart';
import 'package:support/features/onboarding/data/datasources/onboarding_data_source.dart';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with WidgetsBindingObserver {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(VideoPaths.splashScreen)
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.play();
      });

    // Add observer to handle app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _videoController.dispose();
    // Remove the observer when the screen is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle states to keep the video playing
    if (state == AppLifecycleState.resumed) {
      if (!_videoController.value.isPlaying) {
        _videoController.play();
      }
    } else if (state == AppLifecycleState.paused) {
      // You can handle the paused state if needed
    }
  }

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    return await loadTranslations(context);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

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
              future: OnboardingDataSource.getOnboardingData(locale),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error loading data: ${snapshot.error}'),
                    ),
                  );
                } else {
                  final onboardingData = snapshot.data!;
                  final pageController = PageController();

                  return BlocConsumer<OnboardingCubit, OnboardingState>(
                    listener: (context, state) {
                      if (state is OnboardingComplete) {
                        Navigator.pushNamed(context, "/qrcode");
                      } else if (state is OnboardingIndexChange) {
                        Navigator.pushNamed(context, "/qrcode");
                        pageController.jumpToPage(state.index);
                      }
                    },
                    builder: (context, state) {
                      final cubit = context.read<OnboardingCubit>();

                      return Scaffold(
                        resizeToAvoidBottomInset: true, // Ensures that the body resizes when the keyboard appears
                        body: Stack(
                          children: [
                            // Background video and overlay
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
                            Container(
                              color: Colors.black.withOpacity(0.6),
                            ),
                            // Bottom sheet and other content
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: SizeUtils.getHeight(context, 0.44),
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
                                  Padding(
                                    padding: SizeUtils.getPadding(context, 0, 0.03),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              cubit.nextPage(state.index, onboardingData.length);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.buttonBackground,
                                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                                            ),
                                            child: Text(
                                              translations['scan_to_add_product'] ?? "Scan to Add Product",
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
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
                                                  padding: MediaQuery.of(context).viewInsets,
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    padding: const EdgeInsets.all(30.0),
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(
                                                              translations['enter_product_code'] ?? "Enter Product Code",
                                                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: SizeUtils.getHeight(context, 0.02)),
                                                          const TextField(
                                                            decoration: InputDecoration(
                                                              hintText: "6 digit code on bill",
                                                              hintStyle: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 1),
                                                              filled: true,
                                                              fillColor: AppColors.backgroundColor,
                                                              border: InputBorder.none,
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.white),
                                                              ),
                                                              enabledBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.white54),
                                                              ),
                                                              contentPadding: EdgeInsets.symmetric(vertical: 18.0),
                                                            ),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                letterSpacing: 1.5,
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w600
                                                            ),
                                                            cursorColor: Colors.white,
                                                          ),
                                                          SizedBox(height: SizeUtils.getHeight(context, 0.02)),
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
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: SizeUtils.getHeight(context, 0.01)),
                                                        ],
                                                      ),
                                                    ),
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