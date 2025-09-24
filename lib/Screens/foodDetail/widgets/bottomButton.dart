import 'package:cooksy/widgets/CustomButton.dart';
import 'package:flutter/material.dart';

class Bottombutton extends StatelessWidget {
  const Bottombutton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 600;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: CustomButton(
          hasIcon: false,
          height: isSmallScreen ? 45 : 50,
          textColor: Colors.white,
          text: "Add to Basket",
          press: () {},
          color: Color(0xFFA93929),
          size: 15,
        ),
      ),
    );
  }
}
