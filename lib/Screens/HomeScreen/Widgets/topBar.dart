import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTopBar extends StatelessWidget {
   HomeTopBar({super.key});

  Widget borderedBox({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ??  EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color:  Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Location Section
        borderedBox(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/location.png",
                color:  Color(0xFFA93929),
                width: 20,
              ),
               SizedBox(width: 8),
              Text(
                "My Office",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
               Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
            ],
          ),
        ),

        /// Calendar + Notification Section
        Row(
          children: [
            borderedBox(
              padding:  EdgeInsets.all(5),
              child: Row(
                children: [
                   Icon(Icons.calendar_today, color: Color(0xFFA93929), size: 15),
                   SizedBox(width: 6),
                  Text(
                    "Today",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                   SizedBox(width: 4),
                   Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
                ],
              ),
            ),
             SizedBox(width: 8),
             Icon(Icons.notifications_outlined, color: Colors.grey, size: 20),
          ],
        ),
      ],
    );
  }
}
