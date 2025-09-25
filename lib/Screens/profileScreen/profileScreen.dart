import 'package:cooksy/Screens/profileScreen/widget/profileCard.dart';
import 'package:cooksy/Screens/profileScreen/widget/settingsCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFA93929),
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileCard(),

                const SizedBox(height: 20),

                SettingsCard(
                  items: const [
                    {"icon": Icons.person_outline, "title": "Account Details"},
                    {"icon": Icons.info_outline, "title": "Personal Information"},
                    {"icon": Icons.brightness_6_outlined, "title": "App Theme"},
                    {"icon": Icons.lock_outline, "title": "Support"},
                    {"icon": Icons.help_outline, "title": "Help & Info"},
                  ],
                ),

                const SizedBox(height: 20),

                // Second settings card
                SettingsCard(
                  items: const [
                    {"icon": Icons.map_outlined, "title": "Change Location"},
                    {"icon": Icons.star_border, "title": "Favorited Places"},
                    {"icon": Icons.public, "title": "Country"},
                    {"icon": Icons.home_outlined, "title": "Home Type"},
                    {"icon": Icons.tune, "title": "Filter Price Range"},
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
