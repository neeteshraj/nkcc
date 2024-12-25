import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/logger/logger.dart';
import 'package:support/config/routes/route_manager.dart';
import 'package:support/core/constants/images_paths.dart';
import 'package:support/features/startup/presentation/bloc/translations_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_state.dart';
import 'package:support/features/startup/presentation/bloc/user/user_cubit.dart';
import 'package:support/features/startup/presentation/bloc/user/user_state.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  bool _hasFetchedData = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetchedData) {
      _hasFetchedData = true;
      _fetchInitialData();
    }
  }

  Future<void> _fetchInitialData() async {
    final locale = Localizations.localeOf(context);
    context.read<StartUpUserCubit>().fetchUser(1);
    context.read<TranslationsCubit>().loadTranslationsFromCubit(locale);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToNextScreen() async {
    String initialRoute = await RouteManager.getInitialRoute();
    if (mounted) {
      Navigator.pushReplacementNamed(context, initialRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth * 0.3;

    return BlocBuilder<StartUpUserCubit, StartUpUserState>(
      builder: (context, userState) {
        return BlocBuilder<TranslationsCubit, TranslationsState>(
          builder: (context, translationsState) {
            if (userState is StartUpUserLoaded &&
                !translationsState.isLoading &&
                !translationsState.hasError &&
                translationsState.translations.isNotEmpty) {
              _navigateToNextScreen();
            }

            if (userState is StartUpUserError && userState.errorMessage == 'Auth token not found') {
              // Token is not found, navigate to login screen or show setup screen
              Future.delayed(Duration.zero, () {
                Navigator.pushReplacementNamed(context, '/onboarding'); // Navigate to login or setup screen
              });
            }

            if (translationsState.hasError) {
              LoggerUtils.logError("Error loading translations");
            }

            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagesPaths.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _logoAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoAnimation.value,
                        child: Image.asset(
                          ImagesPaths.logo,
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

