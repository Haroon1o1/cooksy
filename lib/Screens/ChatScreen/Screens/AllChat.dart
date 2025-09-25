import 'package:cooksy/Screens/ChatScreen/Screens/ChatDetailScreen.dart';
import 'package:cooksy/Screens/ChatScreen/Widgets/chatTile.dart';
import 'package:flutter/material.dart';

class AllChatScreen extends StatelessWidget {
  const AllChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          ChatTile(
            title: "PrimeNest Partners",
            subtitle: "Real Estate Agent",
            imagePath: "assets/images/profile.jpg",
            badge: "01",
          ),
          ChatTile(
            title: "TruNest Realty",
            subtitle: "Real Estate Agent",
            imagePath: "assets/images/veg1.jpg",
            badge: "02",
          ),
          ChatTile(
            title: "OpalStone Realtors",
            subtitle: "Real Estate Agent",
            imagePath: "assets/images/veg2.jpg",
            badge: "03",
          ),
          ChatTile(
            title: "CozyNest Property",
            subtitle: "Real Estate Agent",
            imagePath: "assets/images/veg3.jpg",
            badge: "08",
          ),
          ChatTile(
            title: "Verity Homes",
            subtitle: "Real Estate Agent",
            imagePath: "assets/images/nonveg1.jpg",
            badge: "",
          ),
          ChatTile(
            title: "TruNest Realty",
            subtitle: "Real Estate Agent",
            imagePath: "assets/images/profile.jpg",
            badge: "04",
          ),
        ],
      ),
    );
  }
}
