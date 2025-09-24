import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodFeaturesTileWidget extends StatelessWidget {
  String text;
  String icon;
  bool isBg;
  FoodFeaturesTileWidget({super.key, required this.isBg, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isBg ? Color(0xFFFFF0F0) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: isBg
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isBg ? Image.asset(icon, color: Color(0xFFA93929), width: 16) : SizedBox(),
                    SizedBox(width: 4),
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Color(0xFFA93929),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : Text(text, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
        ),
      ],
    );
  }
}
