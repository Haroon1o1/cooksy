import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        onChanged: (value) {
          // setState(() {
          //   _searchQuery = value;
          // });
        },
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          isDense: true, // shrink height properly
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
          suffixIcon: Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFA93929),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset("assets/icons/filter.png", color: Colors.white, width: 16),
          ),
          hintText: "Search",
          hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade400),
          border: InputBorder.none,
          // 👇 this keeps text vertically centered
          contentPadding: const EdgeInsets.symmetric(vertical: 012, horizontal: 0),
        ),
      ),
    );
  }
}
