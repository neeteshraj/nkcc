import 'package:flutter/material.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/features/home/presentation/home_screen.dart';
import 'package:support/features/products/presentation/screens/products_screen.dart';
import 'package:support/features/profile/presentation/screens/profile_screen.dart';
import 'package:support/features/services/presentation/screens/services_screen.dart';

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
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.design_services),
              label: 'Services',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Products',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              tooltip: '',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          backgroundColor: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
