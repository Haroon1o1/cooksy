import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pricecontainer extends StatelessWidget {
  const Pricecontainer({super.key});

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
    return  Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFA93929),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth < 350 ? 13 : 14,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: 'PKR 2000\n',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: 'per portion',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth < 350 ? 11 : 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
  }
}
