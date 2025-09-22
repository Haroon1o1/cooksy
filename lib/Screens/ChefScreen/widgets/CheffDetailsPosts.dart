import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheffDetailsPosts extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String description;

  CheffDetailsPosts({
    super.key,
    required this.name,
    required this.imgUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * 0.89,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: Offset(2, 4)),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  // Image
                  Image.asset(
                    imgUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover, // BoxFit.fill can stretch; cover looks better
                  ),

                  // Semi-transparent overlay
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.black.withValues(alpha: 0.25), // adjust opacity as needed
                  ),

                  // Centered eye icon
                  Positioned.fill(
                    child: Center(child: Icon(Icons.remove_red_eye, color: Colors.white, size: 30)),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and favorite icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA93929),
                          ),
                        ),
                      ),
                      Icon(Icons.favorite, color: Colors.red),
                    ],
                  ),
                  SizedBox(height: 6),

                  // Description (auto-expanding)
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
