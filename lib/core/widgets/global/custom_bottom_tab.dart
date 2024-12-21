import 'package:flutter/material.dart';
import 'package:support/core/constants/images_paths.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/home/presentation/screen/home_screen.dart';
import 'package:support/features/products/presentation/screens/products_screen.dart';
import 'package:support/features/profile/presentation/screens/profile_screen.dart';
import 'package:support/features/services/presentation/screens/services_screen.dart';
import 'dart:io';

class CustomBottomTab extends StatefulWidget {
  const CustomBottomTab({super.key});

  @override
  _CustomBottomTabState createState() => _CustomBottomTabState();
}

class _CustomBottomTabState extends State<CustomBottomTab> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ServicesScreen(),
    const ProductsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    double bottomNavHeight = Platform.isIOS
        ? SizeUtils.getHeight(context, 0.15) - bottomPadding
        : SizeUtils.getHeight(context, 0.1) - bottomPadding;

    const double imageSize = 24.0;
    const double labelFontSize = 12.0;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: bottomNavHeight,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border(
            top: BorderSide(
              color: AppColors.textSecondary,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: Platform.isIOS ? 16.0 : 0.0,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        _selectedIndex == 0
                            ? ImagesPaths.homeActive
                            : ImagesPaths.home,
                        width: imageSize,
                        height: imageSize,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                  label: 'Home',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        _selectedIndex == 1
                            ? ImagesPaths.serviceActive
                            : ImagesPaths.service,
                        width: imageSize,
                        height: imageSize,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                  label: 'Services',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        _selectedIndex == 2
                            ? ImagesPaths.productsActive
                            : ImagesPaths.products,
                        width: imageSize,
                        height: imageSize,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                  label: 'Products',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        _selectedIndex == 3
                            ? ImagesPaths.profileActive
                            : ImagesPaths.profile,
                        width: imageSize,
                        height: imageSize,
                      ),
                      const SizedBox(height: 4), 
                    ],
                  ),
                  label: 'Profile',
                  tooltip: '',
                ),
              ],
              selectedItemColor: AppColors.buttonBackground,
              selectedLabelStyle: const TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w500,
                color: AppColors.buttonBackground,
              ),
              unselectedItemColor: AppColors.textSecondary,
              unselectedLabelStyle: const TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              enableFeedback: true,
              backgroundColor: AppColors.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
