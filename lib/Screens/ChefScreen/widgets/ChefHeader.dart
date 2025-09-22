import 'package:cooksy/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheffDetailsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1️⃣ Background Image
        Container(
          width: double.infinity,
          height: 300,
          child: Image.asset(
            'assets/images/nonveg1.jpg', // replace with your image
            fit: BoxFit.cover,
          ),
        ),

        // 2️⃣ Dark gradient overlay
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.6), // dark at top
                Colors.transparent, // clear at bottom
              ],
            ),
          ),
        ),

        // 3️⃣ Card overlay
        Positioned(
          left: 10,
          right: 10,
          bottom: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(1, 3))],
            ),
            child: Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.08,
                  backgroundImage: AssetImage('assets/images/profile.jpg'), // replace
                ),
                SizedBox(width: 16),

                // Name, Location, and Ratings
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        "Olivia's Kitchen",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      // Location
                      Text(
                        "Soho, London",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFFA93929),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  "4.4",
                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              "98 Reviews",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Follow button
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    height: 40,
                    textColor: Colors.white,
                    text: "Follow",
                    press: () {},
                    size: 14,
                    hasIcon: false,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
