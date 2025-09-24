import 'package:cooksy/models/restaurants.dart';
import 'package:cooksy/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottomcontainer extends StatelessWidget {
  final Restaurant resturants;
  final bool isShowing;
  final  VoidCallback onTap;

  Bottomcontainer({super.key, required this.resturants, required this.isShowing,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: isShowing
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(backgroundImage: AssetImage(resturants.image), radius: 25),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olivia's Kitchen",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Soho, London",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: CustomButton(
                        height: 30,
                        textColor: Colors.white,
                        text: "Follow",
                        press: () {},
                        size: 13,
                        hasIcon: false,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Locations
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.location_on, color: Color(0xFFA93929)),
                        Container(width: 2, height: 33, color: Color(0xFF419843)),
                        Icon(Icons.location_on, color: Color(0xFF419843)),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current location",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "1901 Thornridge Cir, Shiloh, Hawaii 81063",
                            style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Office",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "2972 Westheimer Rd, Santa Ana, Illinois 85486",
                            style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        textColor: Colors.white,
                        text: "Report",
                        press: () {},
                        size: 13,
                        hasIcon: false,
                        color: Color(0xFFA93929),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        textColor: Colors.white,
                        text: "Message",
                        press: () {},
                        size: 13,
                        hasIcon: false,
                        color: Color(0xFF419843),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Expanded(
              child: CustomButton(
                height: 40,
                textColor: Colors.white,
                text: "Start Direction",
                press: onTap,
                size: 13,
                hasIcon: false,
                color: Color(0xFFA93929),
              ),
            ),
    );
  }
}
