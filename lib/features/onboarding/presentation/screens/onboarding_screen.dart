import 'package:flutter/material.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/features/onboarding/data/datasources/onboarding_data_source.dart';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';
import '../widgets/onboarding_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;  // Initially, the first page is active
  bool _isButtonDisabled = false;  // Prevent multiple presses

  Map<String, String> _localizedStrings = {};

  @override
  void initState() {
    super.initState();
    _loadTranslations();
  }

  Future<void> _loadTranslations() async {
    final translations = await loadTranslations(context);
    setState(() {
      _localizedStrings = translations;
    });
  }

  // Handle page changes in PageView
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  // Navigate to the next page
  void _nextPage(List<OnboardingModel> onboardingData) {
    print("Current Page: $_currentPage");
    if (_currentPage < onboardingData.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        setState(() {
          _currentPage += 1;
        });
      });
    } else {
      print("Navigating to Home Screen");
      Navigator.pushReplacementNamed(context, "/home");
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnboardingDataSource.getOnboardingData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading data: ${snapshot.error}')),
          );
        } else {
          final onboardingData = snapshot.data as List<OnboardingModel>;

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return OnboardingCard(
                        onboardingData: onboardingData[index],
                      );
                    },
                    onPageChanged: _onPageChanged,  // Listen for page changes
                  ),
                ),
                SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(onboardingData.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: SizeUtils.getMargin(context, 0, 0.01),
                      width: _currentPage == index
                          ? SizeUtils.getWidth(context, 0.03)
                          : SizeUtils.getWidth(context, 0.02),
                      height: SizeUtils.getHeight(context, 0.01),
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                SizedBox(height: SizeUtils.getHeight(context, 0.03)),
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.1),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isButtonDisabled
                          ? null
                          : () {
                        setState(() {
                          _isButtonDisabled = true;
                        });
                        // Call the method to handle page change
                        _nextPage(onboardingData);
                        // Re-enable button after animation duration
                        Future.delayed(const Duration(milliseconds: 350), () {
                          setState(() {
                            _isButtonDisabled = false;
                          });
                        });
                      },
                      child: Text(
                        _currentPage == onboardingData.length - 1
                            ? _localizedStrings['get_started'] ?? "Get Started"
                            : _localizedStrings['next'] ?? "Next",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
        }
      },
    );
  }
}
