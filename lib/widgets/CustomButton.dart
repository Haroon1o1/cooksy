import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final double height;
  final Color? color;
  final double size;
  Gradient? gradient;
  bool hasIcon;
  final String? icon;
  final String text;
  final Color textColor;
  final VoidCallback press;
  bool isLoading; // Add isLoading to handle loading state

  CustomButton({
    super.key,
    this.gradient,
    this.icon,
    this.hasIcon = true,
    required this.height,
    required this.textColor,
    this.color,
    required this.text,
    required this.press,
    required this.size,
    this.isLoading = false, // Default to false if not provided
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : press, // Prevent tap when loading
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
          color: color,
          border: Border.all(color: Colors.transparent),
        ),
        child: isLoading == true
            ? CircularProgressIndicator(
                color: textColor, // Make the progress indicator match the text color
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hasIcon == true ? Image.asset(icon!, width: 20, color: textColor) : SizedBox(),
                  SizedBox(width: hasIcon == true ? 10 : 0),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: size,
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
