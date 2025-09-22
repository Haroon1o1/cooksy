import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavBar({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Navigation items
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem("assets/icons/home.png", "Home", 0),
                _buildNavItem("assets/icons/order.png", "Order", 1),
                SizedBox(width: 50), // space for floating button
                _buildNavItem("assets/icons/nearby.png", "Nearby", 2),
                _buildNavItem("assets/icons/profile.png", "Profile", 3),
              ],
            ),
          ),

          // Floating Center Button
          Positioned(
            top: -30,
            child: GestureDetector(
              onTap: () => onItemTapped(4), // custom index for center
              child: Container(
                padding: EdgeInsets.all(8),
                height: 70,
                width: 70,
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFA93929),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 4, // How soft the shadow is
                        offset: Offset(0, 2), // x, y offset
                      ),
                    ],
                  ),
                  child: Image.asset("assets/icons/tracking.png", color: Colors.white, width: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 24,
            color: isSelected ? Color(0xFFA93929) : Colors.grey.shade500,
          ),
          // SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Color(0xFFA93929) : Colors.grey.shade500,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
