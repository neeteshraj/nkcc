import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/constants/videos_path.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/onboarding/presentation/bloc/bill/product_code_cubit.dart';
import 'package:support/features/onboarding/presentation/bloc/bill/product_code_state.dart';
import 'package:support/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:support/features/onboarding/presentation/widgets/onboarding_card.dart';
import 'package:support/features/startup/presentation/bloc/translations_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_state.dart';
import 'package:video_player/video_player.dart';
import 'package:support/features/onboarding/data/datasources/onboarding_data_source.dart';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with WidgetsBindingObserver {
  VideoPlayerController? _videoController;
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<String?> _errorTextNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final locale = Localizations.localeOf(context);
    context.read<TranslationsCubit>().loadTranslationsFromCubit(locale);
  }

  @override
  void dispose() {
    _controller.dispose();
    _errorTextNotifier.dispose();
    _videoController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_videoController != null && !_videoController!.value.isPlaying) {
        _videoController!.play();
      }
    }
  }

  void _initializeVideoController() {
    _videoController ??= VideoPlayerController.asset(VideoPaths.splashScreen)
        ..initialize().then((_) {
          setState(() {});
          _videoController!.setLooping(true);
          _videoController!.play();
        });
  }

  @override
  Widget build(BuildContext context) {
    _initializeVideoController();

    final locale = Localizations.localeOf(context).languageCode;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => ProductCodeCubit(ApiService())),
        BlocProvider(create: (_) => TranslationsCubit())
      ],
      child: BlocBuilder<TranslationsCubit, TranslationsState>(
        builder: (context, translationState) {
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
                      resizeToAvoidBottomInset: true,
                      body: Stack(
                        children: [
                          if (_videoController != null && _videoController!.value.isInitialized)
                            SizedBox.expand(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: _videoController!.value.size.width,
                                  height: _videoController!.value.size.height,
                                  child: VideoPlayer(_videoController!),
                                ),
                              ),
                            ),
                          Container(
                            color: Colors.black.withValues(alpha: 0.7),
                          ),
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
                                            translationState.translations['scan_to_add_product'] ?? "Scan to Add Product",
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
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
                                              return BlocConsumer<ProductCodeCubit, ProductCodeState>(
                                                listener: (context, state) {
                                                  if (state is ProductCodeSuccess) {
                                                    _controller.clear();
                                                    Navigator.of(context, rootNavigator: true).pop();
                                                    Navigator.pushReplacementNamed(context, "/home");
                                                  } else if (state is ProductCodeError) {
                                                    if (state.errorMessage.contains("does not exist in the system")) {
                                                      _errorTextNotifier.value = state.errorMessage;
                                                    } else if (state.errorMessage.contains("No user is associated with the bill number")) {
                                                      Navigator.of(context, rootNavigator: true).pop();
                                                      Navigator.pushNamed(context, "/createaccount",arguments: {"billNumber": _controller.text});
                                                      _controller.clear();
                                                    } else {
                                                      _errorTextNotifier.value = "An unexpected error occurred.";
                                                    }
                                                  }
                                                },
                                                builder: (context, state) {
                                                  final isLoading = state is ProductCodeLoading;

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
                                                                translationState.translations['enter_product_code'] ?? "Enter Product Code",
                                                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: SizeUtils.getHeight(context, 0.02)),
                                                            ValueListenableBuilder<String?>(
                                                              valueListenable: _errorTextNotifier,
                                                              builder: (context, errorText, child) {
                                                                return TextField(
                                                                  controller: _controller,
                                                                  onChanged: (value) {
                                                                    _errorTextNotifier.value =
                                                                    value.length < 8 ? "Code must be at least 8 digits" : null;
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    hintText: "8 digit code on bill",
                                                                    hintStyle: const TextStyle(
                                                                        color: Colors.white54,
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.normal,
                                                                        letterSpacing: 1),
                                                                    filled: true,
                                                                    fillColor: AppColors.backgroundColor,
                                                                    errorText: errorText,
                                                                    errorStyle: const TextStyle(
                                                                        fontSize: 12
                                                                    ),
                                                                    border: InputBorder.none,
                                                                    focusedBorder: const UnderlineInputBorder(
                                                                      borderSide: BorderSide(color: Colors.white),
                                                                    ),
                                                                    enabledBorder: const UnderlineInputBorder(
                                                                      borderSide: BorderSide(color: Colors.white54),
                                                                    ),
                                                                    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                                                                    counterText: "",
                                                                  ),
                                                                  style: const TextStyle(
                                                                    color: Colors.white,
                                                                    letterSpacing: 1.5,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                  cursorColor: Colors.white,
                                                                  keyboardType: TextInputType.number,
                                                                  maxLength: 8,
                                                                );
                                                              },
                                                            ),
                                                            SizedBox(height: SizeUtils.getHeight(context, 0.02)),
                                                            SizedBox(
                                                              width: double.infinity,
                                                              child: ElevatedButton(
                                                                onPressed: () {
                                                                  if (_controller.text.length < 8) {
                                                                    _errorTextNotifier.value = "Code must be at least 8 digits";
                                                                  } else {
                                                                    _errorTextNotifier.value = null;
                                                                    context.read<ProductCodeCubit>().submitCode(_controller.text);
                                                                  }
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: AppColors.buttonBackground,
                                                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                                ),
                                                                child: isLoading
                                                                    ? const SizedBox(
                                                                  height: 24,
                                                                  width: 24,
                                                                  child: CircularProgressIndicator(
                                                                    color: Colors.black,
                                                                    strokeWidth: 2,
                                                                  ),
                                                                )
                                                                    : Text(
                                                                  translationState.translations["continue"] ?? "Continue",
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
                                          );
                                        },
                                        child: Text(
                                          translationState.translations['enter_code_to_add_product'] ?? "Enter code to Add product",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: SizeUtils.getHeight(context, 0.015)),
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
        },
      ),
    );
  }
}


