import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeLabel extends StatelessWidget {
  final String label;

  const TimeLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ),
    );
  }
}
