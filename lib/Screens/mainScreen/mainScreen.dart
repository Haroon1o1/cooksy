import 'package:cooksy/Screens/HomeScreen/homeScreen.dart';
import 'package:cooksy/Screens/mainScreen/widget/bottomNavar.dart';
import 'package:cooksy/Screens/orderHistory/orderHistory.dart';
import 'package:cooksy/Screens/profileScreen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:cooksy/Screens/NearbyScreen/Screen/Nearby.dart';
// Import other screens

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(), // index 0 → Home tab
    OrderHistoryScreen(), // index 1 → Orders tab
    NearbyScreen(), // index 2 → Nearby tab
    ProfileScreen(), // index 3 → Profile tab
    NearbyScreen(), // index 4 → Floating center button
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
