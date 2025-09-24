import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortionWidget extends StatelessWidget {
  bool isSelected;
  String value;
   PortionWidget({super.key, required this.isSelected, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFA93929) : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
